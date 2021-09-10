import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {
  String label;
  double width;
  bool obscureText=true;
  bool haveObscureText=false;
  Icon icon;
  TextEditingController controller;
  CustomTextFeild({required this.label, required this.width, required this.controller, required this.icon,});
  @override
  _CustomTetFieldState createState() => _CustomTetFieldState();
}

class _CustomTetFieldState extends State<CustomTextFeild> {
  FocusNode _focusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        style:  TextStyle(
            fontSize: 13.5,fontWeight: FontWeight.w600,color: Color(0xff1075fb).withOpacity(0.95),
        ),
        focusNode: _focusNode,
        onTap: _requestFocus,
        obscureText: (widget.haveObscureText)?widget.obscureText:false,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle:  TextStyle(
              fontSize: 13.5,fontWeight: FontWeight.w600,color: (!_focusNode.hasFocus)?Color(0xff979797).withOpacity(0.75):Color(0xff1075fb).withOpacity(0.75)
          ),
          border: new OutlineInputBorder(
              borderSide: BorderSide.none,borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Color(0xff0577f2),width: 1.3)),
          filled: true,

          fillColor: Colors.white,
          prefixIcon: widget.icon,
          contentPadding: EdgeInsets.symmetric(vertical: 22,horizontal: 10),

        ),
      ),
    );
  }
  void _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }
}

