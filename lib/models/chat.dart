import 'package:intervent/models/message.dart';
import 'package:uuid/uuid.dart';
import 'package:intervent/models/message.dart';

class Chat {
  final String id = Uuid().v4();
  final String to;
  final String createdAt = DateTime.now().toString();
  List<Message> messages = [];

  Chat({
    required this.to
  });

}
