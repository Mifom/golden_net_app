import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';

class TwoPageSlider extends StatefulWidget {
  final Widget Function(
      BuildContext context,
      Function(
              {@required
                  Widget Function(BuildContext context, VoidCallback goBack)
                      builder,
              @required
                  SharedAxisTransitionType transitionType})
          goForward) builder;

  const TwoPageSlider({Key key, @required this.builder}) : super(key: key);

  @override
  _TwoPageSliderState createState() => _TwoPageSliderState();
}

class _TwoPageSliderState extends State<TwoPageSlider> {
  Widget secondSlide;

  SharedAxisTransitionType transitionType = SharedAxisTransitionType.horizontal;

  bool get isShowFirst => secondSlide == null;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: isShowFirst,
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
        );
      },
      child: isShowFirst
          ? widget.builder(context, ({builder, transitionType}) {
              setState(() {
                this.transitionType = transitionType;
                secondSlide =
                    builder(context, () async {
                      await Future.delayed(Duration(milliseconds: 80));
                      setState(() => secondSlide = null);
                    });
              });
            })
          : secondSlide,
    );
  }
}
