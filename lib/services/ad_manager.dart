class AdManager {
  static bool isTest = true;

  static String bannerHome = isTest
      ? 'ca-app-pub-3940256099942544/9214589741'
      : 'ca-app-pub-6695947240389236/9738605904';

  static String interstitialAd = isTest
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-6695947240389236/8461915778';

  static String appOpenAd = isTest
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-6695947240389236/4231128358';
}
