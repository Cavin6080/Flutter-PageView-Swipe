import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController pageViewController;
  late final ScrollController _scrollController;
  int selectedIndex = 0;

  @override
  void initState() {
    pageViewController = PageController(viewportFraction: 0.3);
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RenderObjectDemoWidget(selectedIndex: selectedIndex),
          ],
        ),
      ),
      // body: NestedScrollView(
      //   controller: _scrollController,
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //     return <Widget>[
      //       SliverOverlapAbsorber(
      //         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      //         sliver: SliverAppBar(
      //           expandedHeight: MediaQuery.of(context).size.height * 0.85,
      //           flexibleSpace: FlexibleSpaceBar(
      //             background: Image.network(
      //               'https://source.unsplash.com/random?monochromatic+dark',
      //               fit: BoxFit.cover,
      //             ),
      //             title: Text("R&D"),
      //           ),
      //         ),
      //       ),
      //     ];
      //   },
      //   body: _pageView(),
      // ),
    );
  }

  _pageView() {
    return PageView.builder(
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
          child: DummyWidget(
            isActive: index == selectedIndex ? true : false,
            color: colorList[index],
          ),
        );
      },
    );
  }
}

class RenderObjectDemoWidget extends StatelessWidget {
  const RenderObjectDemoWidget({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final renderObject = context.findRenderObject() as RenderBox;
    final offsetY = renderObject.localToGlobal(Offset.zero).dy;
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final relativePosition = offsetY / deviceHeight;
    var scale = relativePosition == 0.5 ? 1.0 : 0.8;

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
      child: DummyWidget(
        isActive: relativePosition == 0.5 ? true : false,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("R&D", style: TextStyle(fontSize: 25)),
            SizedBox(
              height: 800,
              child: PageView.builder(
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
                    child: DummyWidget(
                      isActive: index == selectedIndex ? true : false,
                      color: colorList[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DummyWidget extends StatelessWidget {
  final bool isActive;
  final Color color;
  const DummyWidget({
    super.key,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      width: isActive ? 100 : 200,
      height: isActive ? 100 : 200,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        foregroundDecoration: BoxDecoration(
          color: !isActive ? Colors.grey : Colors.transparent,
          backgroundBlendMode: BlendMode.saturation,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Opacity(
          opacity: isActive ? 1 : 0.5,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lagging Indicators',
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
