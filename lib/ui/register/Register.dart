import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/model/userDao.dart';
import 'package:todo/database/model/user.dart' as myuser;
import 'package:todo/ui/Common/CustonFormField.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:todo/ui/login/Login.dart';
import 'package:todo/validation.dart';
import 'package:todo/fireBaseError.dart';
import 'package:todo/ui/Common/dialogUtilites.dart';

class RegisterScreen extends StatefulWidget {
  static const String routname = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController FirstName = TextEditingController();

  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();

  TextEditingController ConfirmedPassword = TextEditingController();

  TextInputType a3 = TextInputType.emailAddress;

  TextInputType a4 = TextInputType.name;

  TextInputType a5 = TextInputType.visiblePassword;

  TextInputType a7 = TextInputType.visiblePassword;

  var keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height:40,
      decoration: const BoxDecoration(
        color: Color(0xffF7F7F7),
        image: DecorationImage(
            alignment: AlignmentDirectional.topCenter,
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fitWidth),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:  const Center(child: Text('Create Account',style: TextStyle(color: Colors.white))),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: keyform,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 180),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: CustomFormField(
                            FirstName, 'First Name', a4, false, (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter your name';
                          }
                        },is_loginOr_Register: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child:
                            CustomFormField(Email, 'Email', a3, false, (text) {
                          if (text == null ||
                              validation().isValidEmail(text) == false) {
                            return 'Please enter right email address';
                          }
                        },is_loginOr_Register: true),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: CustomFormField(Password, 'Password', a5, true,
                            (text) {
                          if (text == null || text.length < 8) {
                            return 'Please make sure your password is at least 8 characters';
                          }
                          return null;
                        },is_loginOr_Register: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: CustomFormField(ConfirmedPassword,
                            'Confirmation Password', a7, true, (text) {
                          if (text == null || text.length < 8) {
                            return 'Please Enter your password';
                          }
                          if (Password.text != text) {
                            return 'Different password';
                          }
                          return null;
                        },is_loginOr_Register: true),
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
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the border radius to make it circular
                              ),
                            ),
                          ),
                          onPressed: () {
                            oncreate();

                            // Button action
                          },
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    'Create Account',
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
                        Navigator.pushReplacementNamed(context, LoginScreen.routname);

                      }, child: Text(
                        style: TextStyle(color: Colors.blue),
                          'ALready have account?'
                      ))
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void oncreate() async {
    if (keyform.currentState?.validate() == false) {
      return;
    }
    try {
      dialogUtilites.lodingDialog(context, "Please wait");
      provider obj = Provider.of<provider>(context, listen: false);
      if (keyform.currentState?.validate() == true) {
       await  obj.register(Email.text, Password.text, FirstName.text);
        dialogUtilites.showmsg(context, 'registered successfully',
            postAction: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routname);
            });
        // Remove the following line
        // Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == fireBaseError.password) {
        print('The password provided is too weak.');
      } else if (e.code == fireBaseError.email) {
        print('The account already exists for that email.');
      }
      dialogUtilites.hideDialog(context, "This email already exists",
          postAction: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          });
    } catch (e) {
      print(e);
    }
  }
}
