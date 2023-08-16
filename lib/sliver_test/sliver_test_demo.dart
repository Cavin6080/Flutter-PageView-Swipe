import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> with AutomaticKeepAliveClientMixin {
  late final PageController pageViewController;
  int selectedIndex = 0;
  int scrollOffset = 200;
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
        title: const Text("R&D"),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: 800,
                child: SwipeDetector(
                  onSwipeDown: (offset) {
                    print("dpwn");
                    pageViewController.animateTo(
                      scrollOffset - 200,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                    scrollOffset -= 200;
                  },
                  onSwipeUp: (offset) {
                    pageViewController.animateTo(
                      scrollOffset + 200,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                    scrollOffset += 200;
                  },
                  // onTap: () {
                  //   scrollOffset += 200;
                  //   pageViewController.animateTo(
                  //     scrollOffset + 200,
                  //     duration: Duration(seconds: 1),
                  //     curve: Curves.easeIn,
                  //   );
                  // },
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                        child: DemoWidget(
                          isActive: index == selectedIndex ? true : false,
                          color: colorList[index],
                        ),
                      );
                    },
                  ),
                )),
          ),
          const SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
                ListTile(title: Text("Demo")),
              ],
            ),
          )
        ],
      ),
      // body: SingleChildScrollView(
      //   primary: true,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       const Text("R&D demo", style: TextStyle(fontSize: 25)),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         height: 400,
      //         width: double.infinity,
      //         color: Colors.lightBlue,
      //       ),
      //       SizedBox(
      //         height: 800,
      //         child: PageView.builder(
      //           allowImplicitScrolling: true,
      //           onPageChanged: (index) {
      //             setState(() {
      //               selectedIndex = index;
      //             });
      //           },
      //           controller: pageViewController,
      //           scrollDirection: Axis.vertical,
      //           itemCount: 10,
      //           itemBuilder: (BuildContext context, int index) {
      //             var scale = selectedIndex == index ? 1.0 : 0.8;
      //             return TweenAnimationBuilder(
      //               curve: Curves.easeOut,
      //               duration: const Duration(milliseconds: 350),
      //               tween: Tween(begin: scale, end: scale),
      //               builder: (context, value, child) {
      //                 return Transform.scale(
      //                   scale: value,
      //                   child: child!,
      //                 );
      //               },
      //               child: DemoWidget(
      //                 isActive: index == selectedIndex ? true : false,
      //                 color: colorList[index],
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //       Text("Created By"),
      //       Placeholder(),
      //       SizedBox(height: 20),
      //       Text("Created By"),
      //       Placeholder(),
      //     ],
      //   ),
      // ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DemoWidget extends StatefulWidget {
  final bool isActive;
  final Color color;
  const DemoWidget({
    super.key,
    required this.isActive,
    required this.color,
  });

  @override
  State<DemoWidget> createState() => _DummyWidget2State();
}

class _DummyWidget2State extends State<DemoWidget> {
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
