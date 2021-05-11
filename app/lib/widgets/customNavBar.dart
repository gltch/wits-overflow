import 'package:flutter/material.dart';

class customNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Thabiso kobe"),
            accountEmail: Text("kobethabiso360@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profilepic.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                image: AssetImage('assets/images/backround.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () => null),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () => null),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () => null),
        ],
      ),
    );
  }
}
