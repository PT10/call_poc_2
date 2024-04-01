import 'package:call_poc_2/viewModels/valueModel/baseValueModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppFormField {
  String type;
  BaseValueModel? value;
  List<BaseValueModel> availableValues;
  String? api;
  Map<String, dynamic>? apiParams;
  List<dynamic>? actions;
  String? nameField, idField;

  AppFormField(this.type,
      {this.value,
      this.availableValues = const [],
      this.api,
      this.apiParams,
      this.nameField,
      this.idField});

  factory AppFormField.fromJson(Map<String, dynamic> config, String type) {
    switch (type) {
      case 'dropdown':
        return DropdownField(
            api: config["api"],
            apiParams: config["params"],
            idField: config['idField'],
            nameField: config['nameField']);
      case 'grid':
        return GridField(config["numCols"],
            api: config["api"],
            apiParams: config["params"],
            idField: config['idField'],
            nameField: config['nameField']);
      case 'list':
        return ListField(
            api: config["api"],
            apiParams: config["params"],
            idField: config['idField'],
            nameField: config['nameField']);
      default:
        return DropdownField(
            api: config["api"],
            apiParams: config["params"],
            idField: config['idField'],
            nameField: config['nameField']);
    }
  }

  Widget build();
}

class DropdownField extends AppFormField {
  DropdownField(
      {super.value,
      super.availableValues = const [],
      super.api,
      super.apiParams,
      super.nameField,
      super.idField})
      : super("dropdown");

  @override
  Widget build() {
    Rx<BaseValueModel?> selectedValue = value.obs;
    return Obx(() => DropdownButton<BaseValueModel>(
          items: availableValues
              .map((e) => DropdownMenuItem<BaseValueModel>(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList(),
          value: selectedValue.value,
          onChanged: (value) {
            selectedValue.value = value;
          },
        ));
  }
}

class GridField extends AppFormField {
  int numColumns;
  GridField(this.numColumns,
      {super.value,
      super.availableValues = const [],
      super.api,
      super.apiParams,
      super.nameField,
      super.idField})
      : super("grid");

  @override
  Widget build() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numColumns),
      itemBuilder: (context, index) {
        BaseValueModel model = availableValues[index];
        return Container(
          child: Text(model.properties?["name"]),
        );
      },
    );
  }
}

class ListField extends AppFormField {
  ListField(
      {super.value,
      super.availableValues = const [],
      super.api,
      super.apiParams,
      super.nameField,
      super.idField})
      : super("dropdown");

  @override
  Widget build() {
    return ListView.builder(
      itemCount: availableValues.length,
      itemBuilder: (context, index) {
        BaseValueModel model = availableValues[index];
        return Container(
          child: Text(model.properties?["name"]),
        );
      },
    );
  }
}
