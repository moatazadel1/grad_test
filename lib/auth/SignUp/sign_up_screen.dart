import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_app/core/constants/validators.dart';
import 'package:new_app/core/helper/api.dart';
import 'package:new_app/home/homescreen.dart';
import '../login/login.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "Signup";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _confirmPasswordController;
  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _isLoading = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    // Focus Nodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await ApiService.signUp(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmPasswordController.text,
        );
        if (!mounted) return;
        // Handle successful response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response['message']}')),
        );
        if (response['message'] == 'Success') {
          // Navigate to Home screen
          Navigator.of(context).pushReplacementNamed(Login.routeName);
        }
      } catch (e) {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign Up Failed: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash Screen.png"),
                  fit: BoxFit.fill)),
          child: Scaffold(
            body: ListView(children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Center(
                        child: Text(
                          "Create New Account",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff14376A)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                          child: Text(
                        "Enter your personal  ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                      const Center(
                          child: Text(
                        " been missed! ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: "Full name",
                          fillColor: Color(0xffE3F0FF),
                          filled: true,
                          prefixIcon: Icon(
                            IconlyLight.profile,
                          ),
                        ),
                        validator: (value) {
                          return Validators.displayNamevalidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: "Email address",
                          fillColor: Color(0xffE3F0FF),
                          filled: true,
                          prefixIcon: Icon(
                            IconlyLight.message,
                          ),
                        ),
                        validator: (value) {
                          return Validators.emailValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: "*********",
                          fillColor: const Color(0xffE3F0FF),
                          filled: true,
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
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
                        ),
                        validator: (value) {
                          return Validators.passwordValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_confirmPasswordFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: "*********",
                          filled: true,
                          fillColor: const Color(0xffE3F0FF),
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
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
                        ),
                        validator: (value) {
                          return Validators.repeatPasswordValidator(
                              value: value, password: _passwordController.text);
                        },
                        onFieldSubmitted: (value) {
                          _signUp(); // Call the sign-up function
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.topRight,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: const Color(0xff1F41BB),
                  padding: const EdgeInsets.all(15),
                  onPressed: _isLoading ? null : _signUp,
                  child: const Text(
                    "Sign Up ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  padding: const EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Login.routeName);
                  },
                  child: const Text(
                    "Already have an account",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}


  // TextEditingController Email = TextEditingController();

  // TextEditingController Password = TextEditingController();

  // TextEditingController ConfirmPassword = TextEditingController();

  // var formkey = GlobalKey<FormState>();

  // Future<void> CreateAcoount() async {
  //   if (formkey.currentState?.validate() == false) {
  //     return;
  //   }
  //   var authProvider = Provider.of<AuthProvidr>(context, listen: false);
  //   try {
  //     await authProvider.register(Email.text, Password.text);
  //     // After successfully creating the account, you may want to perform additional actions
  //     // such as sending a verification email or navigating to the next screen.
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     } else {
  //       print('Failed to create user account: ${e.message}');
  //     }
  //   }
  // }


// bool isValidEmail(String email) {
//   return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
//       .hasMatch(email);
// }

                // TextFormFieldCustom(
                //   "Email",
                //   controller: _emailController,
                //   Mycontroller: Email,
                //   keyboardType: TextInputType.emailAddress,
                //   validator: (text) {
                //     if (text == null || text.trim().isEmpty) {
                //       return "Please Enter Your Email";
                //     } else if (!isValidEmail(text)) {
                //       return "Invalid email format";
                //     }
                //     return null;
                //   },
                // ),
                //============
                // TextFormFieldCustom(
                //   "Password",
                //   controller: Password,
                //   Mycontroller: Password,
                //   obscureText: true,
                //   validator: (text) {
                //     if (text == null || text.trim().isEmpty) {
                //       return "Please Enter Password";
                //     }
                //     if (text.length < 6) {
                //       return "Password must be at least 6 characters long";
                //     }
                //     return null;
                //   },
                // ),
                // =============
                // TextFormFieldCustom(
                //   "Confirm Password",
                //   controller: ConfirmPassword,
                //   Mycontroller: ConfirmPassword,
                //   obscureText: true,
                //   validator: (text) {
                //     if (text == null || text.trim().isEmpty) {
                //       return "Please enter a password";
                //     }
                //     if (text.length < 6) {
                //       return "Password must be at least 6 characters long";
                //     }
                //     if (text != Password.text) {
                //       return " Password not Match";
                //     }
                //     return null;
                //   },
                // ),
                //=================
