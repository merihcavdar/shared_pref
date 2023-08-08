import 'package:flutter/material.dart';
import 'models.dart';

// ignore: unused_element
RadioListTile buildRadioListTile(
  String title,
  Gender value,
  Gender selectedGender,
  Function onChanged,
) {
  return RadioListTile(
    title: Text(title),
    value: value,
    groupValue: selectedGender,
    onChanged: onChanged(dynamic),
  );
}
