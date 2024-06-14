import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static const String _baseUrl = 'https://yourapiurl.com';

  Future<void> signUp(
      String name, String email, String password, String rePassword) async {
    emit(SignUpLoading());
    final url = Uri.parse('$_baseUrl/users/signup');
    try {
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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        emit(SignUpSuccess());

        final data = json.decode(response.body);

        if (data['token'] == null) {
          emit(SignUpError('Token is null'));
          return;
        }

        final token = data['token'];
        final decodedToken = JwtDecoder.decode(token);

        if (decodedToken['name'] == null) {
          emit(SignUpError('User name is null'));
          return;
        }

        final userName = decodedToken['name'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('token', token);
        await prefs.setString('currentUserName', userName);

        emit(SignUpSuccess());
      } else {
        emit(SignUpError('Failed to sign up: ${response.body}'));
      }
    } catch (e) {
      emit(SignUpError('Failed to sign up: $e'));
    }
  }
}
