import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://192.168.2.15:3000/api';

  // Đăng ký
  static Future<Map<String, dynamic>> register(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password, // gửi mật khẩu thô để server hash bằng bcrypt
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Lỗi đăng ký: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Không thể kết nối máy chủ: $e',
      };
    }
  }

  // Đăng nhập
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password, // gửi mật khẩu thô, server sẽ kiểm tra bằng bcrypt.compare
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Đăng nhập thất bại: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Không thể kết nối máy chủ: $e',
      };
    }
  }

  // Quên mật khẩu - Đặt lại mật khẩu mới
  static Future<Map<String, dynamic>> resetPassword(String email, String newPassword) async {
    final url = Uri.parse('$baseUrl/reset-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword, // gửi mật khẩu mới thô, server sẽ hash
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Đặt lại mật khẩu thất bại: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Không thể kết nối máy chủ: $e',
      };
    }
  }

  // Đăng xuất
  static Future<void> logout() async {
    // Nếu server có API logout (xóa token, v.v), gọi tại đây.
    // Nếu không, chỉ xóa dữ liệu cục bộ (SharedPreferences hoặc Token).
    await Future.delayed(Duration(milliseconds: 100));
  }
}
