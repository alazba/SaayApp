import 'package:enjaz_user/common/widgets/cart_count_widget.dart';
import 'package:enjaz_user/common/widgets/custom_asset_image_widget.dart';
import 'package:enjaz_user/features/cart/providers/cart_provider.dart';
import 'package:enjaz_user/features/splash/providers/splash_provider.dart';
import 'package:enjaz_user/helper/cart_helper.dart';
import 'package:enjaz_user/helper/responsive_helper.dart';
import 'package:enjaz_user/utill/app_constants.dart';
import 'package:enjaz_user/utill/dimensions.dart';
import 'package:enjaz_user/utill/images.dart';
import 'package:enjaz_user/utill/routes.dart';
import 'package:enjaz_user/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    Key? key,
    required this.drawerGlobalKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> drawerGlobalKey;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).cardColor,
      pinned: ResponsiveHelper.isTab(context) ? true : false,
      leading: ResponsiveHelper.isTab(context)
          ? IconButton(
              onPressed: () => drawerGlobalKey.currentState!.openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.black),
            )
          : null,
      title: Consumer<SplashProvider>(
          builder: (context, splash, child) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAssetImageWidget(Images.logo,
                      width: 110, height: 30),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      AppConstants.appName,
                      style: rubikBold.copyWith(
                          color: Theme.of(context).primaryColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          hoverColor: Colors.transparent,
          onTap: () => Navigator.pushNamed(context, Routes.getCouponRoute()),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(Images.coupon, height: 16, width: 16),
            ),
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, Routes.getNotificationRoute()),
          icon: const Icon(Icons.notifications,
              color: Color.fromARGB(255, 180, 178, 178), size: 20),
        ),
        if (ResponsiveHelper.isTab(context))
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, Routes.getDashboardRoute('cart')),
            icon: Consumer<CartProvider>(
                builder: (context, cartProvider, _) => CartCountWidget(
                      count: CartHelper.getCartItemCount(cartProvider.cartList),
                      icon: Icons.shopping_cart,
                    )),
          ),
      ],
    );
  }
}
