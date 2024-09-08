import 'package:flutter/material.dart';

final TextEditingController _requestTitle = TextEditingController();
final TextEditingController _requestDescrip = TextEditingController();

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
                    "date": DateTime.now().toString(), // Replace with formatted date
                    "description": _requestDescrip.text,
                  });
                  _requestTitle.clear(); // Clear the input fields
                  _requestDescrip.clear();
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
                      ),
                    ),
                    icon: const Icon(Icons.create),
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
              // Handle recent request tap if needed
            },
          ),
        );
      },
    );
  }
}
