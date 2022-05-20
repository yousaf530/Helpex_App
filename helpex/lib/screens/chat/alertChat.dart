import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:images_picker/images_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import 'WriteMessageService.dart';
import 'fullPhoto.dart';

class AdviseeChat extends StatefulWidget {
  final String otherUserID;
  const AdviseeChat({Key? key, required this.otherUserID}) : super(key: key);

  @override
  State<AdviseeChat> createState() => _AlertChatState();
}

class _AlertChatState extends State<AdviseeChat> {
  List<QueryDocumentSnapshot> listMessage = [];

   final MyUser currentUser = MyUser.getMyUser();


  bool isLoading = false;

  String imageUrl = "";
int _limit=20;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();


  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += 20;
      });
    }
  }



@override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    listScrollController.addListener(_scrollListener);
  }
  Future<void> retrieveLostData() async {

  }

  Future getImage() async {

      try {
        List<Media>? res = await ImagesPicker.pick(
          count: 1,
          pickType: PickType.all,
          language: Language.System,
          maxTime: 30,
          // maxSize: 500,
          cropOpt: CropOption(
            // aspectRatio: CropAspectRatio.wh16x9,
            cropType: CropType.circle,
          ),
        );



        if (res != null) {
          print(res[0].path);



            setState(() {
              isLoading = true;
            });
            uploadFile(res[0].path);

        }
      } on PlatformException
      catch (e) {
        setState(() {
          isLoading = false;
        });
      }
  }

  Future getImageCamera() async {
    try {
      List<Media>? res = await ImagesPicker.openCamera(
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 800,
        maxTime: 800,
        // maxSize: 500,

      );
      if (res != null) {
        print(res[0].path);

        setState(() {
          isLoading = true;
        });
        uploadFile(res[0].path);

      }
    } on PlatformException
    catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future uploadFile(String path) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = WriteMessageService.uploadFile(path, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 0);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      WriteMessageService.sendMessage(content,type,currentUser.uid!,widget.otherUserID,currentUser.name!);
      listScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      print("Nothing to send");
    }
  }


  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {

      if (document.get("senderID") == currentUser.uid!) {
        // Right (my message)
        return Column(
          children: [
            Row(
              children: <Widget>[
                document.get("type") == 1
                // Text
                    ? Container(
                  child: Text(
                    document.get("content"),
                    style: TextStyle(color: Colors.black),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                 
                ):Container(
                  child: OutlinedButton(
                    child: Material(
                      child: Image.network(
                        document.get("content"),
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            width: 200,
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, object, stackTrace) {
                          return Material(
                            child: Image.asset(
                              'assets/img_not_available.jpeg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            clipBehavior: Clip.hardEdge,
                          );
                        },
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullPhotoPage(
                            url: document.get("content"),
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
                  ),
                
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            Container(
              child: Text(
                DateFormat('dd MMM kk:mm')
                    .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.get("timestamp")))),
                style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.only(left: 50, top: 0, bottom: 5),
            )
          ],
        );
      } else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 25.0,
                    child: Text(
                      "${document.get("name")[0]}",
                      style: TextStyle(fontSize: 30.0,color: Colors.white),
                    ),
                  ),
                  Container(width: 10),
                  document.get("type")== 1
                      ? Container(
                    child: Text(
                      document.get("content"),
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration:
                    BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 10),
                  )
                     : Container(
                    child: TextButton(
                      child: Material(
                        child: Image.network(
                          document.get("content"),
                          loadingBuilder:
                              (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              width: 200,
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) => Material(
                            child: Image.asset(
                              'assets/img_not_available.jpeg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPhotoPage(
                              url: document.get("content"),
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
                    ),
                    margin: EdgeInsets.only(left: 10),
                  )
                ],
              ),
              Container(
                child: Text("by: "+document.get("name"),
                    style: TextStyle(color: Colors.green, fontSize: 12, fontStyle: FontStyle.italic)),
                margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
              ),
              Container(
                child: Text(
                  DateFormat('dd MMM kk:mm')
                      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.get("timestamp")))),
                  style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
                ),
                margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }


  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
        stream: WriteMessageService.getChatStream(widget.otherUserID,currentUser.uid!,_limit),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            listMessage = snapshot.data!.docs;
            if (listMessage.length > 0) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) => buildItem(index, snapshot.data?.docs[index]),
                itemCount: snapshot.data?.docs.length,
                reverse: true,
                controller: listScrollController,
              );
            } else {
              return Center(child: Text("No message here yet..."));
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        },
      )
      );
  }


  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
                color: Colors.green,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.camera),
                onPressed: getImageCamera,
                color: Colors.green,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 1);
                },
                style: TextStyle(color: Colors.green, fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 1),
                color: Colors.green,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
    );
  }


  Widget buildLoading() {
    return Positioned(
      child: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
        color: Colors.white.withOpacity(0.8),
      ): SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            // List of messages
            buildListMessage(),

            // Input content
            buildInput(),
          ],
        ),

        // Loading
        buildLoading()
      ],
    );
  }



}
