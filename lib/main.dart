import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/energy_state.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const HydroStoreApp());
}

class HydroStoreApp extends StatelessWidget {
  const HydroStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EnergyState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HydroStore Dashboard',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),

          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1D9E75),
          ),

          textTheme: GoogleFonts.dmSansTextTheme(),

          useMaterial3: true,
        ),
        home: const DashboardScreen(),
      ),
    );
  }
}