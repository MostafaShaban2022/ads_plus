import 'package:ads_plus/services/ad_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  InterstitialAd? _interstitialAd;
  AppOpenAd? _appOpenAd;
  RewardedAd? _rewardedAd;

  void showInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdManager.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.show();
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print('Failed to load interstitial ad: $error');
          }
        },
      ),
    );
  }

  void showAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdManager.appOpenAd,
      request: const AdRequest(),
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenAd!.show();
          _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print('Failed to load app open ad: $error');
          }
        },
      ),
    );
  }

  void showRewardedAd() {
    RewardedAd.load(
      adUnitId: AdManager.rewardedAd,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
        _rewardedAd = ad;
        _rewardedAd!.show(
          onUserEarnedReward: (ad, reward) {
            if (kDebugMode) {
              print('user earned reward of ${reward.amount} ${reward.type}');
            }
          },
        );
        _rewardedAd!.fullScreenContentCallback =
            FullScreenContentCallback(
              onAdWillDismissFullScreenContent: (ad) {
          ad.dispose();
        }, 
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
        });
      }, 
      onAdFailedToLoad: (error) {
        if (kDebugMode) {
          print('Failed to load app open ad: $error');
        }
      }),
    );
  }
}
