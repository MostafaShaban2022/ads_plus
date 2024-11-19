import 'package:ads_plus/services/ad_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  BannerAd? bannerAD;
  bool isLoaded = false;
  void load() {
    bannerAD = BannerAd(
      size: AdSize.banner,
      adUnitId: AdManager.bannerHome,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        if (kDebugMode) {
          print('Failed to load banner ad : $error');
        }
      }),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    bannerAD?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Center(
            child: isLoaded
                ? SizedBox(
                    height: bannerAD!.size.width.toDouble(),
                    width: bannerAD!.size.width.toDouble(),
                    child: AdWidget(ad: bannerAD!),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
