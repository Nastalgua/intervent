import 'package:uuid/uuid.dart';
import 'package:intervent/models/message.dart';

class SimpleUser {
  final String id = Uuid().v4();
  List<String> tags = [];

  SimpleUser();
}
