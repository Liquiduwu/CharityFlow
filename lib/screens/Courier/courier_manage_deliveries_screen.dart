import 'package:flutter/material.dart';

class CourierManageDeliveriesScreen extends StatelessWidget {
  const CourierManageDeliveriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data representing donation information
    final List<Map<String, String>> donations = [
      {
        'Categories': 'Food, Clothes',
        'Weight': '10 kg',
        'Description': 'Canned goods and winter clothes',
        'Order Time': '10:00 AM',
        'Payment Method': 'Cash',
      },
      {
        'Categories': 'Books, Toys',
        'Weight': '5 kg',
        'Description': 'Children\'s books and toys',
        'Order Time': '2:00 PM',
        'Payment Method': 'Credit Card',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Deliveries",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: donations.length,
          itemBuilder: (context, index) {
            final donation = donations[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Donation #${index + 1}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add action for accepting delivery
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Accept Delivery'),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    ...donation.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Text(
                                '${entry.key}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 