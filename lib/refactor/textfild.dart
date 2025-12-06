import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  const Field({
    this.controller,
    required this.fieldname,
    this.isPassword = false, // لتحديد إذا الحقل كلمة مرور
    super.key,
  });

  final String fieldname;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // إذا الحقل كلمة مرور نخفي النص
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText, // يخفي النص إذا كلمة مرور
      decoration: InputDecoration(
        hintText: widget.fieldname,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        // إذا كلمة مرور، يمكن إضافة أيقونة لاحقاً لتبديل الإخفاء
      ),
    );
  }
}
