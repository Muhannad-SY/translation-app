import 'package:flutter/material.dart';
import 'package:translation_app/providers/login_logout_provider.dart';



class CostumNonTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? valedateText;
  final IconData? prefix;
   bool? hide;
   final Widget? hideIcon;

  CostumNonTextFormFiled({
    this.valedateText,
    this.controller,
    this.hintText,
    this.onChanged,
    this.prefix,
    this.hide,
    this.hideIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        child: TextFormField(

      validator: (value) {
        if (value == null || value.isEmpty) {
      return this.valedateText;
      }
      return null;
      },
          obscureText: this.hide!,
            onChanged:  this.onChanged,
            controller: this.controller,
            decoration: InputDecoration(
              suffixIcon: this.hideIcon,
              prefixIcon: Icon(this.prefix),
              hintText: this.hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 4, 41, .7),
                    width: 1.5
                ),),
              contentPadding: EdgeInsets.only(left: 20 , top: 30),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color:  Colors.white
                  )
              ),

            ),

        ),
      ),
    );
  }
}