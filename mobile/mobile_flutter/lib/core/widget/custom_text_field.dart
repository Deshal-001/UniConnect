import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            )),
        TextFormField(
          controller: widget.controller,
          cursorHeight: 20,
          cursorColor: Colors.grey,
          obscureText: obscureText,
          obscuringCharacter: '*',
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            errorBorder: InputBorder.none,
            errorStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.red,
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey,
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  child: SvgPicture.asset(
                      'assets/icons/eye.svg',
                      height: 15,
                      width: 15,
                      fit: BoxFit.scaleDown,
                    ),
                )
                // IconButton(
                //     icon: const Icon(Icons.visibility_off),
                //     onPressed: () {
                //       setState(() {
                //         obscureText = !obscureText;
                //       });
                //     },
                //   )
                : null,
          ),
        ),
      ],
    );
  }
}
