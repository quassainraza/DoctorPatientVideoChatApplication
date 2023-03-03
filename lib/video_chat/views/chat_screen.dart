import 'package:doctor_app/video_chat/video_chat.dart';
import 'package:flutter/material.dart';

import '../widgets/message_bubble.dart';
import '../widgets/message_textfield.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),

        actions: [
          IconButton(onPressed: ()=>Navigator.of(context).push(
            MaterialPageRoute(builder:(_) => const VideoChat() ),
          ) , icon: const Icon(Icons.video_call))
        ],
        centerTitle: true,
      ),
      body:

      Column(
        children: [
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                reverse: true,

                itemBuilder: (_, index)=> _messages[index], separatorBuilder: (_, __)=> const SizedBox(height: 16,), itemCount:_messages.length),
          ),
          const MessageTextField(),
        ],
      ),
    );
  }
}

const _messages = <MessageBubble>[

  MessageBubble(
      //profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "Hello my patient how are you",
      date: "Jan 23 8:34 pm  "),

  MessageBubble(
      profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "Hello my patient how are you",
      date: "Jan 23 8:34 pm  "),

  MessageBubble(
      //profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "Hello my patient how are you",
      date: "Jan 23 8:34 pm  "),
  MessageBubble(
      profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "Hello my patient how are you",
      date: "Jan 23 8:34 pm  "),

  MessageBubble(
      //profileUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "Nice to meet my patient how are you",
      date: "Jan 25 9:34 pm  "),

  MessageBubble(
      profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
      message: "wow my patient how are you",
      date: "Jan 23 8:34 pm  "),

  MessageBubble(
      //profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "hohoh my patient how are you",
      date: "Jan 23 8:34 pm  "),
  MessageBubble(
    profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "hohoh my patient how are you",
      date: "Jan 23 8:34 pm  "),

  MessageBubble(
    //profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "hohoh my patient how are you",
      date: "Jan 23 8:34 pm  "),

  MessageBubble(
    profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "hohoh my patient how are you",
      date: "Jan 23 8:34 pm  "),

  MessageBubble(
    //profileUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
      message: "hohoh my patient how are you",
      date: "Jan 23 8:34 pm  "),

];
