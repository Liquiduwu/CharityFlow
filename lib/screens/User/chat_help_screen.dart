import 'package:flutter/material.dart';

class ChatHelpScreen extends StatefulWidget {
  const ChatHelpScreen({Key? key}) : super(key: key);

  @override
  State<ChatHelpScreen> createState() => _ChatHelpScreenState();
}

class _ChatHelpScreenState extends State<ChatHelpScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! I'm CharityFlow's AI assistant. How can I help you today?",
      isUser: false,
    ),
  ];

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    // Simulate AI response after a short delay
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

    // Donation related queries
    if (lowercaseMessage.contains('donate')) {
      if (lowercaseMessage.contains('how')) {
        return "To make a donation:\n\n1. Click 'Donate Items' on the home screen\n2. Select the categories of items\n3. Enter the weight and description\n4. Choose a pickup time\n5. Select your payment method\n\nOur courier will pick up your items at the scheduled time!";
      }
      if (lowercaseMessage.contains('category') || lowercaseMessage.contains('type')) {
        return "We accept various types of donations including:\n\n• Clothes\n• Food\n• Books\n• Toys\n• Electronics\n• Furniture\n\nMake sure items are in good condition and properly packaged.";
      }
      if (lowercaseMessage.contains('pickup') || lowercaseMessage.contains('collect')) {
        return "Our couriers handle pickup of donations. When making a donation, you can select a convenient pickup time. The courier will arrive within the selected time slot. Make sure items are properly packed and ready for collection!";
      }
      return "You can donate items through our app. Would you like to know about:\n• How to donate?\n• What items we accept?\n• Pickup process?";
    }

    // Request related queries
    if (lowercaseMessage.contains('request') || lowercaseMessage.contains('need')) {
      if (lowercaseMessage.contains('how')) {
        return "To view or make requests:\n\n1. Click 'View Requests' on the home screen\n2. Browse available donations\n3. Click on items you need\n4. Submit your request\n\nDonors will be notified and can approve your request.";
      }
      if (lowercaseMessage.contains('status')) {
        return "You can check your request status in the History tab. Requests can be:\n\n• Pending - Waiting for donor approval\n• Approved - Ready for pickup/delivery\n• Completed - Item received\n• Cancelled - Request cancelled";
      }
      return "You can request items through our app. Would you like to know about:\n• How to make requests?\n• Checking request status?\n• Available items?";
    }

    // Profile related queries
    if (lowercaseMessage.contains('profile') || lowercaseMessage.contains('account')) {
      if (lowercaseMessage.contains('edit') || lowercaseMessage.contains('change')) {
        return "To edit your profile:\n\n1. Click the Profile tab\n2. Tap the Edit button\n3. Update your information\n4. Save changes\n\nYou can update your name, contact info, and preferences.";
      }
      if (lowercaseMessage.contains('history')) {
        return "Your donation and request history is available in the History tab. You can view:\n\n• Past donations\n• Received items\n• Pending requests\n• Transaction details";
      }
      return "Your profile contains your personal information and history. Would you like to know about:\n• Editing profile?\n• Viewing history?\n• Account settings?";
    }

    // Payment related queries
    if (lowercaseMessage.contains('payment') || lowercaseMessage.contains('pay')) {
      if (lowercaseMessage.contains('method')) {
        return "We support multiple payment methods:\n\n• Cash on pickup\n• Credit Card\n• PayPal\n• None (for free donations)\n\nYou can select your preferred method when making a donation.";
      }
      if (lowercaseMessage.contains('refund')) {
        return "For refund inquiries:\n\n1. Go to the History tab\n2. Select the transaction\n3. Click 'Request Refund'\n4. Provide reason\n\nOur team will review your request within 24-48 hours.";
      }
      return "We handle payments securely through our app. Would you like to know about:\n• Payment methods?\n• Refund process?\n• Transaction history?";
    }

    // General help
    if (lowercaseMessage.contains('help') || lowercaseMessage.contains('support')) {
      return "I'm here to help! You can ask me about:\n\n• Donation process\n• Making requests\n• Profile management\n• Payment methods\n• History tracking\n\nWhat would you like to know more about?";
    }

    // Contact related queries
    if (lowercaseMessage.contains('contact') || lowercaseMessage.contains('reach')) {
      return "You can reach us through:\n\n• Email: support@charityflow.com\n• Phone: 1-800-CHARITY\n• In-app chat (current)\n\nOur support team is available 24/7 to assist you.";
    }

    // Default response
    return "I understand you're asking about '${lowercaseMessage}'. Could you please be more specific? You can ask about:\n\n• Donations\n• Requests\n• Profile\n• Payments\n• Support";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Help Assistant',
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