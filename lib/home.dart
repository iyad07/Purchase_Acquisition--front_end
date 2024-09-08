import 'package:flutter/material.dart';
import 'login.dart';
import 'accoutpage.dart';
import 'requests.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  
  void _updateRequests() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requestItems = [
      {
        "title": "Raise Request",
        "subtitle": "Create a request",
        "onclick": () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (BuildContext context) => const RequestsPage(),
              ))
              .then((_) => _updateRequests());
        },
      },
      {
        "title": "Request Status",
        "subtitle": "Check request status",
        "onclick": () {
        },
      },
      {
        "title": "Request History",
        "subtitle": "Sent requests",
        "onclick": () {
          
        },
      },
      {
        "title": "Approvals",
        "subtitle": "Check approved requests",
        "onclick": () {
          
          
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TotalEnergies'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'), // Replace with your logo path
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage(),
              )); // Navigate to LoginPage
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AccountPage(),
              )); // Navigate to AccountPage
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Purchase Requisition',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create a request and submit for approval.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: requestItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: requestItems[index]['onclick'],
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                requestItems[index]['title']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                requestItems[index]['subtitle']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Recent Requests',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RequestsPage(),
                          ))
                          .then((_) => _updateRequests()); // Handle see all action
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('See all'),
                  ),
                ],
              ),
              Recents(),
            ],
          ),
        ),
      ),
    );
  }
}
