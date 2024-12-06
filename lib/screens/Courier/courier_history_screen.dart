import 'package:flutter/material.dart';

class CourierHistoryScreen extends StatelessWidget {
  const CourierHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Expanded dummy data with more requests and varied dates
    final List<Map<String, String>> requests = [
      {
        'Request': 'Food Donation',
        'Date': '2023-01-15',
      },
      {
        'Request': 'Medical Supplies',
        'Date': '2023-02-20',
      },
      {
        'Request': 'Clothing',
        'Date': '2023-03-10',
      },
      {
        'Request': 'Books',
        'Date': '2023-04-05',
      },
      {
        'Request': 'Toys',
        'Date': '2023-05-25',
      },
      {
        'Request': 'Blood Donation',
        'Date': '2023-06-30',
      },
      {
        'Request': 'Hygienic Products',
        'Date': '2023-07-18',
      },
      {
        'Request': 'Bedding',
        'Date': '2023-08-22',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.request_page,
              color: Theme.of(context).colorScheme.secondary),
            title: Text(request['Request']!),
            subtitle: Text('Date: ${request['Date']}'),
            trailing: Icon(Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary),
            onTap: () {
              // Handle request tap
            },
          ),
        );
      },
    );
  }
} 