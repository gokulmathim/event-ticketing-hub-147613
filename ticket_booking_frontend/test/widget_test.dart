import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticket_booking_frontend/main.dart';

void main() {
  testWidgets('App main widget loads', (WidgetTester tester) async {
    await tester.pumpWidget(const TicketBookingApp());

    // Verify that tab navigation is present after login flow would be handled.
    // (Since AuthService is not logged in by default, login form should display)
    expect(find.byType(TextField), findsWidgets); // Email/password fields
    expect(find.text('Ticket Booking'), findsOneWidget);
  });
}
