import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/buttons.dart';
import './sections/home_section.dart';
import './sections/scan_section.dart';
import './sections/results_section.dart';
import './sections/history_section.dart';
import './sections/bulk_section.dart';
import './sections/filter_section.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onBackPressed;

  const DashboardScreen({super.key, required this.onBackPressed});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String currentSection = 'home';

  final Map<String, String> sectionTitles = {
    'home': 'Dashboard',
    'scan': 'Scan Video',
    'results': 'Comment Results',
    'bulk': 'Bulk Scan',
    'filter': 'Filter Tool',
    'history': 'Scan History',
  };

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppTheme.bg0,
      drawer: isMobile ? _buildSidebar() : null,
      body: Row(
        children: [
          if (!isMobile) _buildSidebar(),

          Expanded(
            child: Column(
              children: [
                _buildTopbar(isMobile),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: _buildCurrentSection(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= SIDEBAR =================
  Widget _buildSidebar() {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: AppTheme.bg1,
        border: Border(right: BorderSide(color: AppTheme.b1)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.b1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.bg3,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.b2),
                  ),
                  child: const Center(
                    child: Icon(Icons.shield, color: AppTheme.red, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'CommentGuard',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.t1,
                  ),
                ),
              ],
            ),
          ),

          // NAV
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'MAIN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.t3,
                    ),
                  ),
                ),
                _buildNavItem('home', 'Dashboard', Icons.home),
                _buildNavItem('scan', 'Scan Video', Icons.search),
                _buildNavItem('results', 'Comment Results', Icons.cloud_off),
                _buildNavItem('history', 'Scan History', Icons.history),

                const SizedBox(height: 16),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'TOOLS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.t3,
                    ),
                  ),
                ),
                _buildNavItem('bulk', 'Bulk Scan', Icons.layers),
                _buildNavItem('filter', 'Filter Tool', Icons.filter_alt),
              ],
            ),
          ),

          // FOOTER
          Padding(
            padding: const EdgeInsets.all(16),
            child: GhostButton(
              label: 'Back',
              icon: Icons.arrow_back,
              onPressed: widget.onBackPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String id, String label, IconData icon) {
    final isActive = currentSection == id;

    return ListTile(
      leading: Icon(icon, color: isActive ? AppTheme.red : AppTheme.t3),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          color: isActive ? AppTheme.red : AppTheme.t2,
        ),
      ),
      selected: isActive,
      onTap: () {
        setState(() => currentSection = id);
        Navigator.pop(context); // close drawer
      },
    );
  }

  // ================= TOPBAR (FIXED HERE) =================
  Widget _buildTopbar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.b1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isMobile)
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    color: AppTheme.t1,
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // ✅ FIXED
                    },
                  ),
                ),
              const SizedBox(width: 8),
              Text(
                sectionTitles[currentSection] ?? 'Dashboard',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.t1,
                ),
              ),
            ],
          ),

          GhostButton(
            label: 'Logout',
            icon: Icons.logout,
            small: true,
            onPressed: widget.onBackPressed,
          ),
        ],
      ),
    );
  }

  // ================= SECTIONS =================
  Widget _buildCurrentSection() {
    switch (currentSection) {
      case 'home':
        return const HomeSection();

      case 'scan':
        return ScanSection(
          onScanComplete: () {
            setState(() => currentSection = 'results');
          },
        );

      case 'results':
        return const ResultsSection();

      case 'bulk':
        return const BulkSection();

      case 'filter':
        return const FilterSection();

      case 'history':
        return const HistorySection();

      default:
        return const HomeSection();
    }
  }
}