import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class LocationButton extends StatefulWidget {
  final bool isGranted;
  final VoidCallback onPressed;

  const LocationButton({
    super.key,
    required this.isGranted,
    required this.onPressed,
  });

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _iconPositionAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: 300.0,
      end: 50.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _textAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _iconPositionAnimation = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    if (widget.isGranted) _controller.forward();
  }

  @override
  void didUpdateWidget(LocationButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isGranted && !_controller.isCompleted) {
      _controller.forward();
    } else if (!widget.isGranted && !_controller.isDismissed) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final buttonWidth = _widthAnimation.value;
        final iconSize = 24.0;

        final iconOffset = buttonWidth > 100
            ? 80.0
            : (buttonWidth / 2 - iconSize / 2);

        return GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: buttonWidth,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Icon
                Positioned(
                  left: iconOffset,
                  child: Icon(
                    Icons.location_pin,
                    color: AppColors.textBlack,
                    size: iconSize,
                  ),
                ),

                if (buttonWidth > 100)
                  Positioned(
                    left: iconOffset + 30,
                    child: FadeTransition(
                      opacity: _textAnimation,
                      child: ScaleTransition(
                        scale: _textAnimation,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enable Location",
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}