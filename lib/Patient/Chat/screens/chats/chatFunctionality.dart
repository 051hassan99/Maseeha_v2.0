import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/token.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ChatFunctionality extends StatefulWidget {


 final receiverName;


  ChatFunctionality(
    this.receiverName
  ); 


  @override
  _ChatFunctionalityState createState() => _ChatFunctionalityState();
}

class _ChatFunctionalityState extends State<ChatFunctionality> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> callback(from, to) async {
    if (messageController.text.length > 0) {
      await firebaseFirestore.collection("chat").add({
        'text': messageController.text,
        'from': from,
        'to': to,
        'date': DateTime.now().toIso8601String().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.read<LoginPatientData>().getCurrentPatientData();
    final toPerson = context.read<Token>().targetUserEmail;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(58.0),
          child: Text(
            widget.receiverName,
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: firebaseFirestore
                      .collection('chat')
                      .orderBy('date')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    List<DocumentSnapshot> docs = snapshot.data.docs;

                    List<Bubble> bubbles = [];

                    docs.forEach((doc) {
                      if ((doc.data()['to'] == currentUser ||
                              doc.data()['from'] == currentUser) &&
                          (doc.data()['to'] == toPerson ||
                              doc.data()['from'] == toPerson)) {
                        bubbles.add(
                          new Bubble(
                            child: Text(
                              doc.data()['text'],
                              textAlign: currentUser == doc.data()['from']
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                            color: currentUser == doc.data()['from']
                                ? Color.fromRGBO(225, 255, 199, 1.0)
                                : null,
                            nip: currentUser == doc.data()['from']
                                ? BubbleNip.rightTop
                                : BubbleNip.leftTop,
                            margin: BubbleEdges.only(
                              top: 10,
                              left: currentUser == doc.data()['from'] ? 255 : 0,
                              right: currentUser != doc.data()['from'] ? 255 : 0,
                            ),
                          ),
                        );
                      }
                    });


                    return ListView(
                      controller: scrollController,
                      children: bubbles,
                    );
                  }),
            ),
            Container(
                child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Enter your message",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                SendButton(callback: () {
                  callback(currentUser, toPerson);
                }),
              ],
            ))
          ])),
    );
  }
}

class SendButton extends StatelessWidget {
  final VoidCallback callback;

  const SendButton({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return IconButton(
      color: Theme.of(context).primaryColor,
      onPressed: callback,
      icon: Icon(Icons.send),
    );
  }
}

