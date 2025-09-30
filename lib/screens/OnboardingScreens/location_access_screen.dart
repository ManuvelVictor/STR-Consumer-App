import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import 'package:str_customer_app/widgets/Location/location_background.dart';
import '../../blocs/location_access/location_bloc.dart';
import '../../blocs/location_access/location_event.dart';
import '../../blocs/location_access/location_state.dart';
import '../../nav/routes.dart';
import '../../utils/app_colors.dart';
import '../../widgets/Location/location_button.dart';
import '../../widgets/Location/skip_button.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LocationBloc()..add(CheckLocationPermission()),
        child: BlocConsumer<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.go(AppRoutes.home);
            }
            if (state.isPermissionDenied && state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  action: SnackBarAction(
                    label: 'Settings',
                    onPressed: () {
                      // TODO: Open app settings
                      // import 'package:app_settings/app_settings.dart';
                      // AppSettings.openAppSettings();
                    },
                  ),
                ),
              );
            }
            if (state.isFailure && state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return LocationBackground(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "— Location Access —",
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Find the Best Meals\nNearby!",
                        style: AppStyles.headlineLarge.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Enable location access to discover tasty options around you",
                          style: AppStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      LocationButton(
                        isLoading: state.isLoading,
                        onPressed: () => context.read<LocationBloc>().add(
                          EnableLocationRequested(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SkipButton(
                        onPressed: () => context.read<LocationBloc>().add(
                          SkipLocationRequested(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
