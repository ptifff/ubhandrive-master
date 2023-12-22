import 'package:flutter/material.dart';

import 'about_us.dart';

class instructorscheduling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Scheduling'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Implement logout functionality here
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              FeatureDrawerButton(icon: Icons.school, text: 'Learning', onTap: () {
                Navigator.of(context).pushNamed('/instructor_uploading');
              },),
              FeatureDrawerButton(icon: Icons.schedule, text: 'Scheduling', onTap: () {
                Navigator.of(context).pushNamed('/instructor_scheduling');
              },),
              FeatureDrawerButton(icon: Icons.track_changes, text: 'Tracking', onTap: () {
                Navigator.of(context).pushNamed('/instructor_tracking');
              },),
              FeatureDrawerButton(icon: Icons.live_help, text: 'Assistance Service', onTap: () {

              },),
              FeatureDrawerButton(icon: Icons.info, text: 'About Us', onTap: () {
                Navigator.of(context).pushNamed('/about_us');
              },),
              FeatureDrawerButton(icon: Icons.logout, text: 'Logout', onTap: () {
                Navigator.of(context).pushNamed('/login');
              },),

            ],
          ),
        )

    );
  }
}