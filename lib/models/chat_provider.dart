import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/models/message.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  bool _driverTyping = false;

  List<Message> get messages => _messages;
  bool get driverTyping => _driverTyping;

  void addMessage(Message newMessage) {
    _messages.add(newMessage);
    notifyListeners();
  }

  void clearMessage() {
    _messages.clear();
    notifyListeners();
  }

  void userMessage(String text, void Function() scrollDown) async {
    addMessage(Message(text: text, byUser: true));
    _driverTyping = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1500));
    _driverTyping = false;
    addMessage(Message(text: 'Mohon menunggu, driver sedang dalam perjalanan', byUser: false));
    notifyListeners();
  }
}
