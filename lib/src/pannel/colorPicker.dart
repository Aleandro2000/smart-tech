import "package:flutter/material.dart";
import 'package:color_convert/color_convert.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/templates/flushBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/collections.dart';
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';

class ColorPickerView extends StatefulWidget {
  const ColorPickerView({Key? key}) : super(key: key);

  @override
  State<ColorPickerView> createState() => _ColorPickerViewState();
}

class _ColorPickerViewState extends State<ColorPickerView> {
  Color pickerColor = ThemeColors.primarySwatchTheme;
  Color currentColor = ThemeColors.primarySwatchTheme;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void onSubmit() async {
    try {
      bool success = await colorSettings(
          convert.hex.rgb(pickerColor.value.toRadixString(16).padLeft(6, '0')));
      if (success) {
        FlushBarTemplate(
            context, "MESSAGE!", "Successfully sent data! ;)", true);
      } else {
        FlushBarTemplate(context, "MESSAGE!", "Failed to send data! :(", true);
      }
    } catch (err) {
      FlushBarTemplate(context, "MESSAGE!", "Failed to send data! :(", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(title: "LED Color Picker"),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 640,
                ),
                margin: const EdgeInsets.symmetric(vertical: 50),
                alignment: Alignment.center,
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                  enableAlpha: false,
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
