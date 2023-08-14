import 'package:chat/src/src.dart';

class ChatBot {
  final List<ChatResponse> response = [
    ChatResponse(
      id: 1,
      sender: 'bot',
      message:
          'Hello, I am a Bot Qeem. Are you contacting us regarding an existing order?',
      selectOptions: ['yes', 'no'],
    ),

    ChatResponse(
      id: 2,
      sender: 'bot',
      message:
          'To track your order, check the order id in order history and check the status of your order. If not, please contact us.',
      selectOptions: ["All good", "I'd like to contact you"],
    ),

    ChatResponse(
      id: 3,
      sender: 'bot',
      message: 'What can I help you with?',
      selectOptions: [
        'I want to place an order',
        'I want to track my order',
        'I want to contact you',
      ],
    ),

    ChatResponse(
      id: 4,
      sender: 'bot',
      message: 'Please contact us at 0123456789, Thanks for using our service',
      selectOptions: [],
    ),
    //thanks for using our service
    ChatResponse(
      id: 5,
      sender: 'bot',
      message: 'Thanks for using our service, have a nice day',
      selectOptions: [],
    ),

    //place an order
    ChatResponse(
      id: 6,
      sender: 'bot',
      message: 'To place an order, please add items to your cart and checkout',
      selectOptions: [
        'All good',
        'Need help with something else',
        'I want to contact you'
      ],
    ),
  ];

  ChatResponse getFirstResponse() {
    return response[0];
  }

  ChatResponse getResponse(Message message) {
    if (message.nextId == 0) {
      return response[0];
    }
    return response.firstWhere((element) => element.id == message.nextId);
    // return response.firstWhere((element) => element.id == id);
  }
}
