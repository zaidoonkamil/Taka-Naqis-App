import 'package:flutter/material.dart';

import '../../core/ navigation/navigation.dart';
import '../../core/navigation_bar/navigation_bar.dart';
import '../../core/network/local/cache_helper.dart';
import '../../core/styles/themes.dart';
import '../../core/widgets/constant.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: 'assets/images/Marketplace-bro (1).png',
      title: ' مرحبًا بك في $nameApp',
      description: 'اكتشف تجربة تسوق فريدة مع طكة ناقص واستكشف مجموعتنا الواسعة من المنتجات الممتازة واحصل على أفضل العروض والجودة العالية',
    ),
    OnboardingData(
      image: 'assets/images/Product hunt-bro (1).png',
      title: 'ابحث وتسوق',
      description: 'نقدم لك أفضل المنتجات المختارة بعناية اطلع على التفاصيل والصور لتتأكد من اختيار المنتج المثالية',
    ),
  ];

  void nextPage() {
    if (currentIndex < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      CacheHelper.saveData(key: 'onBoarding',value: true );
      navigateAndFinish(context, BottomNavBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      CacheHelper.saveData(key: 'onBoarding',value: true );
                      navigateAndFinish(context, BottomNavBar());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Text(
                        'تخطي',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = onboardingPages[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        flex: 6,
                        child: Image.asset(data.image),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E1E1E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          data.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingPages.length,
                          (index) => buildDot(index == currentIndex),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: nextPage,
                    backgroundColor: secondPrimaryColor,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }


  Widget buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: isActive ? 34 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? secondPrimaryColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
