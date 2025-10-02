import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import 'package:str_customer_app/widgets/Location/location_background.dart';
import '../../blocs/location_access/location_bloc.dart';
import '../../blocs/location_access/location_event.dart';
import '../../blocs/location_access/location_state.dart';
import '../../nav/routes.dart';
import '../../utils/app_colors.dart';
import '../../widgets/Auth/auth_header.dart';
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
            if (state.shouldNavigate) {
              context.go(AppRoutes.home);
            }

            if (state.isPermissionDenied && state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  action: SnackBarAction(
                    label: 'Settings',
                    onPressed: () => openAppSettings(),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      const AuthHeader(
                        title: "— Location Access —",
                        subtitle: "Find the Best Meals\nNearby!",
                        description:
                            "Enable location to discover tasty options around you",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "",
                          style: AppStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LocationButton(
                        isGranted:
                            state.justGrantedNow ||
                            (state.isSuccess && !state.shouldNavigate),
                        onPressed: () {
                          context.read<LocationBloc>().add(
                            EnableLocationRequested(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SkipButton(
                        onPressed: () => context.read<LocationBloc>().add(
                          SkipLocationRequested(),
                        ),
                      ),
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
