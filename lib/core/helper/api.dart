import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiService {
  static const String _baseUrl = 'https://final-project-vr9q.onrender.com';
  static Future<Map<String, dynamic>> signUp(
      String name, String email, String password, String rePassword) async {
    final url = Uri.parse('$_baseUrl/users/signup');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'rePassword': rePassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // final token = data['token'];
      // final decodedToken = JwtDecoder.decode(token);
      // final userName = decodedToken['name'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      // await prefs.setString('token', token); // Save token
      // await prefs.setString(
      //     'currentUserName', userName); // Save current user name
      return data;
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> signIn(
      String email, String password) async {
    final url = Uri.parse('$_baseUrl/users/signIn');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      final decodedToken = JwtDecoder.decode(token);
      final userName = decodedToken['name'];

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', token); // Save token
      await prefs.setString(
          'currentUserName', userName); // Save current user name

      return responseData;
    } else {
      throw Exception('Failed to sign in: ${response.body}');
    }
  }

  static Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('token'); // Remove token
    await prefs.remove('currentUserName'); // Remove current user name
  }

  static Future<void> addTask(String title, String description) async {
    if (title.isEmpty) {
      throw Exception('Title cannot be empty');
    }

    final url = Uri.parse('$_baseUrl/tasks/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'token': 'Bearer $token',
      },
      body: json.encode({
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add task: ${response.body}');
    }
  }

  static Future<List<dynamic>> getAllTasks() async {
    final url = Uri.parse('$_baseUrl/tasks/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final currentUserName = prefs.getString('currentUserName');

    final response = await http.get(
      url,
      headers: {
        'token': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final tasks = data['tasks'];
      // Filter tasks by current user
      final userTasks = tasks.where((task) {
        return task['createdBy']['name'] == currentUserName;
      }).toList();
      return userTasks;
    } else {
      throw Exception('Failed to fetch tasks: ${response.body}');
    }
  }

  static Future<void> deleteTask(String id) async {
    final url = Uri.parse('$_baseUrl/tasks/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'token': 'Bearer $token',
      },
      body: json.encode({'_id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task: ${response.body}');
    }
  }

  static Future<void> updateTask(
      String id, String title, String description) async {
    final url = Uri.parse('$_baseUrl/tasks/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'token': 'Bearer $token',
      },
      body: json.encode({
        '_id': id,
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task: ${response.body}');
    }
  }

  final String baseUrl2 = 'https://5cc5-154-182-92-240.ngrok-free.app';

  Future<List<Map<String, dynamic>>> postEmotion(
      List<Map<String, dynamic>> data) async {
    final response = await http.post(
      Uri.parse(baseUrl2),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> sendNotification(String message) async {
    final url = Uri.parse('$_baseUrl/notifications/heart-rate');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'token': 'Bearer $token',
      },
      body: json.encode({
        'message': message,
      }),
    );

    final responseData = json.decode(response.body);

    if (responseData['message'] == 'Success') {
      log('Notification sent: ${responseData['message']}');
    } else {
      throw Exception('Failed to send notification: ${response.body}');
    }
  }
}
