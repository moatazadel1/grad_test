import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:new_app/core/constants/validators.dart';
import 'package:new_app/core/helper/api.dart';
import 'package:new_app/core/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String currentUserEmail = "";
  String userName = "";
  String? userId; // Change to String? to handle nullable value

  late final TextEditingController _nameController,
      _passwordController,
      _emailController;
  late final FocusNode _nameFocusNode, _passwordFocusNode, _emailFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _nameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _loadUserDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('currentUserName') ?? 'User';
      currentUserEmail = prefs.getString('currentUserEmail') ?? 'Email';
    });

    // Fetch userId asynchronously and update state
    userId = await ApiService.fetchUserIdByEmail(currentUserEmail);
  }

  Future<void> _saveChanges() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User ID not available. Unable to update.'),
      ));
      return;
    }

    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await ApiService.updateUserInfo(userId!, name, email, password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User information updated successfully'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to update user information'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFF),
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Ionicons.chevron_back_outline),
          ),
          leadingWidth: 80,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: _saveChanges,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(60, 50),
                  elevation: 3,
                ),
                icon: const Icon(Ionicons.checkmark, color: Colors.black),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/aveter2-removebg-preview.png",
                            height: 100,
                            width: 100,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.lightBlueAccent,
                          ),
                          child: const Text("Upload Image"),
                        )
                      ],
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 10),
                        labelText: "Email",
                        validator: (value) {
                          return Validators.emailValidator(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: obscureText,
                        textInputAction: TextInputAction.none,
                        keyboardType: TextInputType.visiblePassword,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 20),
                        labelText: "password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (value) {
                          return Validators.passwordValidator(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(15),
                    onPressed: _saveChanges,
                    child: const Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
