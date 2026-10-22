import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/tutor.dart';
import '../routes/app_routes.dart';
import '../widgets/app_button.dart';

/// Home page: navigation bar, welcome section, sample tutors, footer.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // FICTIONAL demonstration data - not real people.
  static const List<Tutor> _sampleTutors = [
    Tutor(name: 'Maria Santos', subject: 'Mathematics', hourlyRate: 250, rating: 4.8),
    Tutor(name: 'Juan Dela Cruz', subject: 'Programming', hourlyRate: 300, rating: 4.6),
    Tutor(name: 'Ana Reyes', subject: 'English', hourlyRate: 200, rating: 4.9),
  ];

  void _goToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  void _goToReport(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.report);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavBar(context),
            _buildHero(context),
            _buildTutorSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // Top bar with branding and a Login button.
  Widget _buildNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.primaryLight, width: 2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.school, color: AppColors.primary, size: 32),
          const SizedBox(width: 8),
          const Flexible(
            child: Text(
              'Tutor Match AI',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          const Spacer(),
          AppButton(
            label: 'Report',
            icon: Icons.flag_outlined,
            outlined: true,
            onPressed: () => _goToReport(context),
          ),
          const SizedBox(width: 8),
          AppButton(
            label: 'Login',
            outlined: true,
            onPressed: () => _goToLogin(context),
          ),
        ],
      ),
    );
  }

  // Headline, description, and Get Started button.
  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryLight,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Column(
        children: [
          const Text(
            'Find the right tutor for your studies',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Text(
              'Tutor Match AI is a prototype platform that will help students '
              'find tutors that fit their subjects and needs. Smart matching '
              'will be added in a future stage of the project.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.textDark, height: 1.5),
            ),
          ),
          const SizedBox(height: 28),
          AppButton(
            label: 'Get Started',
            icon: Icons.arrow_forward,
            onPressed: () => _goToLogin(context),
          ),
        ],
      ),
    );
  }

  // Three sample tutor cards. Wrap moves cards to the next line on small screens.
  Widget _buildTutorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          const Text(
            'Sample Tutors',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Fictional demonstration data only - these are not real people.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: _sampleTutors.map((t) => _TutorCard(tutor: t)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: AppColors.primaryDark,
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Tutor Match AI - Activity 8 prototype (demo only)',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

/// A single tutor card (private to this file).
class _TutorCard extends StatelessWidget {
  final Tutor tutor;

  const _TutorCard({required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      child: SizedBox(
        width: 260,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.person, color: AppColors.primary, size: 30),
              ),
              const SizedBox(height: 12),
              Text(
                tutor.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(tutor.subject, style: const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 12),
              Text(
                '\u20B1${tutor.hourlyRate} / hour',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.star, color: AppColors.star, size: 18),
                  const SizedBox(width: 4),
                  Text('${tutor.rating} (demo)'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}