 import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget{
  final String images;
  final String title;
  final String description;

  const SliderPage({Key? key, required this.images, required this.title, required this.description}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> with TickerProviderStateMixin{

  late final AnimationController _animationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this
  )..repeat(reverse: true);

  late final Animation<double> _animation = Tween<double>(
      begin: 1.0,
      end: 1.5
  ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear
  ));

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/images/welcome1.jpg'), context);
    precacheImage(const AssetImage('assets/images/welcome2.jpg'), context);
    precacheImage(const AssetImage('assets/images/welcome3.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScaleTransition(
          scale: _animation,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.images),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.multiply)
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  runSpacing: 10,
                  children: [
                    Text(widget.title ,textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1),
                    Text(widget.description, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}