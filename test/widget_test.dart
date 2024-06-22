// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

void main() async {
  //1719044315884635
  final now = DateTime.now();
  final id = now.millisecondsSinceEpoch.toString();
  print(id);
  final scheduleId = "SC_${DateTime.now().millisecondsSinceEpoch}";

  print(scheduleId);
}
