
class Message {
  final String userId;
  final String body;

  Message({
    required this.userId,
    required this.body
  });

  static Message fromJSON(Map<String, dynamic> json) => Message(
    userId: json['userId'],
    body: json['body']
  );

  Map<String, dynamic> toJSON() => {
    'userId': this.userId,
    'body': this.body
  };
}
