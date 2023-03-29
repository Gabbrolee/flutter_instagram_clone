import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;

  const LikeAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 150),
      required this.isAnimating,
      required this.onEnd,
      this.smallLike = false})
      : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMicroseconds ~/ 2));
    scale = Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating != oldWidget.isAnimating){
      startAnimation();
    }
  }

  void startAnimation() async{
   if(widget.isAnimating || widget.smallLike){
     await _animationController.forward();
     await _animationController.reverse();
     await Future.delayed(const Duration(milliseconds: 200));

     if(widget.onEnd != null){
       widget.onEnd!();
     }
   }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: scale,
        child: widget.child,
    );
  }


}
