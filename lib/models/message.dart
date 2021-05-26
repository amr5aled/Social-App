class MessageModel {
  String dataTime;
  String receiveId;
  String senderId;
  String text;

  MessageModel({
    this.dataTime,
    this.receiveId,
    this.senderId,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    receiveId = json['receiveId'];
    senderId = json['SenderId'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dataTime': dataTime,
      'receiveId': receiveId,
      'SenderId': senderId,
      'text':text,
    };
  }
}
