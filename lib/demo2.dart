import 'dart:math';

import 'package:flutter/material.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage3> {
  late final ScrollController _scrollController;
  final GlobalKey _listKey = GlobalKey();
  List<GlobalKey> globalKeys = [];
  int centerItemIndex = 0;

  int selectedIndex = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    if (globalKeys.isEmpty) {
      globalKeys = List.generate(
        10,
        (index) => GlobalKey(debugLabel: index.toString()),
      );
      _scrollController.addListener(() async {
        await Future.delayed(Duration(milliseconds: 600));
        setState(() {
          centerItemIndex = getCenterItemIndex();
          print("centerItemIndex: $centerItemIndex");
        });
      });
    }

    super.initState();
  }

  int getCenterItemIndex() {
    final listViewBox = _listKey.currentContext!.findRenderObject() as RenderBox?;
    final listViewTop = listViewBox!.localToGlobal(Offset.zero).dy;
    final listViewBottom = listViewTop + listViewBox.size.height;
    final listViewCenter = listViewTop + listViewBox.size.height / 2;

    for (var i = 0; i < 10; i++) {
      var itemTop = 0.0;
      var itemBottom = 0.0;
      try {
        final itemBox = globalKeys[i].currentContext!.findRenderObject() as RenderBox?;
        itemTop = itemBox!.localToGlobal(Offset.zero).dy;
        itemBottom = itemTop + itemBox.size.height;
      } catch (e) {
        // handle exception if item is not visible
      }

      if (itemTop > listViewBottom) {
        break;
      }

      if (itemTop <= listViewCenter && itemBottom >= listViewCenter) {
        return i;
      }
    }

    return -1; // if no item is in the center of the screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        key: _listKey,
        itemCount: 10,
        itemBuilder: (context, index) {
          return RenderObjectDemoWidget(
            key: globalKeys[index],
            index: index,
            currentIndex: centerItemIndex,
          );
        },
      ),
    );
  }
}

class RenderObjectDemoWidget extends StatelessWidget {
  final int index;
  final int currentIndex;
  const RenderObjectDemoWidget({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    var scale = index == currentIndex ? 1.0 : 0.8;

    return TweenAnimationBuilder(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 350),
      tween: Tween(begin: scale, end: scale),
      builder: (context, value, child) {
        return Transform.scale(
          scale: scale,
          child: child!,
        );
      },
      child: DummyWidget2(
        isActive: index == currentIndex ? true : false,
        color: colorList[Random().nextInt(10)],
      ),
    );
  }
}

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> with AutomaticKeepAliveClientMixin {
  late final PageController pageViewController;
  int selectedIndex = 0;
  @override
  void initState() {
    pageViewController = PageController(viewportFraction: 0.3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Text("R&D"),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("R&D demo", style: TextStyle(fontSize: 25)),
            Container(
              margin: const EdgeInsets.all(10),
              height: 400,
              width: double.infinity,
              color: Colors.lightBlue,
            ),
            SizedBox(
              height: 800,
              child: PageView.builder(
                allowImplicitScrolling: true,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                controller: pageViewController,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  var scale = selectedIndex == index ? 1.0 : 0.8;
                  return TweenAnimationBuilder(
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 350),
                    tween: Tween(begin: scale, end: scale),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child!,
                      );
                    },
                    child: DummyWidget2(
                      isActive: index == selectedIndex ? true : false,
                      color: colorList[index],
                    ),
                  );
                },
              ),
            ),
            Text("Created By"),
            Placeholder(),
            SizedBox(height: 20),
            Text("Created By"),
            Placeholder(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DummyWidget2 extends StatefulWidget {
  final bool isActive;
  final Color color;
  const DummyWidget2({
    super.key,
    required this.isActive,
    required this.color,
  });

  @override
  State<DummyWidget2> createState() => _DummyWidget2State();
}

class _DummyWidget2State extends State<DummyWidget2> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      width: widget.isActive ? 600 : 800,
      height: widget.isActive ? 250 : 350,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        foregroundDecoration: BoxDecoration(
          color: !widget.isActive ? Colors.grey : Colors.transparent,
          backgroundBlendMode: BlendMode.saturation,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Opacity(
          opacity: widget.isActive ? 1 : 0.5,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dummy Title',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "In irure exercitation proident adipisicing cillum do enim ipsum nostrud labore quis. Adipisicing consequat occaecat deserunt proident officia deserunt ea ipsum nisi cillum do. Sit nisi exercitation ut aute est. In deserunt qui consequat consequat nulla est veniam.",
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var colorList = List.generate(10, (index) => Colors.primaries[Random().nextInt(Colors.primaries.length)]);
