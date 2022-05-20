import "package:flutter/material.dart";
import "package:color_convert/color_convert.dart";
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';

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

  List<int> onSubmit() {
    return convert.hex.rgb(currentColor.value.toRadixString(16));
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
                    onPressed: () {},
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
