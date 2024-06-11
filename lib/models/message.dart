class Message {
  Message({required this.senderId, this.receiverIds, required this.content, required this.timestamp});

  int senderId;
  List<int>? receiverIds;
  String content;
  DateTime timestamp;
  bool received = false;
  bool visualized = false;

  bool get isReceived {
    return received;
  }

  set setReceived(bool rec) {
    received = rec;
  }

  bool get isVisualized {
    return visualized;
  }

  set setVisualized(bool rec) {
    visualized = rec;
  }
}
