import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../style/decoration.dart';
import 'home.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  FormLoginState createState() {
    return FormLoginState();
  }
}

class FormLoginState extends State<FormLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidePw = false;
  late SharedPreferences logindata;
  late bool user;

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    user = logindata.getBool('login') ?? true;

    if (user == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffd59caf),
          ),
          child: Column(
            children: [
              Container(
                height: 458,
                decoration: const BoxDecoration(
                    color: Color(0xffD59CAF),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage('assets/splash.png'),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'LOGIN',
                            style: GoogleFonts.poppins(fontSize: 24),
                          ),
                          Text(
                            'Welcome, please login !',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration: DecorationLoginStyle.decorationLogin(
                                labelText: 'Username',
                                prefixIcon: const Icon(
                                  Icons.person,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: hidePw ? false : true,
                              controller: _passwordController,
                              decoration: DecorationLoginStyle.decorationLogin(
                                labelText: 'Password',
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePw = !hidePw;
                                    });
                                  },
                                  icon: hidePw
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          Icons.visibility_off_rounded),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(800, 35),
                            backgroundColor: const Color(0xffc3516b)),
                        onPressed: () {
                          final isValidForm = _formKey.currentState!.validate();
                          String username = _usernameController.text;
                          if (isValidForm) {
                            logindata.setBool('login', false);
                            logindata.setString('username', username);
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const Home(),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                transitionsBuilder: (_, animation, __, child) {
                                  return ScaleTransition(
                                    scale: animation.drive(
                                      Tween<double>(
                                        begin: 1.5,
                                        end: 1.0,
                                      ).chain(
                                        CurveTween(
                                          curve: Curves.easeInOutBack,
                                        ),
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
