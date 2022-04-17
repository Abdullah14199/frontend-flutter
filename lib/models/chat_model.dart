
class IdChat{
  String? id;
  ChatModel? chatModel;
  IdChat({this.chatModel,this.id});



}


class ChatModel {
  String? booking_id;
  String? message;
  String? receiver;
  String? receiverUid;
  String? sender;
  String? senderUid;
  String? time;
  int? timeStamp;

  ChatModel({
    this.time,
    this.message,
    this.booking_id,
    this.receiver,
    this.receiverUid,
    this.sender,
    this.senderUid,
    this.timeStamp,
  });


  ChatModel.fromJson(Map<dynamic,dynamic>json){

    booking_id = json['booking_id'];
    time = json['time'];
    message = json['message'];
    receiver = json['receiver'];
    receiverUid = json['receiverUid'];
    sender = json['sender'];
    timeStamp = json['timeStamp'];
    senderUid = json['senderUid'];
  }
  Map<String,dynamic>toJson(){
    return{
      'booking_id':booking_id,
      'time':time,
      'message':message,
      'receiver':receiver,
      'sender':sender,
      'receiverUid':receiverUid,
      'timeStamp':timeStamp,
      'senderUid':senderUid,
    };
  }


}
