import 'package:flutter/material.dart';
import 'package:form_acquistion/request_handler.dart';
import '../login.dart';
import 'accoutpage.dart';
import 'request_history.dart';
import 'request_status.dart';
import 'approved_requests.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void addtoRequests(BuildContext context) {
    if (requestTitle.text.isEmpty ||
        requestDescrip.text.isEmpty ||
        quantity.text.isEmpty ||
        unitOfMeasurement.text.isEmpty ||
        deliveryPlace.text.isEmpty ||
        deliveryDate.text.isEmpty ||
        document.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill out all fields"),
          backgroundColor: Colors.red,
        ),
      );
      
    }
    setState(() {
        requests.insert(
            0,
            Requests(
                title: requestTitle.text,
                date: DateTime.now().toString(),
                description: requestDescrip.text,
                quantity: quantity.text,
                unitOfMeasurement: unitOfMeasurement.text,
                deliveryPlace: deliveryPlace.text,
                deliveryDate: deliveryDate.text,
                document: document.text));
      });
      _clearInputFields();
      Navigator.of(context).pop();
  }

  void _clearInputFields() {
    requestTitle.clear();
    requestDescrip.clear();
    quantity.clear();
    unitOfMeasurement.clear();
    deliveryPlace.clear();
    deliveryDate.clear();
    document.clear();
  }

  @override
  Widget build(BuildContext context) {
    void updateRequests() {
      setState(() {});
    }
    final List<Map<String, dynamic>> requestItems = [
      {
        "title": "Raise Request",
        "subtitle": "Create and submit a request",
        "onclick": () {
          return popCreateDialog(context, () {
            addtoRequests(context);
          });
        },
      },
      {
        "title": "Request Status",
        "subtitle": "Check request status",
        "onclick": () {
          return Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const RequestStatusPage(),
            ),
          );
        },
      },
      {
        "title": "Request History",
        "subtitle": "Sent requests",
        "onclick": () {
          return Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const RequestsPage(),
            ),
          ).then((_) => updateRequests());
        },
      },
      {
        "title": "Approvals",
        "subtitle": "Check approved requests",
        "onclick": () {return Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const ApprovedRequestPage(),
            ),
          ).then((_) => updateRequests());},
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TotalEnergies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
          child: Image.asset('../assets/logo.png'),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.help_outlined, color: Colors.red), // Red icon
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage(),
              )); // Navigate to LoginPage
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_2_outlined,
                color: Colors.redAccent), // redAccent icon
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
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RequestsPage(),
                        ),
                      );
                      // Handle see all action
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    // redAccent icon for "See all"
                    label: const Text(
                      'See all',
                      // redAccent text
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Colors.red), // redAccent for the button
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return buildPendingCard(context,requests, index);
                  } //pandable to fill the screen
                  ),
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
            /*gradient: isHovered
                ? const LinearGradient(
                    colors: [Colors.red, Colors.redAccent], // Hover effect
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white
                    ], // Default colors (red to redAccent)
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),*/
            color: isHovered ? Colors.red : Colors.white,
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                          : const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: isHovered
                        ? const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          )
                        : const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
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
