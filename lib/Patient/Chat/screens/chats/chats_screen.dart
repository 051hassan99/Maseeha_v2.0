import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/Chat/screens/calls.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
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
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: DemoLocalization.of(context)
                              .getTranslatedValue('chats') ),
     //   BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: DemoLocalization.of(context)
                              .getTranslatedValue('calls')),
        BottomNavigationBarItem(
          icon: Icon(Icons.list
          
          ),
          label:DemoLocalization.of(context)
                              .getTranslatedValue('registeredDoctors'),
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
        child: Text( DemoLocalization.of(context)
                              .getTranslatedValue('maseehaChats'),style: TextStyle(
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
