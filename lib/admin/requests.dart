import 'package:flutter/material.dart';

final TextEditingController _requestTitle = TextEditingController();
final TextEditingController _requestDescrip = TextEditingController();
final TextEditingController _quantity = TextEditingController();
final TextEditingController _unitOfMeasurement = TextEditingController();
final TextEditingController _deliveryPlace = TextEditingController();
final TextEditingController _deliveryDate = TextEditingController();
final TextEditingController _document = TextEditingController();

final List<Map<String, String>> recentRequests = [
  // Add more recent reports here if needed
];

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  void _create(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Request'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _requestTitle,
                  decoration: const InputDecoration(
                    label: Text("Request Title"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _requestDescrip,
                  decoration: const InputDecoration(
                    label: Text("Description"),
                  ),
                ),
                TextField(
                  controller: _quantity,
                  decoration: const InputDecoration(
                    label: Text("Quantity Requested"),
                  ),
                ),
                TextField(
                  controller: _unitOfMeasurement,
                  decoration: const InputDecoration(
                    label: Text("Unit Of Measurement"),
                  ),
                ),
                TextField(
                  controller: _deliveryPlace,
                  decoration: const InputDecoration(
                    label: Text("Delivery Place"),
                  ),
                ),
                TextField(
                  controller: _deliveryDate,
                  decoration: const InputDecoration(
                    label: Text("Delivery Date"),
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.attach_file),
                  label: const Text("Attach Document or Picture"),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                setState(() {
                  recentRequests.insert(0, {
                    "title": _requestTitle.text,
                    "date": DateTime.now()
                        .toString(), // Replace with formatted date
                    "description": _requestDescrip.text,
                    "quantity": _quantity.text,
                    "unitOfMeasurement": _unitOfMeasurement.text,
                    "del_place": _deliveryPlace.text,
                    "del_date": _deliveryDate.text,
                    "document": _document.text,
                  });
                  _requestTitle.clear(); // Clear the input fields
                  _requestDescrip.clear();
                  _deliveryDate.clear();
                  _deliveryPlace.clear();
                  _quantity.clear();
                  _document.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requests"),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Requests',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _create(context),
                    label: const Text(
                      'Create Request',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    icon: const Icon(
                      Icons.create,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Recents(), // Make Recents expandable to fill the screen
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return _create(context);
        },
        tooltip: "Create Request",
        backgroundColor: Colors.red,
        child: const Icon(Icons.add), // Floating button with solid red color
      ),
    );
  }
}

class Recents extends StatefulWidget {
  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: recentRequests.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
              title: Text(recentRequests[index]['title']!),
              subtitle: Text(recentRequests[index]['description']!),
              trailing: Text(recentRequests[index]['date']!),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Request Details'),
                      content: SingleChildScrollView(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title: ${recentRequests[index]['title']!}"),
                              Text(
                                  "Description: ${recentRequests[index]['description']!}"),
                              Text(
                                  "Quanttity Requested: ${recentRequests[index]['quantity']!}"),
                              Text(
                                  "Unit Of Measurement: ${recentRequests[index]['unitOfMeasurement']!}"),
                              Text(
                                  "Delivery Place: ${recentRequests[index]['del_place']!}"),
                              Text(
                                  "Delivery Date: ${recentRequests[index]['del_date']!}"),
                              Text(
                                  "Document Attached: ${recentRequests[index]['document']!}"),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
        );
      },
    );
  }
}
