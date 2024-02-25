import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  List<Color> itemColors = [
    Color.fromARGB(255, 226, 255, 254),
    Color.fromARGB(255, 250, 195, 255),
    Color.fromARGB(255, 248, 226, 170),
    Color.fromARGB(255, 254, 202, 226),
    Color.fromARGB(246, 200, 200, 200),
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: itemColors[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headphones_rounded),
            label: 'Voice Chat',
            backgroundColor: itemColors[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'ImgGen',
            backgroundColor: itemColors[2],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'PDF.ai',
            backgroundColor: itemColors[3],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: itemColors[4],
          ),
        ],

        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
            // Update the background color for the tapped item
            switch (newIndex) {
              case 1:
                itemColors[newIndex] = Color.fromARGB(255, 253, 234, 255);
                break;
              case 2:
                itemColors[newIndex] = Color.fromARGB(255, 255, 246, 222);
                break;
              case 3:
                itemColors[newIndex] = Color.fromARGB(255, 255, 240, 247);
                break;
              case 4:
                itemColors[newIndex] = Color.fromRGBO(245, 245, 245, 0.966);
                break;
              default:
                itemColors[newIndex] = Theme.of(context).colorScheme.onTertiary;
            }
          });
        },
      ),
    );
  }
}
