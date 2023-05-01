import 'dart:math';

import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

var cardAspectRatio = 12 / 16;
var widgetAspectRatio = cardAspectRatio * 1.2;
var verticalInset = 20.0;

class _MyAppState extends State<MyApp> {
  var currentPage = images.length - 1;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Story App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 30, bottom: 8),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, bottom: 8, right: 12, top: 30),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Trending',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontFamily: 'Calibre-SemiBold',
                        letterSpacing: 1),
                  ),
                  Icon(
                    Icons.more_horiz,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFFff6e6e),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                      child: Center(
                        child: Text(
                          'Animated',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    '25+Storied',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                CardScrollWidget(currentPage: currentPage),
                Positioned.fill(
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return Container();
                    },
                    itemCount: images.length,
                    controller: controller,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Favourites',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontFamily: 'Calibre-SemiBold',
                        letterSpacing: 1),
                  ),
                  Icon(
                    Icons.more_horiz,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                      child: Center(
                        child: Text(
                          'Animated',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    '10+Storied',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/image_02.jpg',
                      width: 296,
                      height: 222,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20;
  CardScrollWidget({super.key, this.currentPage});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, contraints) {
          double widht = contraints.maxWidth;
          double height = contraints.maxHeight;

          var safeWidht = widht - 2 * padding;
          var safeHeight = widht - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidht - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          var cardList = <Widget>[];

          for (var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            double start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(delta, 0.0),
              bottom: padding + verticalInset * max(delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(
                            3.5,
                            6.0,
                          ),
                          blurRadius: 12),
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          images[i],
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  title[i],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: 'SF-Pro-Text_Retular.otf'),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Read another Time',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );

            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
