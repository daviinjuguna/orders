library chat;

import 'package:chat/src/src.dart';
import 'package:rxdart/rxdart.dart';

export 'src/src.dart';

/// chatbot
class Chat {
  /// chatbot
  Chat();

  final _bot = ChatBot();

  List<ChatResponse> responses = [];

  ///watch messages
  late BehaviorSubject<List<ChatResponse>> controller =
      BehaviorSubject.seeded(responses);

  void newMessage(Message message) {
    responses.add(ChatResponse.fromMessage(message));
    controller.add(responses);
  }

  ///add message
  void getResponse(Message message) {
    // if (responses.length > 1) {
    responses.add(_bot.getResponse(message));
    // } else {
    //   responses.add(_bot.getFirstResponse());
    // }
    controller.add(responses);
  }

  void init() {
    responses.clear();
  }

  void dispose() {
    controller.close();
  }
}
