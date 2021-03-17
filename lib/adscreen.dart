import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdScreen extends StatefulWidget {
  @override
  _AdScreenState createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  RewardedAd rewardedAd;
  InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
  }

  void loadVideoAd () async {
    rewardedAd = RewardedAd(
      adUnitId: RewardedAd.testAdUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          rewardedAd.show();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) => print('Left application.'),
        // Called when a RewardedAd triggers a reward.
        onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
          print('Reward earned: $reward');
        },
      ),
    );

    rewardedAd.load();
  }

  void loadInterstitial () async {
    interstitialAd = InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          interstitialAd.show();
        },
        onAdClosed: (Ad ad) {
          interstitialAd.dispose();
        }
      ),
    );

    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                loadVideoAd();
              },
              child: Text("Show Video Ad"),
            ),
            FlatButton(
              onPressed: () {
                loadInterstitial();
              },
              child: Text("Show Interstitial Ad"),
            ),
          ],
        ),
      ),
    );
  }
}
