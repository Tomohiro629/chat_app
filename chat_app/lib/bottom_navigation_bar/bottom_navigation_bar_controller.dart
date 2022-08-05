import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationBarControllerProvider =
    StateNotifierProvider<BottomNavigationBarController, int>((ref) {
  return BottomNavigationBarController();
});

class BottomNavigationBarController extends StateNotifier<int> {
  BottomNavigationBarController() : super(0);

  void changeIndex(int index) {
    state = index;
  }
}
