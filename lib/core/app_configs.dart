class AppConfigs {
  static const localId = 'id_ID';
  static const userCollection = 'users';
  static const scheduleCollection = 'schedules';
  static const defaultCollection = 'jadwal';
  static const keySubCollection = 'key_sub_collection';
  static const keyUsername = 'key_username';
  static const formatDisplayDateSchedule = 'EEEE, d MMM y HH:mm';
  static String get genCollectionId =>
      "SC_${DateTime.now().millisecondsSinceEpoch}";
  static int get getNotifId =>
      DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
