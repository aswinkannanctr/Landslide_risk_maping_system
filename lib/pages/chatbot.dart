import 'package:flutter/material.dart';

class ChatbotUI extends StatefulWidget {
  const ChatbotUI({super.key});

  @override
  State<ChatbotUI> createState() => _ChatbotUIState();
}

class _ChatbotUIState extends State<ChatbotUI> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'message': 'hai!', 'type': 'bot'},
    {'message': 'Hello, how can I help you', 'type': 'bot'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with home icon and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 28,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'chatbot',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Chat messages
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5D6C6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['message']!,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Message input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE5D6C6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'type a message',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          setState(() {
                            _messages.add({
                              'message': _messageController.text,
                              'type': 'user'
                            });
                            _messageController.clear();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}