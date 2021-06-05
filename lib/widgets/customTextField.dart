import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData data;
  final GestureTapCallback onTap;
  final String hintText;
  int length;
  bool isObsecure = true;
  final FocusNode focusNode;
  final FocusNode nextNode;
  ValueChanged<String> onFieldsubmitted;
  final TextInputAction textInputAction;
  final TextInputType keybordtype;
  CustomTextField({
    this.controller,
    this.onTap,
    this.textInputAction,
    this.keybordtype,
    this.data,
    this.onFieldsubmitted,
    this.hintText,
    this.isObsecure,
    this.nextNode,
    this.length,
    this.focusNode,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: widget.length,
        style: TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
        onTap: widget.onTap,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keybordtype,
        onFieldSubmitted: widget.onFieldsubmitted,
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: widget.isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15, top: 15),
          filled: true,
          fillColor: Colors.grey[800],
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[800],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey[800],
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                widget.controller.clear();
              });
            },
            child: Icon(
              Icons.clear,
              color: Colors.white,
              size: 20,
            ),
          ),
          focusColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
