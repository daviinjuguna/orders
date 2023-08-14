import 'package:auto_route/auto_route.dart';
import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:order_app/presentation/presentation.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final Chat _chat;
  List<ChatResponse> _response = [];
  @override
  void initState() {
    super.initState();
    _chat = Chat()
      ..init()
      ..newMessage(Message(chartResponseId: 0, sender: "user", message: "hi"))
      ..getResponse(Message(chartResponseId: 0, sender: 'user', message: "Hi"));
  }

  @override
  void dispose() {
    _chat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: StreamBuilder<List<ChatResponse>>(
        initialData: const [],
        stream: _chat.controller.stream,
        builder: (context, snapshot) {
          _response = snapshot.data ?? [];
          // return SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       for (final response in _response) ...[
          //         if (response.sender == 'bot')
          //           ListTile(
          //             title: Text(response.message),
          //           )
          //         else
          //           SenderBubble(message: response.message),
          //       ]
          //     ],
          //   ),
          // );
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            itemCount: _response.length,
            itemBuilder: (context, index) {
              final response = _response[index];
              if (response.sender == 'bot') {
                return ReceiverBubble(
                  response: response,
                  selectResponse: (response, message) async {
                    final Message sent = Message(
                      chartResponseId: response.id,
                      sender: 'user',
                      message: message,
                    );
                    _chat.newMessage(sent);
                    await Future.delayed(const Duration(seconds: 1));
                    if (!mounted) return;
                    _chat.getResponse(sent);
                  },
                );
              } else {
                return SenderBubble(
                  message: response.message,
                );
              }
            },
          );
        },
      ),
    );
  }
}
