import 'package:flutter_riverpod/flutter_riverpod.dart';

final localUserDataSourceProvider = Provider<LocalUserDataSource>((_) {
  return LocalUserDataSource();
});

class LocalUserDataSource {}
