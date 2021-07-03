import 'package:uuid/uuid.dart';

class Message {
  final String id = Uuid().v4();
  final String userId;
  final String body;

  Message({
    required this.userId,
    required this.body
  });

}
