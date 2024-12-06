import 'package:flutter/material.dart';

class CourierChatHelpScreen extends StatefulWidget {
  const CourierChatHelpScreen({Key? key}) : super(key: key);

  @override
  State<CourierChatHelpScreen> createState() => _CourierChatHelpScreenState();
}

class _CourierChatHelpScreenState extends State<CourierChatHelpScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! I'm CharityFlow's Courier Assistant. How can I help you today?",
      isUser: false,
    ),
  ];

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatMessage(
          text: _getAIResponse(text),
          isUser: false,
        ));
      });
    });
  }

  String _getAIResponse(String userMessage) {
    final String lowercaseMessage = userMessage.toLowerCase();

    // Delivery management queries
    if (lowercaseMessage.contains('delivery') || lowercaseMessage.contains('manage')) {
      if (lowercaseMessage.contains('how')) {
        return "To manage deliveries:\n\n1. Click 'Manage Deliveries' on the home screen\n2. View assigned deliveries\n3. Update delivery status\n4. Mark deliveries as completed\n\nMake sure to update the status promptly for better tracking!";
      }
      if (lowercaseMessage.contains('status')) {
        return "Delivery statuses include:\n\n• Pending - Awaiting pickup\n• In Progress - Item picked up\n• Completed - Delivered to recipient\n• Cancelled - Delivery cancelled\n\nUpdate these through the Manage Deliveries screen.";
      }
      return "You can manage all your deliveries through the app. Would you like to know about:\n• How to manage deliveries?\n• Updating delivery status?\n• Delivery guidelines?";
    }

    // Pickup related queries
    if (lowercaseMessage.contains('pickup') || lowercaseMessage.contains('collect')) {
      if (lowercaseMessage.contains('location')) {
        return "To find pickup locations:\n\n1. Open the delivery details\n2. Click 'View Location'\n3. Get directions via integrated maps\n4. Contact donor if needed\n\nMake sure to arrive within the scheduled time slot!";
      }
      if (lowercaseMessage.contains('time') || lowercaseMessage.contains('schedule')) {
        return "For pickup timing:\n\n• Check scheduled time in delivery details\n• Arrive within the time slot\n• Contact donor if delayed\n• Mark pickup complete in app";
      }
      return "For pickup operations, you can:\n• View pickup locations\n• Check scheduled times\n• Get donor contact info\n• Update pickup status";
    }

    // Request handling queries
    if (lowercaseMessage.contains('request')) {
      if (lowercaseMessage.contains('accept')) {
        return "To accept delivery requests:\n\n1. Go to 'View Requests'\n2. Browse available requests\n3. Check delivery details\n4. Click 'Accept Request'\n\nOnly accept requests you can fulfill within the specified timeframe.";
      }
      if (lowercaseMessage.contains('cancel')) {
        return "To cancel accepted requests:\n\n1. Open delivery details\n2. Click 'Cancel Delivery'\n3. Provide cancellation reason\n4. Submit\n\nPlease cancel with adequate notice when possible.";
      }
      return "For delivery requests, you can:\n• View available requests\n• Accept new deliveries\n• Manage accepted requests\n• Cancel if necessary";
    }

    // Payment queries
    if (lowercaseMessage.contains('payment') || lowercaseMessage.contains('earn')) {
      if (lowercaseMessage.contains('rate')) {
        return "Delivery payment rates:\n\n• Base rate per delivery\n• Distance bonus\n• Time slot bonus\n• Special handling fee\n\nPayments are processed weekly to your registered account.";
      }
      if (lowercaseMessage.contains('history')) {
        return "To view payment history:\n\n1. Go to History tab\n2. Select 'Payment History'\n3. View detailed breakdown\n4. Download statements if needed";
      }
      return "For payment information:\n• View current rates\n• Check payment history\n• Payment schedule\n• Bonus opportunities";
    }

    // Support queries
    if (lowercaseMessage.contains('help') || lowercaseMessage.contains('support')) {
      return "For courier support:\n\n• Email: courier.support@charityflow.com\n• Emergency Hotline: 1-800-COURIER\n• In-app chat (current)\n\nSupport team is available 24/7 for urgent delivery issues.";
    }

    // Default response
    return "I understand you're asking about '${lowercaseMessage}'. As a courier, you can ask about:\n\n• Deliveries\n• Pickups\n• Requests\n• Payments\n• Support";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courier Help Assistant',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 2,
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, index) => _messages[_messages.length - 1 - index],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -2),
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: _handleSubmitted,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => _handleSubmitted(_messageController.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              margin: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isUser ? 20 : 4),
                  topRight: Radius.circular(isUser ? 4 : 20),
                  bottomLeft: const Radius.circular(20),
                  bottomRight: const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (isUser)
            Container(
              margin: const EdgeInsets.only(left: 12.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
} 