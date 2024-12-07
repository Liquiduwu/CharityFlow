import 'package:flutter/material.dart';

class SavedBillingsScreen extends StatelessWidget {
  const SavedBillingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for saved cards
    final List<Map<String, String>> savedCards = [
      {
        'cardType': 'Visa',
        'cardNumber': '**** **** **** 1234',
        'expiryDate': '12/25',
        'cardHolderName': 'John Doe',
      },
      {
        'cardType': 'Mastercard',
        'cardNumber': '**** **** **** 5678',
        'expiryDate': '09/24',
        'cardHolderName': 'John Doe',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Billings'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: savedCards.length,
              itemBuilder: (context, index) {
                final card = savedCards[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Icon(
                      card['cardType'] == 'Visa' ? Icons.credit_card : Icons.credit_card,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      card['cardNumber']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text('Expires: ${card['expiryDate']}'),
                        Text(card['cardHolderName']!),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                      onSelected: (value) {
                        // Handle edit or delete
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle adding new card
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add New Card'),
            ),
          ),
        ],
      ),
    );
  }
} 