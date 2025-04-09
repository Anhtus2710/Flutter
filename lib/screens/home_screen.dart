import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

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
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Trang chủ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
            tooltip: 'Đăng xuất',
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                'Chào mừng, $email!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Text(
                'Chọn mức độ bài trắc nghiệm',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildLevelButton(
                context,
                label: 'Dễ',
                color: Colors.green,
                icon: Icons.sentiment_satisfied_alt,
                level: 'easy',
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                context,
                label: 'Trung bình',
                color: Colors.orange,
                icon: Icons.sentiment_neutral,
                level: 'medium',
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                context,
                label: 'Khó',
                color: Colors.red,
                icon: Icons.sentiment_dissatisfied,
                level: 'hard',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(
      BuildContext context, {
        required String label,
        required Color color,
        required IconData icon,
        required String level,
      }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => selectLevel(context, level),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
