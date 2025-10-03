import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import 'package:str_customer_app/utils/app_styles.dart';

class CustomSmallAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CustomSmallAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: AppBar(
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: onBackPressed,
            borderRadius: BorderRadius.circular(60),
            splashColor: Colors.black.withValues(alpha: 0.3),
            highlightColor: Colors.black.withValues(alpha: 0.2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textBlack,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primaryOrange,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(title, style: AppStyles.appbarText),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/top_bar_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
