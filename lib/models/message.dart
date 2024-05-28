class Message {
  int senderId;
  int? receiverId;
  String content;
  DateTime timestamp;

  Message({required this.senderId, this.receiverId, required this.content, required this.timestamp});
}
