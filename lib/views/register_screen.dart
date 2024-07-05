import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:m_stock_opname/entities/users.dart';
import 'package:m_stock_opname/routers/router_utils.dart';
import 'package:m_stock_opname/services/app_db.dart';
import 'package:m_stock_opname/utils/locator.dart';
import 'package:m_stock_opname/utils/utils.dart';
import 'package:m_stock_opname/widget/password_textfield.dart';

import '../utils/app_theme.dart';
import '../utils/values.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final database = locator<AppDB>();
  final _etFullNameController = TextEditingController();
  final _etUsernameController = TextEditingController();
  final _etPasswordController = TextEditingController();
  final _etRePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _etFullNameController.dispose();
    _etUsernameController.dispose();
    _etPasswordController.dispose();
    _etRePasswordController.dispose();
  }

  void doRegister(String fullName, String username, String password,
      String rePassword) async {
    String message = "";
    if (fullName.isEmpty || fullName.length == 0) {
      message = "Full name can't be empty";
    } else if (username.isEmpty || username.length == 0) {
      message = "Username can't be empty";
    } else if (password.isEmpty || password.length == 0) {
      message = "Password can't be empty";
    } else if (rePassword.isEmpty || rePassword.length == 0) {
      message = "Re Password can't be empty";
    } else if (password != rePassword) {
      message = "Password doesn't match with Re Password";
    } else {
      await database.usersDao
          .insertUser(
        Users(
          username: username,
          password: Crypt.sha256(password).toString(),
          full_name: fullName,
        ),
      )
          .whenComplete(
        () {
          message = "Success";
          showToast(message);
          context.goNamed(APP_PAGE.login.routeName);
        },
      );
    }

    if (message.isNotEmpty) {
      showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 18, bottom: 18),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: Values.inputHeight,
                  child: TextField(
                    controller: _etFullNameController,
                    decoration: AppTheme.getInputDecoration('Full Name'),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: Values.inputHeight,
                  child: TextField(
                    controller: _etUsernameController,
                    decoration: AppTheme.getInputDecoration('Username'),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                PasswordTextfield(
                    controller: _etPasswordController, placeholder: "Password"),
                const SizedBox(
                  height: 15,
                ),
                PasswordTextfield(
                    controller: _etRePasswordController,
                    placeholder: "Retype Password"),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FilledButton(
                    onPressed: () => {
                      // context.goNamed(APP_PAGE.home.routeName)
                      doRegister(
                          _etFullNameController.text,
                          _etUsernameController.text,
                          _etPasswordController.text,
                          _etRePasswordController.text)
                    },
                    child: const Text(
                      'Submit',
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
