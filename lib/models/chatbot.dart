import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    // Add welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendMessage(
        "Hello 👋 I'm your SkillWaves Assistant. How can I help you today?",
        isUser: false,
      );
    });
  }

  void _sendMessage(String text, {bool isUser = true}) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": isUser ? "user" : "bot", "text": text});
    });

    _scrollToBottom();

    if (isUser) {
      _controller.clear();
      _botReply(text);
    }
  }

  void _botReply(String userMessage) {
    String reply = "I’m here to help! Can you be more specific?";

    final msg = userMessage.toLowerCase();
    if (msg.contains("hello") || msg.contains("hi")) {
      reply = "Hi there! 👋 What would you like to explore today?";
    } else if (msg.contains("internship")) {
      reply = "We offer 500+ internships in Tech, Design, Business, and more.";
    } else if (msg.contains("skills") || msg.contains("courses")) {
      reply = "Our courses cover Programming, Marketing, Design, and Analytics.";
    } else if (msg.contains("thanks")) {
      reply = "You’re welcome! 😊";
    }

    Future.delayed(const Duration(milliseconds: 600), () {
      _sendMessage(reply, isUser: false);
    });
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _controller.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Widget _buildMessage(Map<String, String> msg) {
    final isUser = msg["role"] == "user";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg["text"]!,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No NavBar here – just AppBar + Chat
      appBar: AppBar(
        title: const Text("SkillWaves Assistant"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),

          // Input Area
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none, // clean look
                      ),
                      onSubmitted: (value) => _sendMessage(value),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? Colors.red : Colors.grey[700],
                    ),
                    onPressed: _listen,
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () => _sendMessage(_controller.text),
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
