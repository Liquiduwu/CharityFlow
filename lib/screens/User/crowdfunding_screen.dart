import 'package:flutter/material.dart';
import 'make_donation_screen.dart';

class CrowdfundingScreen extends StatelessWidget {
  const CrowdfundingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration with Egyptian names and EGP
    final double totalFunds = 775000.0;  // Changed to EGP
    final double monthlyDonations = 155000.0;  // Changed to EGP
    final List<Map<String, dynamic>> recentDonations = [
      {
        'name': 'Mohamed Ahmed',
        'amount': 3000.0,
        'date': '2024-03-20',
      },
      {
        'name': 'Amira Hassan',
        'amount': 7500.0,
        'date': '2024-03-19',
      },
      {
        'name': 'Omar Mahmoud',
        'amount': 15000.0,
        'date': '2024-03-18',
      },
      {
        'name': 'Nour Ibrahim',
        'amount': 5000.0,
        'date': '2024-03-17',
      },
    {
      'name': 'Ahmed Kamal',
      'amount': 10000.0,
      'date': '2024-03-16',
    },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crowdfunding",
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total Funds Collected',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${totalFunds.toStringAsFixed(2)} EGP',  // Changed to EGP
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Monthly Donations: ${monthlyDonations.toStringAsFixed(2)} EGP',  // Changed to EGP
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Donations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: recentDonations.length,
                  itemBuilder: (context, index) {
                    final donation = recentDonations[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(donation['name']),
                        subtitle: Text(donation['date']),
                        trailing: Text(
                          '${donation['amount'].toStringAsFixed(2)} EGP',  // Changed to EGP
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MakeDonationScreen()),
                  );
                },
                child: const Text(
                  'Make a Donation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 