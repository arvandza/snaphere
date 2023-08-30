import 'package:flutter/material.dart';
import 'package:snaphere/pages/loginpage.dart';
import 'package:snaphere/pages/slider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>{
  int _currentPage = 0;
  final PageController _controller = PageController();

  final List<Widget> _pages = [
    const SliderPage(
        images: 'assets/images/welcome1.jpg',
        title: 'SnapHere, something for everyone',
        description: 'Millions of pictures all over the world'
    ),
    const SliderPage(
        images: 'assets/images/welcome2.jpg',
        title: 'Find free images and pictures',
        description: 'Millions of pictures all over the world'
    ),
    const SliderPage(
        images: 'assets/images/welcome3.jpg',
        title: 'SnapHere',
        description: 'Millions of pictures all over the world',
    ),
  ];

  _onChanged(int index){
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: _onChanged,
            itemBuilder: (context, int index){
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 35,
                curve: Curves.easeInOutQuint,
                width: (_currentPage == (_pages.length - 1)) ? 200 : 100,
                child: ElevatedButton(
                  onPressed: (_currentPage == (_pages.length - 1))
                  ? (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Loginpage())
                    );
                  }
                  : (){
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutQuint
                    );
                  },
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent
                    ),
                  ),
                  child: (_currentPage == (_pages.length - 1))
                  ? Text('Get Started', style: Theme.of(context).textTheme.bodyText2)
                  : Text('Next', style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(_pages.length, (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 5,
                    width: (index == _currentPage) ? 20 : 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (index == _currentPage)
                        ? Colors.white
                        : Colors.white.withOpacity(0.5)
                    ),
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
