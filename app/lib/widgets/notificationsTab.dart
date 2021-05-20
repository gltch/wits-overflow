import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  @override
  _NotificationsTab createState() => _NotificationsTab();
}

class _NotificationsTab extends State<NotificationsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Notifications")),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_active,
              size: 64,
            ),
            Text(
              'Notifications',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
