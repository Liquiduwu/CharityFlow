import 'package:flutter/material.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample saved addresses in Egypt
    final List<String> addresses = [
      "12 Tahrir Square, Cairo, Egypt",
      "32 Nile Corniche, Giza, Egypt",
      "45 Al-Maadi, Cairo, Egypt",
      "78 Alexandria Road, Alexandria, Egypt",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Addresses"),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(addresses[index]),
            onTap: () {
              // Optionally handle address tap, e.g., show details or map
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Address Selected"),
                  content: Text("You selected:\n${addresses[index]}"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
