import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.textInputAction,
    this.subfixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
  });
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Icon? subfixIcon;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.grey),
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: widget.subfixIcon,
          prefixIcon: widget.prefixIcon,
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
        ));
  }
}
