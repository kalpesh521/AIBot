class chatModel {
  final String msg;
  final int chatIndex;

  chatModel({required this.msg, required this.chatIndex});

  factory chatModel.fromJson(Map<String, dynamic> json) => chatModel(
        msg: json['msg'],
        chatIndex: json['chatIndex'],
      );
}
