import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ✅ عنوان السيرفر المحلي
  static const String baseUrl = 'http://10.16.1.4:8000/api';

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': decoded,
          'message': decoded['message'] ?? 'تم التسجيل بنجاح ✅',
        };
      } else {
        return {
          'success': false,
          'data': decoded,
          'message': decoded['message'] ?? 'حدث خطأ أثناء التسجيل ⚠️',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'data': null,
        'message': 'فشل الاتصال بالسيرفر: ${e.toString()}',
      };
    }
  }
}
