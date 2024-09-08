import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    // Update the analyticsItems list to use the dynamic totalRequests count
    final List<Map<String, dynamic>> analyticsItems = [
      {"title": "Total requests", "count": 10, "color": Colors.blue},
      {"title": "Approved", "count": 3, "color": Colors.lightBlue},
      {"title": "Declined", "count": 3, "color": Colors.tealAccent},
      {"title": "Pending", "count": 4, "color": Colors.lightGreen},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analytics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton('Today'),
                _buildFilterButton('Week'),
                _buildFilterButton('Month'),
                _buildFilterButton('Select Date'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: analyticsItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return _buildAnalyticsCard(
                    title: analyticsItems[index]['title']!,
                    count: analyticsItems[index]['count']!,
                    color: analyticsItems[index]['color']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    return ElevatedButton(
      onPressed: () {
        // Handle filter button press
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title),
    );
  }

  Widget _buildAnalyticsCard({
    required String title,
    required int count,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: color,
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.show_chart, color: Colors.white),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
              const Spacer(),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
