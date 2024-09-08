import 'package:flutter/material.dart';
import 'login.dart';
import 'analyticss.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          TextButton.icon(
            onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage())); // Handle log out action
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            label: const Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Profile'),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle profile tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.black),
            title: const Text('Reports Summary'),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle reports summary tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics, color: Colors.black),
            title: const Text('Analytics'),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AnalyticsPage()));// Handle analytics tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.black),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle change password tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.black),
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle about tap
            },
          ),
        ],
      ),
    );
  }
}
