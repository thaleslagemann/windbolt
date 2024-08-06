import 'dart:convert';

class Message {
  Message({
    required this.senderUuid,
    this.receiverUuids,
    required this.content,
    required this.timestamp,
    Map<String, bool>? receivers,
    Map<String, bool>? visualizers,
  })  : receivedUuids = receivers ??
            Map.from({
              receiverUuids: false,
            }),
        visualizedUuids = visualizers ??
            Map.from({
              receiverUuids: false,
            });

  String senderUuid;
  List<String>? receiverUuids;
  String content;
  DateTime timestamp;
  Map<String, bool> receivedUuids;
  Map<String, bool> visualizedUuids;

  bool get isReceived {
    int counter = 0;
    for (var id in receivedUuids.values) {
      if (id) {
        counter++;
      }
    }
    return counter == receivedUuids.values.length;
  }

  set setReceived(String uuid) {
    receivedUuids.update(uuid, (v) => v = true);
  }

  bool get isVisualized {
    int counter = 0;
    for (var id in visualizedUuids.values) {
      if (id) {
        counter++;
      }
    }
    return counter == visualizedUuids.values.length;
  }

  set setVisualized(String uuid) {
    visualizedUuids.update(uuid, (v) => v = true);
  }

  Map<String, String?> toMap() {
    return {
      'senderUuid': senderUuid,
      'receiverUuids': jsonEncode(receiverUuids),
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'receivedUuids': jsonEncode(receivedUuids),
      'visualizedUuids': jsonEncode(visualizedUuids),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderUuid: map['senderUuid'],
      receiverUuids: map['receiverUuids'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
