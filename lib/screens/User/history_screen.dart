import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final List<Map<String, String>> requests = [
      {
        'Status': 'In Progress',
        'Categories': 'Food, Clothes',
        'Weight': '10 kg',
        'Date': '2024-03-20',
        'Courier': 'Pending Assignment',
      },
      {
        'Status': 'Completed',
        'Categories': 'Books, Toys',
        'Weight': '5 kg',
        'Date': '2024-03-19',
        'Courier': 'Ahmed Mohamed',
      },
      {
        'Status': 'Completed',
        'Categories': 'Electronics, Books',
        'Weight': '8 kg',
        'Date': '2024-03-18',
        'Courier': 'Jane Smith',
      },
      {
        'Status': 'Completed',
        'Categories': 'Furniture',
        'Weight': '15 kg',
        'Date': '2024-03-17',
        'Courier': 'Mike Johnson',
      },
      {
        'Status': 'Completed',
        'Categories': 'Clothes, Shoes',
        'Weight': '7 kg',
        'Date': '2024-03-16',
        'Courier': 'Mohammed Seif',
      },
    ];

    return Scaffold(
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
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            final requestNumber = requests.length - index;
            
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
                          'Request #$requestNumber',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Chip(
                          label: Text(
                            request['Status']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: request['Status'] == 'Completed'
                              ? Colors.green
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    ...request.entries.map((entry) {
                      if (entry.key != 'Status') {  // Skip status as it's shown in the chip
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
                      }
                      return const SizedBox.shrink();
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