import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
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
