import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatManager {
  List<types.Message> messages = [];

  bool isLoading = false;
  final user = const types.User(id: 'user', firstName: 'Suraj');
  final bot = const types.User(id: 'model', firstName: 'Gemini');

  void addMessage(types.Message message) {
    messages.insert(0, message);
    isLoading = true;
    if (message is types.TextMessage) {
      messages.insert(
        0,
        types.TextMessage(
            author: bot,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            text: ""),
      );
    }
  }
}
