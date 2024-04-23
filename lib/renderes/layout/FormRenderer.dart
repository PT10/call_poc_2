import 'dart:convert';

import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/layout/columnLayout.dart';
import 'package:call_poc_2/viewModels/layout/formLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class FormRenderer extends ElementRenderer {
  const FormRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _FormRendererState createState() => _FormRendererState();
}

class _FormRendererState extends ElementRendererState<FormRenderer> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget getWidget() {
    return FormBuilder(
        key: _formKey,
        child: Column(children: [
          Expanded(child: Column(children: _getFields())),
          Expanded(
              child: Column(
            children: _getActions(),
          ))
        ]));
  }

  List<Widget> _getFields() {
    List<Widget> children = [];
    (widget.elementModel as FormLayout).children!.forEach((e) {
      Widget? w = RendererFactory.getWidget(e.subType, e, context: context,
          onAction: (type) {
        if (type == 'refresh') {
          setState(() {});
        }
      }, onPollFinished: widget.onPollFinished);
      if (w == null) {
        return;
      }
      children.add(
          Expanded(child: Card(child: Row(children: [Expanded(child: w)]))));
    });

    return children;
  }

  List<Widget> _getActions() {
    List<Widget> children = [];
    (widget.elementModel as FormLayout).actions!.forEach((e) {
      Widget? w = RendererFactory.getWidget(e.subType, e,
          context: context,
          onAction: widget.onAction, onFormSubmit: (submitAction, action) {
        // Add form data to datamodel
        DataModel componentData =
            Provider.of<DataModel>(context, listen: false);
        Map<String, dynamic> formData = {};
        _formKey.currentState!.fields.forEach((key, value) {
          formData[key] = value.value;
        });
        componentData.setData(formData);

        // Perform submit action
        submitAction.perform(context).then((value) {
          // On response take next action
          if (action != null) {
            componentData.setData(json.decode(value.body));
            action.forEach((element) =>
                element.perform(context, actionCallBack: widget.onAction));
          }
        }).onError((error, stackTrace) {
          print(error);
        });
      }, onPollFinished: widget.onPollFinished);
      if (w == null) {
        return;
      }
      children.add(
          Expanded(child: Card(child: Row(children: [Expanded(child: w)]))));
    });

    return children;
  }
}
