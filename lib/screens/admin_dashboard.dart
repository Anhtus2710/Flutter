import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  void _navigateTo(BuildContext context, String title) {
    // Tùy chọn chuyển đến từng màn hình, anh có thể xử lý tại đây
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đi tới: $title')),
    );
  }

  void _logout(BuildContext context) {
    // Xử lý đăng xuất, ví dụ: xóa token và quay về màn hình đăng nhập
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang quản lý Admin'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu quản lý',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Quản lý người dùng'),
              onTap: () => _navigateTo(context, 'Quản lý người dùng'),
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Quản lý câu hỏi'),
              onTap: () => _navigateTo(context, 'Quản lý câu hỏi'),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Quản lý điểm'),
              onTap: () => _navigateTo(context, 'Quản lý điểm'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Chào mừng Admin đến trang quản lý!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
