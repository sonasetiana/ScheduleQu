class AppConfigs {
  static const defaultCollection = 'jadwal';
  static const boxUsername = 'box_username';
  static const keyUsername = 'key_username';
  static String get genCollectionId =>
      "SC_${DateTime.now().millisecondsSinceEpoch}";
}
