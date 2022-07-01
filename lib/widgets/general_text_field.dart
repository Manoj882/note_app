import 'package:flutter/material.dart';

class GeneralTextField extends StatefulWidget {
  const GeneralTextField({
    required this.controller,
    required this.title,
    required this.textInputType,
    required this.textInputAction,
    required this.validate,
    Key? key}) : super(key: key);


  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String title;
  final String? Function(String?)? validate;

  @override
  State<GeneralTextField> createState() => _GeneralTextFieldState();
}

class _GeneralTextFieldState extends State<GeneralTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
                controller: widget.controller,
                keyboardType: widget.textInputType,
                textInputAction: widget.textInputAction,
                decoration: InputDecoration(
                  hintText: 'Enter ${widget.title}',
                  
                  
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                   borderSide: BorderSide(
                    color: Colors.black,
                   ),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),

                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.0),),
                  ),

                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15),),
                    
                  ),
                  
                ),
                validator: widget.validate,
              );
    
  }
}