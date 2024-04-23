import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/labelField.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/layout/listLayout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRenderer extends ElementRenderer {
  const ListRenderer(super.type, super.elementModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _ListRendererState createState() => _ListRendererState();
}

class _ListRendererState extends ElementRendererState<ListRenderer> {
  @override
  Widget getWidget(CustomDataModel? customModel) {
    DataModel dataModel = Provider.of<DataModel>(context, listen: false);
    List<dynamic> myData = [];
    bool? useCustomModel =
        (widget.elementModel as LayoutBase).consumeCustomDataModel;

    // Use custom model if marked so
    if (useCustomModel ?? false) {
      myData = customModel?.data ?? [];
    } else if (dataModel.data["status"] == 1) {
      myData = (dataModel.data["data"] as List<dynamic>);
      if (myData.isEmpty) {
        return const Center(
          child: Text("No results found"),
        );
      }
    } else {
      return Center(
        child: Text(dataModel.data["message"]),
      );
    }

    ListLayout listModel = widget.elementModel as ListLayout;
    if (myData.isEmpty && (listModel.children?.isEmpty ?? true)) {
      return Text((widget.elementModel as ListLayout).emptyText);
    }
    return ListView.builder(
      itemCount:
          myData.isNotEmpty ? myData.length : listModel.children?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: (widget.elementModel as ListLayout).horizontal
          ? Axis.horizontal
          : Axis.vertical,
      itemBuilder: (context, index) {
        if (listModel.itemRendererModel != null) {
          DataModel newModel = DataModel({});
          if (useCustomModel ?? false) {
            newModel.setData(myData[index]);
          } else if (dataModel.data.containsKey("data")) {
            newModel.setData(dataModel.data);
            newModel.setData(dataModel.data["data"][index]);
          }

          return ChangeNotifierProvider<DataModel>.value(
              value: newModel,
              builder: (ctx, w) {
                BaseModel e = listModel.itemRendererModel!.createItem();

                return SizedBox(
                    height: 100,
                    child: Card(
                        child: RendererFactory.getWidget(e.subType, e,
                            context: context,
                            onAction: widget.onAction,
                            onPollFinished: widget.onPollFinished)));
              });
        } else if (listModel.children != null) {
          return RendererFactory.getWidget(
              listModel.children![index].subType, listModel.children![index],
              context: context,
              onAction: widget.onAction,
              onPollFinished: widget.onPollFinished);
        } else {
          return const Center(
            child: Text("No item found"),
          );
        }
      },
    );
  }
}
