//have login widgets here
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';

//name textfield

//email text field
class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required TextEditingController textController,
    required this.hint,
    required this.icon,
  })  : _controller = textController,
        super(key: key);

  final TextEditingController _controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                this.icon,
                color: Colors.white,
              ),
              hintText: hint,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}

//password text field

//necessary buttons

//one button that takes an on pressed, text
class LoginBtn extends StatelessWidget {
  const LoginBtn(
      {Key? key,
      required this.context,
      required this.text,
      required this.onPressed})
      : super(key: key);

  final context;
  final onPressed;
  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
