class BaseValueModel {
  String name, id;
  Map<String, dynamic>? properties;

  BaseValueModel({required this.name, required this.id, this.properties});

  factory BaseValueModel.fromJson(String type, Map<String, dynamic> values,
      String? uidField, String? nameField) {
    return BaseValueModel(
        id: values[uidField ?? 'id'],
        name: values[nameField ?? 'name'],
        properties: values);
  }
}
