import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([]);

  void sendMessage(String content) async {
    // Add user message
    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );
    
    state = [...state, userMessage];

    // Simulate AI processing (Independent logic replacement for n8n)
    await Future.delayed(const Duration(seconds: 1));

    // Simple mock response logic - In a real independent app, this would call OpenAI/Anthropic API directly
    String responseText = 'من یک هوش مصنوعی مستقل هستم. شما گفتید: "$content"';
    
    if (content.contains('سلام')) {
      responseText = 'سلام! چطور می‌توانم به شما کمک کنم؟';
    } else if (content.contains('کی هستی')) {
      responseText = 'من CouldAI هستم، دستیار شخصی شما که بدون نیاز به n8n کار می‌کند.';
    }

    final aiMessage = ChatMessage(
      id: const Uuid().v4(),
      content: responseText,
      isUser: false,
      timestamp: DateTime.now(),
    );

    state = [...state, aiMessage];
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier();
});
