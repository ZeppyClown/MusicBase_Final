import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMainScreen extends StatefulWidget {
  UserModel user;
  ChatMainScreen(this.user);

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat Screen"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
            // check in users if theres any messages
                .collection('users')
                .doc(widget.user.uid)
                .collection('messages')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
               if (snapshot.data.docs.length < 1) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No conversations yet',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Search for a user to start chatting',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      // show user that chat the user's image, name and last message 
                      var friendId = snapshot.data.docs[index].id;
                      var lastMsg = snapshot.data.docs[index]['last_msg'];
                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(friendId)
                            .get(),
                        builder: (context, AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasData) {
                            var friend = asyncSnapshot.data;
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: CircleAvatar(
                                  child: Image.network(friend['image']),
                                ),
                              ),
                              title: Text(friend['username']),
                              subtitle: Container(
                                child: Text(
                                  "$lastMsg",
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              currentUser: widget.user,
                                              friendId: friend["uid"],
                                              friendUsername:
                                                  friend["username"],
                                              friendImage: friend["image"],
                                            )));
                              },
                            );
                          }
                          return LinearProgressIndicator();
                        },
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          // push to search screen
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SearchScreen(widget.user))));
          },
        ));
  }
}
