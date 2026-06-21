import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/iap_service.dart';
import '../../core/services/audio_service.dart';
import '../../l10n/app_localizations.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  bool _isLoading = false;

  void _handlePurchase() async {
    final iap = IapService.instance;
    if (iap.isPro) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.proActive)),
      );
      return;
    }

    AudioService.instance.playTap();
    setState(() => _isLoading = true);

    final success = await iap.purchasePro();

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CryptiQ Pro Activated!')),
        );
      } else if (!iap.purchasePending) {
        // Only show error if not pending (user might have just cancelled)
      }
    }
  }

  void _handleRestore() async {
    AudioService.instance.playTap();
    setState(() => _isLoading = true);

    await IapService.instance.restorePurchases();

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.purchasesRestored ?? 'Purchases restored')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPro = IapService.instance.isPro;
    final priceStr = IapService.instance.proPriceString;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.backgroundDark,
              const Color(0xFF1A1A24),
              AppTheme.backgroundDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(l10n),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildProCard(l10n, isPro, priceStr),
                      const SizedBox(height: 40),
                      TextButton(
                        onPressed: _isLoading ? null : _handleRestore,
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.textSecondary,
                        ),
                        child: Text(
                          l10n.restorePurchases ?? 'Restore Purchases',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Loading overlay
      floatingActionButton: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppTheme.primaryColor),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () {
              AudioService.instance.playTap();
              context.pop();
            },
          ),
          const SizedBox(width: 8),
          Text(
            l10n.storeTitle ?? 'Store',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProCard(AppLocalizations l10n, bool isPro, String priceStr) {
    return Container(
      decoration: AppTheme.glassDecoration(
        borderRadius: 24,
      ).copyWith(
        color: isPro
            ? Colors.green.withValues(alpha: 0.1)
            : const Color(0xFFD4A843).withValues(alpha: 0.15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isPro
                ? Colors.green.withValues(alpha: 0.3)
                : const Color(0xFFD4A843).withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              isPro ? Icons.verified_rounded : Icons.workspace_premium_rounded,
              color: isPro ? Colors.green : const Color(0xFFD4A843),
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              isPro ? l10n.proActive : l10n.goPro,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              isPro
                  ? (l10n.proActiveDesc ?? 'All premium features unlocked!')
                  : (l10n.proDesc ?? 'Remove all ads forever and support the developer.'),
              style: TextStyle(
                fontSize: 15,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isPro || _isLoading ? null : _handlePurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPro ? Colors.green.shade800 : const Color(0xFFD4A843),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.green.shade900.withValues(alpha: 0.5),
                  disabledForegroundColor: Colors.white70,
                  elevation: isPro ? 0 : 8,
                  shadowColor: const Color(0xFFD4A843).withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isPro ? (l10n.purchased ?? 'Purchased') : priceStr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
