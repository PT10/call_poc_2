import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/layout/tabLayout.dart';
import 'package:flutter/material.dart';

class TabRenderer extends ElementRenderer {
  const TabRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _TabRendererState createState() => _TabRendererState();
}

class _TabRendererState extends ElementRendererState<TabRenderer>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  Widget getWidget() {
    List<Widget> children = [];
    (widget.elementModel as TabLayout).children!.forEach((e) {
      Widget? w = RendererFactory.getWidget(e.subType, e, context: context,
          onAction: (type) {
        if (type == "refresh") {
          setState(() {});
        }

        if (widget.onAction != null) {
          widget.onAction!(type);
        }
      }, onPollFinished: widget.onPollFinished);
      if (w == null || w is Container) {
        return;
      }
      w = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: w)]);
      if (e.giveEqualFlex ?? true) {
        return children.add(w);
      }
      return children.add(w);
    });
    _tabController = TabController(length: children.length, vsync: this);
    return DefaultTabController(
      length: children.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: AppBar(
              bottom: TabBar(
                  controller: _tabController,
                  onTap: (i) {},
                  labelPadding: EdgeInsets.only(bottom: 10, right: 20),
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: (widget.elementModel as TabLayout)
                      .children!
                      .map((e) => Text((e as LayoutBase).title ?? ''))
                      .toList())),
        ),
        body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: children),
      ),
    );
  }
}
