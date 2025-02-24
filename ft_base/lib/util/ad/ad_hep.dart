class AdHep{
  static final AdHep _instance = AdHep();
  static AdHep get instance=>_instance;

  showAd({
    required Function() closeAd,
}){
    closeAd.call();
  }
}