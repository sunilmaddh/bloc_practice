import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: ChatScreen()),
  );
}

// 1. Message model
class ChatMessage {
  final String id;
  final String sender;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}

// 2. Sample data
List<ChatMessage> createSampleMessages() {
  final now = DateTime.now();

  return [
    ChatMessage(
      id: '1',
      sender: 'Alex',
      text: 'Hey! How are you?',
      timestamp: now.subtract(const Duration(minutes: 5)),
      isMe: false,
    ),
    ChatMessage(
      id: '2',
      sender: 'Me',
      text: 'I am doing great!',
      timestamp: now.subtract(const Duration(minutes: 4)),
      isMe: true,
    ),
    ChatMessage(
      id: '3',
      sender: 'Alex',
      text: 'Are we meeting tomorrow?',
      timestamp: now.subtract(const Duration(days: 1, hours: 2)),
      isMe: false,
    ),
    ChatMessage(
      id: '4',
      sender: 'Me',
      text: 'Yes, at 10 AM.',
      timestamp: now.subtract(const Duration(days: 1, hours: 1)),
      isMe: true,
    ),
    ChatMessage(
      id: '5',
      sender: 'Alex',
      text: 'I shared the project document.',
      timestamp: now.subtract(const Duration(days: 3)),
      isMe: false,
    ),
    ChatMessage(
      id: '6',
      sender: 'Me',
      text: 'Thanks, I will review it.',
      timestamp: now.subtract(const Duration(days: 3, minutes: 2)),
      isMe: true,
    ),
  ];
}

// 3. Group messages by calendar date
Map<DateTime, List<ChatMessage>> groupMessagesByDate(
  List<ChatMessage> messages,
) {
  final sortedMessages = List<ChatMessage>.of(messages)
    ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  final Map<DateTime, List<ChatMessage>> grouped = {};

  for (final message in sortedMessages) {
    final date = DateUtils.dateOnly(message.timestamp);

    grouped.putIfAbsent(date, () => []);
    grouped[date]!.add(message);
  }

  return grouped;
}

// 4. Format date group titles
String formatDateHeader(DateTime date) {
  final today = DateUtils.dateOnly(DateTime.now());
  final yesterday = today.subtract(const Duration(days: 1));

  if (date == today) return 'Today';
  if (date == yesterday) return 'Yesterday';

  return DateFormat('dd MMM yyyy').format(date);
}

// 5. Chat screen
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alex')),
      body: GroupedChatList(messages: createSampleMessages()),
    );
  }
}

// 6. Reusable grouped chat list
class GroupedChatList extends StatefulWidget {
  final List<ChatMessage> messages;

  const GroupedChatList({super.key, required this.messages});

  @override
  State<GroupedChatList> createState() => _GroupedChatListState();
}

class _GroupedChatListState extends State<GroupedChatList> {
  late Map<DateTime, List<ChatMessage>> groupedMessages;

  @override
  void initState() {
    super.initState();
    _prepareMessages();
  }

  @override
  void didUpdateWidget(covariant GroupedChatList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!identical(oldWidget.messages, widget.messages)) {
      _prepareMessages();
    }
  }

  void _prepareMessages() {
    groupedMessages = groupMessagesByDate(widget.messages);
  }

  @override
  Widget build(BuildContext context) {
    final groups = groupedMessages.entries.toList();

    return CustomScrollView(
      key: const PageStorageKey<String>('chat-scroll'),
      slivers: [
        for (final group in groups) ...[
          // Sticky date header
          SliverPersistentHeader(
            key: ValueKey('header-${group.key}'),
            pinned: true,
            delegate: DateHeaderDelegate(title: formatDateHeader(group.key)),
          ),

          // Lazily build messages in this date group
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final message = group.value[index];

                return MessageTile(key: ValueKey(message.id), message: message);
              },
              childCount: group.value.length,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: true,
            ),
          ),
        ],
      ],
    );
  }
}

// 7. Sticky header delegate
class DateHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  DateHeaderDelegate({required this.title});

  @override
  double get minExtent => 42;

  @override
  double get maxExtent => 42;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 42,
      alignment: Alignment.center,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant DateHeaderDelegate oldDelegate) {
    return oldDelegate.title != title;
  }
}

// 8. Individual message widget
class MessageTile extends StatelessWidget {
  final ChatMessage message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment = message.isMe
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = message.isMe ? Colors.green.shade100 : Colors.grey.shade200;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.text, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 4),
            Text(
              DateFormat('hh:mm a').format(message.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
