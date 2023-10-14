import 'package:bondhu_mithai_app/Screen/HomeScreen/Delivery/AllOrder.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FrontSlider extends StatefulWidget {
  const FrontSlider({super.key});

  @override
  State<FrontSlider> createState() => _FrontSliderState();
}

class _FrontSliderState extends State<FrontSlider> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      
        child: PageView(
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          controller: controller,
          children: [
            buildPage(
                color: Colors.white,
                UrlImage: "lib/images/animation_lk77w75p.json",
                Title: "Hello Our Member",
                Subtitle:
                    "আমাদের এখানে আপনি সকল খাদ্য দ্রব্য খুবই সুলভ মূল্যে পেয়ে যাবেন।৫০% ডিসকাউন্ট দিয়ে ক্রয় করতে পারবেন।ধন্যবাদ আপনাকে আবার আসবেন স্যার।"),

            // Container(
            //   color: Colors.red,
            //   child: Center(
            //     child: Text(
            //       "Page 1",
            //       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            buildPage(
                color: Colors.white,
                UrlImage: "lib/images/animation_lk772lso.json",
                Title: "Hello Our Member",
                Subtitle:
                    ""),

            buildPage(
                color: Colors.white,
                UrlImage: "lib/images/animation_lk77t0ex.json",
                Title: "Hello Our Member",
                Subtitle:
                    ""),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      minimumSize: Size.fromHeight(80)),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("showHome", true);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => AllOrder())));
                  },
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: SlideEffect(
                          spacing: 8.0,
                          radius: 4.0,
                          dotWidth: 17.0,
                          dotHeight: 16.0,
                          paintStyle: PaintingStyle.stroke,
                          strokeWidth: 1.5,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.purple),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      )),
                ],
              ),
            ),
    );
  }
}

Widget buildPage(
        {required Color color,
        required String UrlImage,
        required String Title,
        required String Subtitle}) =>
    Container(
      color: color,
      child: CustomPaint(
        painter: CurvePainter(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 64,
            ),
            Text(
              Title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 64,
            ),
            Center(
              child: Lottie.asset(
                UrlImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Subtitle,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
