import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/database/model/userDao.dart';
import 'package:todo/ui/Common/CustonFormField.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:todo/ui/Common/dialogUtilites.dart';
import 'package:todo/ui/register/Register.dart';
import 'package:todo/validation.dart';
import 'package:todo/database/model/user.dart' as myuser;

class LoginScreen extends StatefulWidget {
  static const String routname = 'Login';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextInputType a3 = TextInputType.emailAddress;

  TextInputType a5 = TextInputType.visiblePassword;

  var keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration:  const BoxDecoration(
              color: Color(0xffF7F7F7),
                image: DecorationImage(
                    alignment: AlignmentDirectional.topCenter,
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fitWidth)
            ),
          child: Scaffold(
            backgroundColor:Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title:  Center(child: Text('Log in',style: TextStyle(color: Colors.white),)),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: keyform,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 230,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: CustomFormField(email, 'Email', a3, false, (text) {
                            if (text == null) {
                              return 'please enter your email';
                            }
                            if (validation().isValidEmail(text) == false) {
                              return 'Please enter correct email address';
                            }
                          },is_loginOr_Register: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child:
                          CustomFormField(password, 'Password', a5, true, (text) {
                            if (text == null) return 'enter password';
                            if (password.text.length < 8) {
                              return 'Please enter Correct password';
                            }
                          },is_loginOr_Register: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 12,
                          ),
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ElevatedButton(
                            style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue
                            )
                            ,
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set the border radius to make it circular
                                ),
                              ),
                            ),
                            onPressed: () {
                              login();
                              // Button action
                            },
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      textAlign: TextAlign.left,
                                      'Login',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.arrow_forward_outlined),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.pushReplacementNamed(context, RegisterScreen.routname);

                        }, child: const Text(
                          style: TextStyle(color: Colors.blue),

                          'Creat account?'

                        ))
                      ]),
                ),
              ),
            ),
          ),
      );
  }

  void login() async {

    if (keyform.currentState?.validate() == false) {
      return;
    }
    try {
      dialogUtilites.lodingDialog(context, 'please wait');

      provider obj = Provider.of<provider>(context,listen: false);
      // Navigate to HomeScreen only if login is successful
      if (keyform.currentState?.validate() == true) {
       await obj.login(email.text, password.text);
        dialogUtilites.showmsg(context, 'Login successful',postAction:() {
          Navigator.of(context).pop(); // Dismiss the dialog
          Navigator.of(context).
          pushReplacementNamed(HomeScreen.routname);
        }
        );

      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    dialogUtilites.hideDialog(context,"Wrong email or password",postAction:() {
      Navigator.of(context).pop(); // Dismiss the dialog
    }

    );
    }
  }
}
