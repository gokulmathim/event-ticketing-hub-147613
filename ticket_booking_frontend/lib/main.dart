import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/services/auth_service.dart';
import 'src/services/event_service.dart';
import 'src/services/booking_service.dart';
import 'src/services/payment_service.dart';
import 'src/services/notification_service.dart';
import 'src/views/auth/login_page.dart';
import 'src/views/event/event_list_page.dart';
import 'src/views/booking/booking_history_page.dart';
import 'src/views/profile/profile_page.dart';
import 'src/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await NotificationService().initialize();
  runApp(const TicketBookingApp());
}

// PUBLIC_INTERFACE
class TicketBookingApp extends StatelessWidget {
  const TicketBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<EventService>(create: (_) => EventService()),
        ChangeNotifierProvider<BookingService>(create: (_) => BookingService()),
        Provider<PaymentService>(create: (_) => PaymentService()),
      ],
      child: Consumer<AuthService>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Event Ticket Booking',
          theme: AppTheme.lightTheme,
          home: auth.isLoggedIn ? const MainTabs() : const LoginPage(),
        ),
      ),
    );
  }
}

// PUBLIC_INTERFACE
class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = [
    EventListPage(),
    BookingHistoryPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int idx) => setState(() => _selectedIndex = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
