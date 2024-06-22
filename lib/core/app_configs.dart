class AppConfigs {
  static const localId = 'id_ID';
  static const defaultCollection = 'jadwal';
  static const boxUsername = 'box_username';
  static const keyUsername = 'key_username';
  static const formatDisplayDateSchedule = 'EEEE, d MMM y HH:mm';
  static String get genCollectionId =>
      "SC_${DateTime.now().millisecondsSinceEpoch}";
}
