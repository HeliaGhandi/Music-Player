import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Import for SchedulerBinding

//GEMENI :
class AnimatedBackgroundWidget extends StatefulWidget {
  AnimatedBackgroundWidget({required this.activeBackground, super.key});
  String activeBackground;

  @override
  State<AnimatedBackgroundWidget> createState() =>
      _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;

  // The actual width of a single instance of the image after being scaled to screen height.
  double _singleImageScaledWidth = 0.0;
  final double _imageAspectRatio = 10800 / 4800; // Your image's width / height

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 40,
      ), // Adjust duration for speed. A slower speed makes the loop more obvious.
    );

    // This listener is where the magic happens for the seamless loop.
    _animationController.addListener(() {
      if (!_scrollController.hasClients || _singleImageScaledWidth == 0.0) {
        return;
      }

      // Calculate the current position based on the animation value.
      // We want to scroll past one full image width to enable the seamless jump.
      double targetScrollPosition =
          _animationController.value * _singleImageScaledWidth;

      // If we are at or near the end of the first image's "scrollable" range,
      // and we have scrolled past it, jump back to the beginning of the second image.
      // This creates the illusion of infinite scrolling.
      // The _scrollController.position.pixels check ensures we don't jump too early
      // and that the current position is indeed past the first image.
      if (_scrollController.position.pixels >= _singleImageScaledWidth &&
          _animationController.value == 1.0) {
        // Jump back to the start of the second image.
        // We're resetting the underlying scroll position, but because the first
        // image has completely scrolled off, it appears seamless.
        _scrollController.jumpTo(0);
        // We also need to reset the animation controller to restart from the beginning,
        // but without triggering the jump in the next frame.
        _animationController.value = 0; // Reset animation progress
        _animationController.forward(); // Start animation again
      } else {
        // Otherwise, just move the scroll position smoothly.
        _scrollController.jumpTo(targetScrollPosition);
      }
    });

    // Use SchedulerBinding to ensure layout is complete before calculating image width.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      // Calculate the actual width of one image instance when scaled to screen height.
      _singleImageScaledWidth = screenHeight * _imageAspectRatio;

      // Once the width is calculated, start the animation.
      _animationController.repeat();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics:
            const NeverScrollableScrollPhysics(), // Disable manual scrolling
        child: Row(
          children: <Widget>[
            // We need at least two copies of the image to make the loop seamless.
            // As the first image scrolls off, the second one becomes visible.
            // When the first image is fully off-screen, we jump the scroll position
            // back to the start of the *first* image, which is now out of view.
            // Because the second image is now in the first image's position, it's seamless.
            Image.asset(
              widget.activeBackground, // Ensure this path is correct
              fit:
                  BoxFit.fitHeight, // Fit the image height to the screen height
              height: MediaQuery.of(context).size.height,
              // The width of this image will be determined by fitHeight and aspect ratio.
              // We explicitly set a width here for clearer calculation if needed,
              // but BoxFit handles it correctly.
              width:
                  _singleImageScaledWidth == 0.0
                      ? null
                      : _singleImageScaledWidth,
            ),
            Image.asset(
              widget.activeBackground,
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.height,
              width:
                  _singleImageScaledWidth == 0.0
                      ? null
                      : _singleImageScaledWidth,
            ),
            // You might even add a third one if the animation speed is very high
            // or if dealing with very variable screen sizes, to be extra safe.
            // Image.asset(
            //   'assets/loginloopfinalfinal.jpg',
            //   fit: BoxFit.fitHeight,
            //   height: MediaQuery.of(context).size.height,
            //   width: _singleImageScaledWidth == 0.0 ? null : _singleImageScaledWidth,
            // ),
          ],
        ),
      ),
    );
  }
}
