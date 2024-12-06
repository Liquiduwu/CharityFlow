import 'package:flutter/material.dart';

class AdminFeedbackScreen extends StatelessWidget {
  const AdminFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy feedback data
    final List<Map<String, String>> feedbacks = [
      {
        'user': 'Ahmed Mohamed',
        'date': '2024-03-15',
        'type': 'App Issue',
        'status': 'Pending',
        'message': 'The donation confirmation takes too long to appear.',
      },
      {
        'user': 'Sara Ahmed',
        'date': '2024-03-14',
        'type': 'Suggestion',
        'status': 'Reviewed',
        'message': 'Could we have an option to schedule recurring donations?',
      },
      {
        'user': 'Mohamed Ali',
        'date': '2024-03-13',
        'type': 'Complaint',
        'status': 'In Progress',
        'message': 'Courier was late for pickup.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Feedback Management",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          final feedback = feedbacks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 2,
            child: ExpansionTile(
              title: Text(
                feedback['type']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('From: ${feedback['user']} - ${feedback['date']}'),
              trailing: _buildStatusChip(feedback['status']!),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Feedback Message:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(feedback['message']!),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle marking as reviewed
                            },
                            child: const Text('Mark as Reviewed'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Handle responding to feedback
                            },
                            child: const Text('Respond'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'reviewed':
        chipColor = Colors.green;
        break;
      case 'in progress':
        chipColor = Colors.blue;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      label: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: chipColor,
    );
  }
} 