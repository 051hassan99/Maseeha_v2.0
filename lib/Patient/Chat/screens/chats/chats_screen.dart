import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/Chat/screens/calls.dart';
import 'components/chatList.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: screenReturn(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats" ),
     //   BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: Icon(Icons.list
          
          ),
          label: "Registerd Doctors",
        ),
      ],
    );
  }


  Widget screenReturn(){
    Widget widget;

    if(_selectedIndex == 2)

      widget = ChatList();
    
    else if(_selectedIndex==1)

        widget = Calls();
    
    return widget;

  }

  AppBar buildAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text("Maseeha Chats",style: TextStyle(
             fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
             fontWeight: FontWeight.bold
        ),),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
