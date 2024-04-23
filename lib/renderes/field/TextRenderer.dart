import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/textButtonField.dart';
import 'package:call_poc_2/viewModels/field/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TextRenderer extends ElementRenderer {
  const TextRenderer(super.type, super.elementModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _TextRendererState createState() => _TextRendererState();
}

class _TextRendererState extends ElementRendererState<TextRenderer> {
  @override
  Widget getWidget(CustomDataModel? customModel) {
    TextFieldCustom fieldModel = widget.elementModel as TextFieldCustom;
    return FormBuilderTextField(
      key: GlobalKey(),
      name: fieldModel.id,
      obscureText: fieldModel.obscure,
      decoration: InputDecoration(
        //icon: const Icon(Icons.person),
        hintText: fieldModel.hintText,
        labelText: fieldModel.label,
      ),
    );
  }
}
