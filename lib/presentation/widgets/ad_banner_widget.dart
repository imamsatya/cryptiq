import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/services/ad_service.dart';
import '../../core/theme/app_theme.dart';

class AdBannerWidget extends StatefulWidget {
  final AdSize size;

  const AdBannerWidget({super.key, this.size = AdSize.banner});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    AdService.instance.loadBanner(
      size: widget.size,
      onLoaded: (success) {
        if (mounted) {
          setState(() {
            _isLoaded = success;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (AdService.instance.isPro || !AdService.instance.isInitialized) {
      return const SizedBox.shrink();
    }

    if (kIsWeb) {
      return Container(
        height: widget.size.height.toDouble(),
        width: widget.size.width.toDouble(),
        color: Colors.black26,
        alignment: Alignment.center,
        child: Text(
          'Mock Ad Banner\n(Hidden in Pro Mode)',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (!_isLoaded || AdService.instance.bannerAd == null) {
      return SizedBox(
        height: widget.size.height.toDouble(),
        width: widget.size.width.toDouble(),
      );
    }

    return Container(
      alignment: Alignment.center,
      width: widget.size.width.toDouble(),
      height: widget.size.height.toDouble(),
      child: AdWidget(ad: AdService.instance.bannerAd!),
    );
  }
}
