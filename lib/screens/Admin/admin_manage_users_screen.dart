import 'package:flutter/material.dart';

class AdminManageUsersScreen extends StatelessWidget {
  const AdminManageUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for users and couriers
    final List<Map<String, String>> users = [
      {
        'Name': 'John Doe',
        'Email': 'john@example.com',
        'Phone': '+20 123 456 789',
        'Status': 'Active',
      },
      {
        'Name': 'Jane Smith',
        'Email': 'jane@example.com',
        'Phone': '+20 987 654 321',
        'Status': 'Active',
      },
    ];

    final List<Map<String, String>> couriers = [
      {
        'Name': 'Mike Johnson',
        'Email': 'mike@example.com',
        'Phone': '+20 111 222 333',
        'Status': 'On Delivery',
      },
      {
        'Name': 'Sarah Wilson',
        'Email': 'sarah@example.com',
        'Phone': '+20 444 555 666',
        'Status': 'Available',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Users",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Users",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              ...users.map((user) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: user.entries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "${entry.key}:",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(entry.value),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
              )).toList(),
              const SizedBox(height: 24),
              Text(
                "Couriers",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              ...couriers.map((courier) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: courier.entries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "${entry.key}:",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(entry.value),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
} 