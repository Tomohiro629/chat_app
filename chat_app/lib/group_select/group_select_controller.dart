import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupSelectControllerProvider =
    ChangeNotifierProvider<GroupSelectController>((ref) {
  return GroupSelectController(ref.read);
});

class GroupSelectController extends ChangeNotifier {
  final Reader _reader;
  GroupSelectController(this._reader);
}
