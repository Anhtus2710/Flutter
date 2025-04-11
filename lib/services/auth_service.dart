import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://192.168.2.15:3000/api';

  /// Đăng ký tài khoản mới
  static Future<Map<String, dynamic>> register(String username, String email, String password) async {
    final Uri url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password, // Gửi password thô, server sẽ hash bằng bcrypt
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Đăng ký thành công',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Lỗi đăng ký',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Không thể kết nối đến máy chủ: $e',
      };
    }
  }

  /// Đăng nhập
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final Uri url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'user': data['user'],
          'token': data['token'], // nếu có token, lấy ra lưu
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Đăng nhập thất bại',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Không thể kết nối đến máy chủ: $e',
      };
    }
  }

  /// Đặt lại mật khẩu
  static Future<Map<String, dynamic>> resetPassword(String email, String newPassword) async {
    final Uri url = Uri.parse('$baseUrl/reset-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Đặt lại mật khẩu thành công',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Đặt lại mật khẩu thất bại',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Không thể kết nối đến máy chủ: $e',
      };
    }
  }

  /// Đăng xuất (tạm thời)
  static Future<void> logout() async {
    // Nếu cần xoá token lưu local, xử lý tại đây
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
