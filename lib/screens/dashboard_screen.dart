import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/energy_state.dart';

import '../widgets/chart_widget.dart';
import '../widgets/flow_bar.dart';
import '../widgets/metric_card.dart';
import '../widgets/mode_button.dart';
import '../widgets/power_toggle.dart';
import '../widgets/tank_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<EnergyState>().startSimulation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EnergyState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.bolt,
                              color: Color(0xFFBA7517),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "HydroStore Dashboard",
                              style: GoogleFonts.dmSans(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Stocare energie pe bază de hidrogen",
                          style: GoogleFonts.dmSans(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// STATUS
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1F5EE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1D9E75),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Sistem activ",
                          style: GoogleFonts.dmSans(
                            color: const Color(0xFF0F6E56),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// METRICS
              Row(
                children: [
                  MetricCard(
                    title: "Hidrogen stocat",
                    value: state.h2Kg.toStringAsFixed(1),
                    unit: " kg",
                    subtitle:
                    "Din max ${state.maxKg} kg",
                    icon: Icons.science,
                    color: const Color(0xFF1D9E75),
                  ),
                  const SizedBox(width: 12),
                  MetricCard(
                    title: "Surplus solar",
                    value:
                    state.surplusKw.toStringAsFixed(1),
                    unit: " kW",
                    subtitle:
                    "Producție ${state.solarKw.toStringAsFixed(1)} kW",
                    icon: Icons.sunny,
                    color: const Color(0xFFBA7517),
                  ),
                  const SizedBox(width: 12),
                  MetricCard(
                    title: "Consum casă",
                    value:
                    state.homeKw.toStringAsFixed(1),
                    unit: " kW",
                    subtitle: "Rețea + H₂",
                    icon: Icons.home,
                    color: const Color(0xFF185FA5),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// TANK SECTION
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [

                    /// TANK
                    TankWidget(
                      percentage: state.tankPercentage,
                    ),

                    const SizedBox(width: 24),

                    /// DETAILS
                    Expanded(
                      child: Column(
                        children: [
                          buildInfoRow(
                            "Hidrogen actual",
                            "${state.h2Kg.toStringAsFixed(2)} kg",
                          ),
                          buildInfoRow(
                            "Capacitate totală",
                            "${state.maxKg} kg",
                          ),
                          buildInfoRow(
                            "Produs azi",
                            "${state.todayH2.toStringAsFixed(2)} kg",
                          ),
                          buildInfoRow(
                            "Produs luna aceasta",
                            "${state.monthH2.toStringAsFixed(1)} kg",
                          ),
                          buildInfoRow(
                            "Presiune rezervor",
                            "${state.pressure} bar",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// FLOW SECTION
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fluxuri energie",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    FlowBar(
                      label: "Panouri PV",
                      value: state.solarKw,
                      max: 6,
                      color: const Color(0xFFEF9F27),
                      icon: Icons.sunny,
                    ),

                    FlowBar(
                      label: "Consum casă",
                      value: state.homeKw,
                      max: 6,
                      color: const Color(0xFF378ADD),
                      icon: Icons.home,
                    ),

                    FlowBar(
                      label: "Electroliză H₂",
                      value: state.surplusKw,
                      max: 6,
                      color: const Color(0xFF1D9E75),
                      icon: Icons.science,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// POWER CONTROL
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [

                    /// TOGGLE
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alimentare din H₂",
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.feedActive
                                  ? "Casa este alimentată din H₂"
                                  : "Doar alimentare din rețea",
                              style: GoogleFonts.dmSans(
                                color:
                                Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),

                        PowerToggle(
                          active: state.feedActive,
                          onChanged:
                          state.toggleFeed,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// MODES
                    Row(
                      children: [
                        ModeButton(
                          text: "Automat",
                          icon: Icons.refresh,
                          active:
                          state.mode == "auto",
                          color:
                          const Color(0xFF1D9E75),
                          onTap: () {
                            state.setMode("auto");
                          },
                        ),

                        const SizedBox(width: 10),

                        ModeButton(
                          text: "Solar",
                          icon: Icons.sunny,
                          active:
                          state.mode == "solar",
                          color:
                          const Color(0xFFBA7517),
                          onTap: () {
                            state.setMode("solar");
                          },
                        ),

                        const SizedBox(width: 10),

                        ModeButton(
                          text: "H₂",
                          icon: Icons.science,
                          active:
                          state.mode == "h2",
                          color:
                          const Color(0xFF1D9E75),
                          onTap: () {
                            state.setMode("h2");
                          },
                        ),

                        const SizedBox(width: 10),

                        ModeButton(
                          text: "Rețea",
                          icon: Icons.factory,
                          active:
                          state.mode == "grid",
                          color:
                          const Color(0xFF185FA5),
                          onTap: () {
                            state.setMode("grid");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ALERT BOX
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAEEDA),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xFFBA7517),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Producție optimă între 10:00–15:00 · Randament electrolizor 72%",
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFFBA7517),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// CHART
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Producție H₂ — ultimele 7 zile",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const ChartWidget(),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.dmSans(
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.spaceMono(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}