import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  final String username;

  const HomeScreen({
    super.key,
    required this.email,
    required this.username,
  });

  void logout(BuildContext context) async {
    await AuthService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void selectLevel(BuildContext context, String level) {
    Navigator.pushNamed(context, '/quiz', arguments: {'level': level});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Trang Chủ',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Xin chào,',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Email: $email',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Chọn mức độ bài trắc nghiệm',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            _buildLevelCard(
              context,
              label: 'Dễ',
              level: 'easy',
              icon: Icons.sentiment_satisfied,
              color: Colors.teal.shade300,
            ),
            const SizedBox(height: 16),
            _buildLevelCard(
              context,
              label: 'Trung bình',
              level: 'medium',
              icon: Icons.sentiment_neutral,
              color: Colors.amber.shade700,
            ),
            const SizedBox(height: 16),
            _buildLevelCard(
              context,
              label: 'Khó',
              level: 'hard',
              icon: Icons.sentiment_dissatisfied,
              color: Colors.redAccent.shade100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(
      BuildContext context, {
        required String label,
        required String level,
        required IconData icon,
        required Color color,
      }) {
    return InkWell(
      onTap: () => selectLevel(context, level),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(color: color, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }
}
