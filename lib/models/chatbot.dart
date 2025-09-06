import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatBotPage extends StatefulWidget {
  final bool isFullScreen;

  const ChatBotPage({Key? key, this.isFullScreen = false}) : super(key: key);

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

  @override
  void dispose() {
    _speech.stop();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
    String reply = "I'm here to help you with SkillWaves! You can ask me about internships, skills, your profile, or anything else related to the app.";

    final msg = userMessage.toLowerCase();
    if (msg.contains("hello") || msg.contains("hi")) {
      reply = "Hi there! 👋 What would you like to explore today?";
    } else if (msg.contains("internship") || msg.contains("job")) {
      reply = "We offer 500+ internships in Tech, Design, Business, and more. Check out our Internships section for current opportunities!";
    } else if (msg.contains("skill") || msg.contains("course") || msg.contains("learn")) {
      reply = "Our courses cover Programming, Marketing, Design, and Analytics. What specific skill are you interested in?";
    } else if (msg.contains("profile") || msg.contains("account")) {
      reply = "You can update your profile information in the Profile section. Is there something specific you need help with?";
    } else if (msg.contains("thank")) {
      reply = "You're welcome! 😊 Is there anything else I can help you with?";
    } else if (msg.contains("help")) {
      reply = "I can help you with:\n• Finding internships\n• Skill development courses\n• Profile management\n• App navigation\n\nWhat do you need help with?";
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      _sendMessage(reply, isUser: false);
    });
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done') {
            setState(() => _isListening = false);
          }
        },
        onError: (error) => setState(() => _isListening = false),
      );
      
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            if (val.finalResult) {
              setState(() {
                _controller.text = val.recognizedWords;
                _isListening = false;
              });
            }
          },
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
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(Map<String, String> msg, int index) {
    final isUser = msg["role"] == "user";
    final isFirst = index == 0 || _messages[index - 1]["role"] != msg["role"];
    final isLast = index == _messages.length - 1 || _messages[index + 1]["role"] != msg["role"];
    
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isUser && isLast)
          Container(
            margin: const EdgeInsets.only(right: 8, bottom: 4),
            child: const CircleAvatar(
              backgroundColor: Color(0xFF6366F1),
              radius: 16,
              child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
            ),
          ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: isFirst ? 8 : 4,
              bottom: isLast ? 8 : 4,
              left: isUser ? 40 : 8,
              right: isUser ? 8 : 40,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isUser 
                  ? const Color(0xFF6366F1)
                  : const Color(0xFF2D2D42),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isUser ? 20 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              msg["text"]!,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.white70,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (isUser && isLast)
          Container(
            margin: const EdgeInsets.only(left: 8, bottom: 4),
            child: const CircleAvatar(
              backgroundColor: Color(0xFFEC4899),
              radius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFullScreen 
          ? AppBar(
              title: const Text("SkillWaves Assistant"),
              backgroundColor: const Color(0xFF1A1A2E),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
      backgroundColor: const Color(0xFF0F0F23),
      body: Column(
        children: [
          // Header when not in full screen mode
          if (!widget.isFullScreen) 
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  Icon(Icons.chat_bubble, color: Color(0xFF6366F1)),
                  SizedBox(width: 12),
                  Text(
                    'SkillWaves Assistant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          
          // Messages area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index], index),
            ),
          ),
          
          // Input Area
          Container(
            padding: EdgeInsets.only(
              bottom: widget.isFullScreen 
                  ? MediaQuery.of(context).padding.bottom 
                  : 80, // Extra space for bottom nav when not full screen
              left: 16,
              right: 16,
              top: 8,
            ),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF1E1E2E),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: _isListening 
                              ? const Color(0xFFEC4899) 
                              : Colors.white54,
                        ),
                        onPressed: _listen,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF6366F1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _sendMessage(_controller.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}