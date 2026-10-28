import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: ChatScreen()),
  );
}

class ChatListModel {
  final String id;
  final String message;
  final DateTime timestamp;
  final String imge;
  final String sender;
  final bool isMe;

  ChatListModel({
    required this.message,
    required this.imge,
    required this.timestamp,
    required this.id,
    required this.sender,
    required this.isMe,
  });
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  List<ChatListModel> get chatList {
    final now = DateTime.now();

    return [
      ChatListModel(
        id: '1',
        message: "How are you",
        imge: "",
        timestamp: now.subtract(Duration(minutes: 1)),
        sender: "Sunil",
        isMe: false,
      ),
      ChatListModel(
        id: "2",
        sender: "Me",
        message: "I am fine",
        imge: "",
        timestamp: now.subtract(Duration(days: 1)),
        isMe: true,
      ),
      ChatListModel(
        id: "3",
        sender: "Sunil",
        message: "How are you",
        imge: "",
        timestamp: now.subtract(Duration(days: 3)),
        isMe: false,
      ),
    ];
  }

  Map<String, List<ChatListModel>> groupMessage(List<ChatListModel> chatList) {
    Map<String, List<ChatListModel>> groups = {};
    var now = DateTime.now();
    var today = DateUtils.dateOnly(now);

    final yesterday = today.subtract(const Duration(days: 1));

    var sortedChat = List<ChatListModel>.from(chatList)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    for (var chat in sortedChat) {
      var dateTime = DateUtils.dateOnly(chat.timestamp);
      var chatDate = dateTime;
      String groupName;
      if (chatDate == today) {
        groupName = "Today";
      } else if (chatDate == yesterday) {
        groupName = "Yesterday";
      } else {
        groupName = DateFormat("dd MM yy").format(chat.timestamp);
      }

      groups.putIfAbsent(groupName, () => []);
      groups[groupName]!.add(chat);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final groupChat = groupMessage(chatList);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // for (var group in groupChat.entries)
            //   SliverPersistentHeader(delegate: Dele),
          ],
        ),

        //  ListView(
        //   children: groupChat.entries.expand((entry) {
        //     return [
        //       Padding(padding: EdgeInsets.all(10), child: Text(entry.key)),
        //       ...entry.value.map((chat) {
        //         final alignment = chat.isMe == true
        //             ? Alignment.centerLeft
        //             : Alignment.centerRight;
        //         return Align(
        //           alignment: alignment,
        //           child: ListTile(
        //             title: Text(chat.message),
        //             subtitle: Text(chat.message),
        //           ),
        //         );
        //       }),
        //     ];
        //   }).toList(),
        // ),
      ),
    );
  }
}
