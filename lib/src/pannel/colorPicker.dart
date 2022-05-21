import "package:flutter/material.dart";
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/templates/flushBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/collections.dart';

class ColorPickerView extends StatefulWidget {
  const ColorPickerView({Key? key}) : super(key: key);

  @override
  State<ColorPickerView> createState() => _ColorPickerViewState();
}

class _ColorPickerViewState extends State<ColorPickerView> {
  Color pickerColor = Colors.red;
  Color currentColor = Colors.red;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void onSubmit() async {
    bool success = await colorSettings(
        '#${pickerColor.value.toRadixString(16).padLeft(6, '0')}');
    if (success) {
      FlushBarTemplate(context, "MESSAGE!", "Successfully sent data! ;)", true);
    } else {
      FlushBarTemplate(context, "MESSAGE!", "Failed to send data! :(", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(title: "Color Picker"),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                margin: const EdgeInsets.symmetric(vertical: 50),
                alignment: Alignment.center,
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                margin: const EdgeInsets.symmetric(vertical: 50),
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: onSubmit,
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 18, color: pickerColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
