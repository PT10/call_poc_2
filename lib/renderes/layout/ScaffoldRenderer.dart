import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/layout/columnLayout.dart';
import 'package:call_poc_2/viewModels/layout/scaffoldLayout.dart';
import 'package:flutter/material.dart';

class ScaffoldRenderer extends ElementRenderer {
  const ScaffoldRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _ScaffoldRendererState createState() => _ScaffoldRendererState();
}

class _ScaffoldRendererState extends ElementRendererState<ScaffoldRenderer> {
  @override
  Widget getWidget() {
    ScaffoldLayout model = (widget.elementModel as ScaffoldLayout);
    return Scaffold(
      appBar: AppBar(
          title: Text(model.appBar?.title ?? ''),
          actions: model.appBar?.actions?.map((e) {
            Widget? w = RendererFactory.getWidget(
              e.subType,
              e,
              context: context,
            );

            return w ?? Container();
          }).toList()),
      drawer: model.appBar?.menu != null
          ? Drawer(
              child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: model.appBar!.menu!
                      .map((e) => DrawerHeader(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Text(e.buttonText ?? ''),
                          ))
                      .toList()),
            )
          : null,
      body: Column(
          children: model.children!.map((e) {
        Widget? w = RendererFactory.getWidget(e.subType, e, context: context,
            onAction: (type) {
          if (type == "refresh") {
            setState(() {});
          }

          if (widget.onAction != null) {
            widget.onAction!(type);
          }
        }, onPollFinished: widget.onPollFinished);
        if (w == null) {
          return Container();
        }
        return Expanded(
            child: Card(child: Row(children: [Expanded(child: w)])));
      }).toList()),
      bottomNavigationBar: model.bottomBar != null
          ? BottomNavigationBar(
              items: model.bottomBar!
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: const Icon(Icons.home),
                      label: e.buttonText,
                    ),
                  )
                  .toList())
          : null,
    );
  }
}
