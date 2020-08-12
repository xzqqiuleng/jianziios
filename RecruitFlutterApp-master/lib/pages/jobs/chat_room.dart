
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/chat_list.dart';
import 'package:recruit_app/pages/jobs/chat_room_intro.dart';
import 'package:recruit_app/pages/jobs/chat_row_item.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:web_socket_channel/io.dart';

class ChatRoom extends StatefulWidget {
  String reply_id;
  String user_id;
  String title;
  String head_icon;
  ChatRoom({this.reply_id,this.user_id,this.title,this.head_icon});
  @override
  _ChatRoomState createState() {
    // TODO: implement createState
    return _ChatRoomState();
  }
}

class _ChatRoomState extends State<ChatRoom> {
  List<Chat> _chatList = [];
  final ScrollController _scrollController = ScrollController();
  var channel;
  @override
  void initState() {
    super.initState();

     channel = IOWebSocketChannel.connect("${MiviceRepository.socketUrl}14243b0f437841629f840b65ffb3fbce");

    channel.stream.listen((message) {
      setState(() {
        _chatList.add(Chat(
            sender: 'images/avatar_2.png',
            content: message));
      });

    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final editController = TextEditingController();
    editController.addListener(() {});

    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('胡京茹',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(37, 38, 39, 1))),
            ],
          ),
          leading: IconButton(
              icon: Image.asset(
                'images/img_arrow_left_black.png',
                width: 20,
                height: 20,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  'images/jubao.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {}),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/ic_phone.png',
                            width: 25, height: 25, fit: BoxFit.cover),
                        SizedBox(
                          height: 3,
                        ),
                        Text('电话号',
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Color.fromRGBO(115, 116, 117, 1)))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/ic_wechat.png',
                            width: 25, height: 25, fit: BoxFit.cover),
                        SizedBox(
                          height: 3,
                        ),
                        Text('微信号',
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Color.fromRGBO(115, 116, 117, 1)))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/email.png',
                            width: 25, height: 25, fit: BoxFit.cover),
                        SizedBox(
                          height: 3,
                        ),
                        Text('邮箱',
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Color.fromRGBO(115, 116, 117, 1)))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/ic_red_cancel.png',
                            width: 25, height: 25, fit: BoxFit.cover),
                        SizedBox(
                          height: 3,
                        ),
                        Text('不感兴趣',
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Color.fromRGBO(115, 116, 117, 1)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromRGBO(241, 242, 244, 1),
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if(index==0){
                      return TopWidget();
                    }
                    if (index < (_chatList.length + 1)) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: ChatRowItem(
                          chat: index == 0
                              ? _chatList[0]
                              : _chatList[index - 1],
                          index: index,
                          isBoss: false,),
                        onTap: () {},
                      );
                    }
                    return null;
                  },
                  itemCount: _chatList.length + 1,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
//                    GestureDetector(
//                      behavior: HitTestBehavior.opaque,
//                      onTap: () {},
//                      child: Container(
//                        padding:
//                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
////                        child: Text(
////                          "常用语",
////                          style: TextStyle(
////                            fontSize: 14,
////                            color: Colors.white,
////                          ),
////                        ),
//                        decoration: new BoxDecoration(
//                          color: Color.fromRGBO(0, 188, 173, 1),
//                          borderRadius: new BorderRadius.circular(5.0),
//                        ),
//                      ),
//                    ),
                    Expanded(
                      child: TextField(
                        controller: editController,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        cursorColor: Color.fromRGBO(0, 188, 173, 1),
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromRGBO(37, 38, 38, 1)),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5.0),
                            border: InputBorder.none),
                        onSubmitted: (text) {
                          print(text);
                        },
                      ),
                    ),
//                    GestureDetector(
//                      behavior: HitTestBehavior.opaque,
//                      child: Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: Image.asset(
//                          'images/icon_replay_face.png',
//                          width: 24,
//                          height: 24,
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      behavior: HitTestBehavior.opaque,
//                      child: Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: .asset(
//                          'images/icon_increase.png',
//                          width: 24,
//                          height: 24,
//                        ),
//                      ),
//                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        SystemChannels.textInput.invokeMethod("TextInput.hide");
                         Map map = Map();
                         map["user_id"] ="14243b0f437841629f840b65ffb3fbce";
                         map["reply_id"] ="851a9c1e8e5c426bb259f5d828e8e878";
                         map["message"] =editController.text;
                         channel.sink.add(json.encode(map));
                        setState(() {
                          _chatList.add(Chat(
                              sender: 'images/avatar_14.png',
                              content: editController.text));
                          editController.text = "";
                        });


                      },
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal:18, vertical:10),
                        child: Text(
                          "发送",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        decoration: new BoxDecoration(
                          color: Colours.app_main,
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class TopWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Image.asset("images/warn_icon.png",width: 20,height: 20,),
          Text(
              "聊天需谨慎，谨防诈骗消息！"
          )
        ],
      ),
    );
  }

}