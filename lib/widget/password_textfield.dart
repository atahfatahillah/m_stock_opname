import 'package:flutter/material.dart';
import 'package:m_stock_opname/utils/app_colors.dart';
import 'package:m_stock_opname/utils/values.dart';

// ignore: must_be_immutable
class PasswordTextfield extends StatefulWidget {
  TextEditingController controller;
  String placeholder;
  PasswordTextfield({
    super.key,
    required this.controller,
    required this.placeholder,
  });

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  late TextEditingController _controller;
  late String _placeholder;
  bool _visibility = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _placeholder = widget.placeholder;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: Values.inputHeight,
      child: TextField(
        obscureText: _visibility,
        controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textfieldBackground,
          labelText: _placeholder,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _visibility ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
      ),
    );
  }
}
