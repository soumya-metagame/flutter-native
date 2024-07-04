import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onBackspace;

  const OtpInput(
      {super.key, required this.controller,
      required this.onChanged,
      required this.focusNode,
      required this.onBackspace});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.yellowAccent, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          onChanged(value);
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(4, 0, 0, 8),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onFieldSubmitted: (_) {
          FocusScope.of(context).nextFocus();
        },
        onEditingComplete: () {
          print('----------------------------- $controller');
          if (controller.text.isEmpty) {
            onBackspace();
          }
        },
      ),
    );
  }
}
