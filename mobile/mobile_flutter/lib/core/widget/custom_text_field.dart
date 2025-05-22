import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:uniconnect_app/core/constants/solid_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool isDatePicker;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.isDatePicker = false,
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
                      // ignore: deprecated_member_use
                      color: obscureText
                          ? Colors.grey
                          : const Color(AppSolidColors.primary),
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
                : widget.isDatePicker
                    ? GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1948),
                            lastDate: DateTime(2100),
                          ).then((value) {
                            if (value != null) {
                              DateFormat('dd/MM/yyyy').format(value);
                              widget.controller.text = DateFormat('dd/MM/yyyy').format(value);
                            }
                          });
                        },
                        child: const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 15,
                        ),
                        //  SvgPicture.asset(
                        //   'assets/icons/calendar.svg',
                        //   height: 15,
                        //   width: 15,
                        //   fit: BoxFit.scaleDown,
                        // ),
                      )
                    : null,
          ),
        ),
      ],
    );
  }
}
