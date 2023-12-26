import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'package:contact_buddy_app/models/introduction.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  //Initial State Overrides Constructor
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  //Dispose State Overrides
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //Update isViewed States Page Count
  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onboard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Text("Skip"),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PageView.builder(
              itemCount: screens.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(screens[index].img),
                    Container(
                      height: 10.0,
                      child: ListView.builder(
                          itemCount: screens.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  width: currentIndex == index ? 25.0 : 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                )
                              ],
                            );
                          }),
                    ),
                    Text(screens[index].text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 27.0, fontWeight: FontWeight.bold)),
                    Text(screens[index].desc,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () async {
                        if (index == screens.length - 1) {
                          await _storeOnBoardInfo();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Next",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            SizedBox(
                              width: 15.0,
                            ),
                            Icon(
                              Icons.arrow_forward_sharp,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              })),
    );
  }
}
