import 'package:call_poc_2/form/appFormField.dart';
import 'package:flutter/material.dart';

class FormBuilder extends StatefulWidget {
  final dynamic fieldsObj;
  const FormBuilder(this.fieldsObj, {super.key});

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.fieldsObj["fields"].length,
      itemBuilder: (context, index) {
        AppFormField f = AppFormField.fromJson(
            widget.fieldsObj["fields"][index],
            widget.fieldsObj["fields"][index]["type"]);

        return f.build();
      },
    );
  }
}
