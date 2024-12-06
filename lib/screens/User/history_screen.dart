import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10, // Example count
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.history,
              color: Theme.of(context).colorScheme.secondary),
            title: Text('Request #${index + 1}'),
            subtitle: Text('Date: ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}'),
            trailing: Icon(Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary),
            onTap: () {},
          ),
        );
      },
    );
  }
} 