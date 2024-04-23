import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/gridLayout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridRenderer extends ElementRenderer {
  const GridRenderer(super.type, super.elementModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _GridRendererState createState() => _GridRendererState();
}

class _GridRendererState extends ElementRendererState<GridRenderer> {
  @override
  Widget getWidget(CustomDataModel? customModel) {
    DataModel dataModel = Provider.of<DataModel>(context, listen: false);
    GridLayout grid = widget.elementModel as GridLayout;
    return Card(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: grid.numCols),
      itemCount: dataModel.data["data"].length,
      itemBuilder: (context, index) {
        DataModel oldModel = Provider.of<DataModel>(context, listen: false);
        DataModel newModel = DataModel(oldModel.data);
        newModel.setData(oldModel.data["data"][index]);

        return ChangeNotifierProvider<DataModel>.value(
            value: newModel,
            builder: (ctx, w) {
              BaseModel e = grid.itemRendererModel!.createItem();
              return RendererFactory.getWidget(e.subType, e,
                  context: context,
                  onAction: widget.onAction,
                  onPollFinished: widget.onPollFinished);
            });
      },
    ));
  }
}
