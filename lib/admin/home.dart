import 'package:flutter/material.dart';
import '../login.dart';
import 'accoutpage.dart';
import 'requests.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
        "onclick": () {},
      },
      {
        "title": "Request History",
        "subtitle": "Sent requests",
        "onclick": () {},
      },
      {
        "title": "Approvals",
        "subtitle": "Check approved requests",
        "onclick": () {},
      },
    ];

    return Scaffold(
      //backgroundColor: Co,
      appBar: AppBar(
        title: const Text('TotalEnergies'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF007BFF), // Blue color from the logo
                Color(0xFF00CFFF), // Lighter blue for gradient effect
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Image.asset('../assets/logo.png'), // Replace with your logo path
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.help_outlined, color: Colors.red), // Red icon
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage(),
              )); // Navigate to LoginPage
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_2_outlined,
                color: Colors.orange), // Orange icon
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AccountPage(),
              )); // Navigate to AccountPage
            },
            tooltip: "Account",
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
                'Dashboard',
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
                  return _buildHoverCard(
                    requestItems[index]['title']!,
                    requestItems[index]['subtitle']!,
                    requestItems[index]['onclick'],
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
                          .then((_) =>
                              _updateRequests()); // Handle see all action
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined,
                        color: Colors.orange), // Orange icon for "See all"
                    label: const Text(
                      'See all',
                      style: TextStyle(color: Colors.orange), // Orange text
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Colors.orange), // Orange for the button
                    ),
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

  // Hover card implementation
  Widget _buildHoverCard(String title, String subtitle, Function()? onClick) {
    bool isHovered = false;

    return StatefulBuilder(builder: (context, setState) {
      return MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            gradient: isHovered
                ? const LinearGradient(
                    colors: [Colors.red, Colors.orange], // Hover effect
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white
                    ], // Default colors (red to orange)
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: InkWell(
            onTap: onClick,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: isHovered
                          ? const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                          : const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
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
    });
  }
}
