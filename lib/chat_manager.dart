import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gemini_chat_app/chat_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatManager {
  List<types.Message> messages = [];
RxString result = ''.obs;

  bool isLoading = false;
  final user = const types.User(id: 'user', firstName: 'Suraj');
  final bot = const types.User(id: 'model', firstName: 'Gemini');

  late WebSocketChannel channel;
   String api = "AIzaSyD_UNxHsJUDiLTNaKmsSXq6xGZKgGIP2SE";

  void initialWebSocket() {
channel = IOWebSocketChannel.connect('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$api');
  }

  void addMessage(types.Message message) async {
    messages.insert(0, message);
    isLoading = true;
    if (message is types.TextMessage)  {
    //  channel.sink.add(message.text);
    result.value = await GeminiApi.getGeminiData(message.text);
      messages.insert(
        0,
        types.TextMessage(
            author: bot,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            text: result.value,
            
            ),
      );
    }
  }

  void onMessageReceived(result) {
messages.insert(0, types.TextMessage (  author: bot,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            text: result.value,)) ;
  }

//   void onMessageReceived(response) {
// if(response == "<FIN>") {
//   isLoading = false;
// } else {
//   messages.first = (messages.first as types.TextMessage).copyWith(text:  (messages.first as types.TextMessage).text + response);
// }
//   }
}
