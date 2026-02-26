import 'package:go_router/go_router.dart';
import '../../core/domain/misc/module.dart';
import 'presentation/screens/chat/chat_screen.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';

final class AiModule implements Module {
  @override
  String get name => 'Chat';

  @override
  List<GoRoute> get routes => [
    GoRoute(
      name: 'dashboard',
      path: '/dashboard',
      builder: (context, state) => const DashboardScreeen(),
    ),

    GoRoute(
      name: 'chat-new',
      path: '/chat',
      builder: (context, state) => const ChatScreen(),
    ),

    GoRoute(
      name: 'chat',
      path: '/chat/:chatUid',
      builder: (context, state) =>
          ChatScreen(chatUid: state.pathParameters['chatUid']),
    ),
  ];

  @override
  List<Map<String, dynamic>> get sqlScript => [
    {
      'version': 1,
      'type': 'create',
      'sql': '''CREATE TABLE chats (id INTEGER PRIMARY KEY AUTOINCREMENT,
                  uid UNIQUE NOT NULL,
                  title TEXT NOT NULL,
                  status INTEGER NOT NULL,
                  last_message TEXT NOT NULL,
                  last_message_timestamp INTEGER NOT NULL,
                  timestamp INTEGER NOT NULL) ''',
    },
    {
      'version': 1,
      'type': 'create',
      'sql': '''CREATE TABLE messages (id INTEGER PRIMARY KEY AUTOINCREMENT,
                  uid UNIQUE NOT NULL,
                  chat_uid TEXT NOT NULL,
                  content TEXT NOT NULL,  
                  role INTEGER NOT NULL,
                  timestamp INTEGER NOT NULL,
                  status INTEGER NOT NULL,
                  prompt TEXT NULL,
                  FOREIGN KEY (chat_uid) REFERENCES chats (uid) ON DELETE CASCADE) ''',
    },
  ];
}
