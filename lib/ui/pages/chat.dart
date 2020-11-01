import 'package:final_project/services/FireStore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  QuerySnapshot allMess;
  String message = "";

  Fire f;

  final _key = GlobalKey<FormState>();

  Widget showData() {
    if (allMess != null && allMess.docs != null) {
      return ListView.builder(
          itemCount: allMess.docs.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Container(
                    child: Form(
                      key: _key,
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          onSaved: (val) {
                            setState(() {
                              this.message = val;
                            });
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF2C475B))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF2C475B))),
                              hintText: "Enter your Message",
                              hintStyle: TextStyle(color: Color(0xFF2C475B)),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Color(0xFF2C475B),
                                  ),
                                  onPressed: () async {
                                    _key.currentState.save();
                                    refreshChatData();
                                    sendMessage();

                                    //  sendMessage();
                                  })),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${allMess.docs[index].get("send_by")}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${allMess.docs[index].get("date-time")}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text('${allMess.docs[index].get("message")}',
                              style: TextStyle(
                                  color: Color(0xFF2C475B),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),

                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${allMess.docs[index].get("send_by")}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${allMess.docs[index].get("date-time")}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('${allMess.docs[index].get("message")}',
                          style: TextStyle(
                              color: Color(0xFF2C475B),
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              );
            }
          });
    } else if (allMess != null && allMess.docs.length == 0) {
      return Text('');
    } else {
      return (Text(""));
    }
  }

  chatData() async {
    return await FirebaseFirestore.instance
        .collection("Chat")
        .orderBy('date-time')
        .get();
  }

  Future<void> sendMessage() async {
    setState(() {
      if (this.message.isNotEmpty) {
        DateTime now = DateTime.now();
        String formatted = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
        FirebaseFirestore.instance.collection("Chat").add({
          "message": message,
          "date-time": formatted,
          "send_by": FirebaseAuth.instance.currentUser.email
        });
      }
    });
  }

  refreshChatData() {
    chatData();
    chatData().then((data) {
      setState(() {
        allMess = data;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshChatData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color(0xFF2C475B),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset("images/education.png"),
            ),
            Text(
              "Chat",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "first");
              })
        ],
      ),
      body: showData(),
    );
  }
}
