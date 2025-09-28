import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import '../../blocs/home/home_bloc.dart';
import '../../blocs/home/home_state.dart';
import '../../widgets/Home/banner_section.dart';
import '../../widgets/Home/custom_app_bar.dart';
import '../../widgets/Home/custom_bottom_bar.dart';
import '../../widgets/Home/frequent_orders_section.dart';
import '../../widgets/Home/restaurant_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fabController;
  late AnimationController _bottomBarController;
  late Animation<double> _fabAnimation;
  late Animation<double> _bottomBarAnimation;
  int _currentIndex = 0;
  bool _showFullBars = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bottomBarController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
    _bottomBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bottomBarController, curve: Curves.easeInOut),
    );
    _scrollController.addListener(_onScroll);
    _bottomBarController.forward();
  }

  void _onScroll() {
    final offset = _scrollController.offset;

    if (offset > 55 && _showFullBars) {
      setState(() => _showFullBars = false);
      _fabController.forward();
      _bottomBarController.reverse();
    } else if (offset <= 55 && !_showFullBars) {
      setState(() => _showFullBars = true);
      _fabController.reverse();
      _bottomBarController.forward();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabController.dispose();
    _bottomBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (state is HomeLoaded) {
            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    CustomAppBar(
                      showOnlySearch: !_showFullBars,
                      location: state.currentLocation,
                    ),
                    BannerSection(banners: state.banners),
                    FrequentOrdersSection(orders: state.frequentOrders),
                    RestaurantSection(restaurants: state.restaurants),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),

                if (!_showFullBars)
                  AnimatedBuilder(
                    animation: _fabAnimation,
                    builder: (context, child) {
                      return Positioned(
                        bottom: MediaQuery.of(context).padding.bottom + 20,
                        left: MediaQuery.of(context).size.width / 2 - 28,
                        child: Transform.scale(
                          scale: _fabAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.lightWhite,
                                width: 4.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: FloatingActionButton(
                              heroTag: "shopping_cart",
                              onPressed: () {
                                setState(() => _currentIndex = 1);
                              },
                              backgroundColor: AppColors.primaryOrange,
                              elevation: 0,
                              shape: const CircleBorder(),
                              child: Image.asset(
                                "assets/images/cart_icon_black.png",
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          }
          return Container();
        },
      ),

      floatingActionButton: _showFullBars
          ? AnimatedBuilder(
              animation: _bottomBarAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _bottomBarAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.lightWhite,
                        width: 4.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      heroTag: "shopping_cart",
                      onPressed: () {
                        setState(() => _currentIndex = 1);
                      },
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: const CircleBorder(),
                      child: Image.asset(
                        "assets/images/cart_icon_grey.png",
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                );
              },
            )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _showFullBars
          ? AnimatedBuilder(
              animation: _bottomBarAnimation,
              builder: (context, child) {
                return Material(
                  color: Colors.transparent,
                  child: CustomBottomBar(
                    currentIndex: _currentIndex,
                    onTap: (index) => setState(() => _currentIndex = index),
                    animation: _bottomBarAnimation.value,
                  ),
                );
              },
            )
          : null,
    );
  }
}
