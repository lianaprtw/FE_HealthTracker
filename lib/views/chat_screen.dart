// lib/views/chat_screen.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  // <-- Pastikan ini StatefulWidget
  final String recipientName;

  const ChatScreen({super.key, required this.recipientName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = []; // Daftar pesan yang akan ditampilkan

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add("Anda: ${_messageController.text}");
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _messages.add(
              "${widget.recipientName}: Oke, saya terima pesan Anda.",
            );
          });
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat dengan ${widget.recipientName}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = _messages.length - 1 - index;
                return Align(
                  alignment:
                      _messages[reversedIndex].startsWith('Anda:')
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color:
                          _messages[reversedIndex].startsWith('Anda:')
                              ? Colors.blue[100]
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(_messages[reversedIndex]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
