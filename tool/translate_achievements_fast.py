import json
import os
import glob
from deep_translator import GoogleTranslator
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

achievements = {
    "achvFirstSolve": {"title": "First Steps", "desc": "Solve your first puzzle"},
    "achvTenLevels": {"title": "Getting Warmed Up", "desc": "Complete 10 levels"},
    "achvFiftyLevels": {"title": "Puzzle Enthusiast", "desc": "Complete 50 levels"},
    "achvHundredLevels": {"title": "Centurion", "desc": "Complete 100 levels"},
    "achvFiveHundredLevels": {"title": "Half Way There", "desc": "Complete 500 levels"},
    "achvThousandLevels": {"title": "Grand Master", "desc": "Complete 1000 levels"},
    "achvTenStars": {"title": "Star Collector", "desc": "Earn 10 stars"},
    "achvHundredStars": {"title": "Star Hunter", "desc": "Earn 100 stars"},
    "achvThousandStars": {"title": "Constellation", "desc": "Earn 1000 stars"},
    "achvSpeedDemon": {"title": "Speed Demon", "desc": "Solve a puzzle in under 15 seconds"},
    "achvLightning": {"title": "Lightning Fast", "desc": "Solve a puzzle in under 10 seconds"},
    "achvNoHints10": {"title": "Sharp Mind", "desc": "Solve 10 puzzles without hints"},
    "achvNoHints50": {"title": "Pure Genius", "desc": "Solve 50 puzzles without hints"},
    "achvPerfect10": {"title": "Perfectionist", "desc": "Get 3 stars on 10 levels"},
    "achvPerfect50": {"title": "Flawless", "desc": "Get 3 stars on 50 levels"},
    "achvEasyMaster": {"title": "Easy Peasy", "desc": "Complete all Easy levels"},
    "achvMediumMaster": {"title": "Medium Rare", "desc": "Complete all Medium levels"},
    "achvHardMaster": {"title": "Hardened", "desc": "Complete all Hard levels"},
    "achvExpertMaster": {"title": "Expert Cryptographer", "desc": "Complete all Expert levels"},
    "achvStreak3": {"title": "On a Roll", "desc": "3 day daily challenge streak"},
    "achvStreak7": {"title": "Week Warrior", "desc": "7 day daily challenge streak"},
    "achvStreak14": {"title": "Two Week Champion", "desc": "14 day daily challenge streak"},
    "achvStreak30": {"title": "Streak Master", "desc": "30 day daily challenge streak"},
    "achvStreak100": {"title": "Unstoppable", "desc": "100 day daily challenge streak"},
    "achvMultiStepFirst": {"title": "Chain Reaction", "desc": "Solve your first multi-step puzzle"},
    "achvMultiStepAll": {"title": "Cascade King", "desc": "Complete all 200 multi-step puzzles"}
}

def get_language_code(filename):
    basename = os.path.basename(filename)
    return basename.replace('app_', '').replace('.arb', '')

def translate_text(text, target_lang):
    if target_lang == 'en':
        return text
    if target_lang == 'zh':
        target_lang = 'zh-CN'
    
    for attempt in range(5):
        try:
            translator = GoogleTranslator(source='en', target=target_lang)
            return translator.translate(text)
        except Exception as e:
            time.sleep(1)
            if attempt == 4:
                print(f"Failed to translate '{text}' to {target_lang}: {e}")
                return text

def process_file(arb_file):
    lang = get_language_code(arb_file)
    if lang == 'localizations':
        return f"Skipped {arb_file}"
        
    print(f"Processing {arb_file} (lang: {lang})...")
    with open(arb_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
        
    updated = False
    
    # We will collect tasks
    translations_needed = []
    
    for key_base, texts in achievements.items():
        title_key = f"{key_base}Title"
        desc_key = f"{key_base}Desc"
        
        if title_key not in data:
            translations_needed.append((title_key, texts['title']))
        if desc_key not in data:
            translations_needed.append((desc_key, texts['desc']))
            
    if not translations_needed:
        return f"No updates needed for {arb_file}"
        
    # Translate concurrently for this file
    def do_translation(item):
        k, text = item
        return k, translate_text(text, lang)
        
    with ThreadPoolExecutor(max_workers=10) as executor:
        future_to_key = {executor.submit(do_translation, item): item for item in translations_needed}
        for future in as_completed(future_to_key):
            k, translated = future.result()
            data[k] = translated
            updated = True
            
    if updated:
        with open(arb_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        return f"Saved {arb_file}"

arb_files = glob.glob('lib/l10n/app_*.arb')
with ThreadPoolExecutor(max_workers=5) as file_executor:
    futures = [file_executor.submit(process_file, f) for f in arb_files]
    for future in as_completed(futures):
        print(future.result())

print("All translations complete!")
