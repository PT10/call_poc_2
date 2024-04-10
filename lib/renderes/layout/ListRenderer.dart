import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/listLayout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRenderer extends ElementRenderer {
  const ListRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _ListRendererState createState() => _ListRendererState();
}

class _ListRendererState extends ElementRendererState<ListRenderer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget getWidget() {
    DataModel dataModel = Provider.of<DataModel>(context, listen: false);
    List<dynamic> myData = [];
    // var respObj = json.decode(resp.body);
    if (dataModel.data["status"] == 1) {
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

    ListLayout listModel = widget.layoutModel as ListLayout;
    return ListView.builder(
      itemCount: myData.isNotEmpty ? myData.length : listModel.children?.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (listModel.itemRendererModel != null) {
          DataModel newModel = DataModel(dataModel.data);
          newModel.setData(dataModel.data["data"][index]);

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
