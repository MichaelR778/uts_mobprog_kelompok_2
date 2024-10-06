import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/components/chat_bubble.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/models/chat_provider.dart';
import 'package:uts_mobprog_kelompok_2/models/message.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textController = TextEditingController();

  final ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  Widget build(BuildContext context) {
    dynamic orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage(orderProvider.selectedOption.iconPath),
                      backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Driver'),
                    Text(
                      chatProvider.driverTyping ? 'Sedang mengetik...' : '',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    Message message = chatProvider.messages[index];
                    var alignment = message.byUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft;

                    return Container(
                      alignment: alignment,
                      child: ChatBubble(
                        message: message.text,
                        isCurrentUser: message.byUser,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: color1),
                            ),
                          ),
                          controller: textController,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: color2,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(right: 25),
                      child: IconButton(
                        onPressed: () {
                          chatProvider.userMessage(
                              textController.text, scrollDown);
                          textController.clear();
                        },
                        icon: const Icon(
                          Icons.arrow_upward,
                          color: color9,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
