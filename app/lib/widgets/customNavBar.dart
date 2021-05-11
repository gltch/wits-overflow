import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      //Add your code for the side bar in here

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
              leading: Icon(Icons.portrait_rounded),
              title: Text('User details'),
              onTap: () => null),
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favourites'),
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
