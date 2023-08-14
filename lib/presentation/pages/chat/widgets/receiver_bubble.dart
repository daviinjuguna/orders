import 'package:auto_route/auto_route.dart';
import 'package:chat/chat.dart';
import 'package:flutter/material.dart';

class ReceiverBubble extends StatelessWidget {
  const ReceiverBubble(
      {Key? key, required this.response, required this.selectResponse})
      : super(key: key);
  final ChatResponse response;
  final void Function(ChatResponse, String) selectResponse;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 250,
                  minWidth: 50,
                ),
                child: Text(
                  response.message,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //selection for options
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final option in response.selectOptions) ...[
                    OutlinedButton(
                      onPressed: () {
                        // response.onSelected(option);
                        selectResponse(response, option);
                      },
                      child: Text(option),
                    )
                  ],
                  if (response.selectOptions.isEmpty)
                    OutlinedButton(
                      onPressed: () {
                        context.back();
                      },
                      child: const Text("Finish"),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
