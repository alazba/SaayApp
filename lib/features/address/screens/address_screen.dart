import 'package:enjaz_user/common/enums/footer_type_enum.dart';
import 'package:enjaz_user/common/models/address_model.dart';
import 'package:enjaz_user/common/widgets/custom_loader_widget.dart';
import 'package:enjaz_user/features/address/widgets/address_add_button_widget.dart';
import 'package:enjaz_user/features/address/widgets/address_widget.dart';
import 'package:enjaz_user/helper/responsive_helper.dart';
import 'package:enjaz_user/localization/language_constrants.dart';
import 'package:enjaz_user/features/auth/providers/auth_provider.dart';
import 'package:enjaz_user/features/address/providers/address_provider.dart';
import 'package:enjaz_user/utill/dimensions.dart';
import 'package:enjaz_user/utill/routes.dart';
import 'package:enjaz_user/common/widgets/custom_app_bar_widget.dart';
import 'package:enjaz_user/common/widgets/custom_web_title_widget.dart';
import 'package:enjaz_user/common/widgets/footer_web_widget.dart';
import 'package:enjaz_user/common/widgets/no_data_screen.dart';
import 'package:enjaz_user/common/widgets/not_logged_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<AddressProvider>(context, listen: false).initAddressList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBarWidget(title: getTranslated('address', context)),
      floatingActionButton: _isLoggedIn
          ? Padding(
              padding: EdgeInsets.only(
                  top: ResponsiveHelper.isDesktop(context)
                      ? Dimensions.paddingSizeLarge
                      : 0),
              child: !ResponsiveHelper.isDesktop(context)
                  ? FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.getAddAddressRoute(
                              'address', 'add', AddressModel())),
                      child: const Icon(Icons.add, color: Colors.white),
                    )
                  : null,
            )
          : null,
      body: _isLoggedIn
          ? Consumer<AddressProvider>(
              builder: (context, locationProvider, child) {
                return locationProvider.addressList != null
                    ? locationProvider.addressList!.isNotEmpty
                        ? RefreshIndicator(
                            color: Theme.of(context).secondaryHeaderColor,
                            onRefresh: () async {
                              await Provider.of<AddressProvider>(context,
                                      listen: false)
                                  .initAddressList();
                            },
                            backgroundColor:
                                Theme.of(context).secondaryHeaderColor,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomWebTitleWidget(
                                      title: getTranslated('address', context)),
                                  Center(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minHeight:
                                              !ResponsiveHelper.isDesktop(
                                                          context) &&
                                                      height < 600
                                                  ? height
                                                  : height - 400),
                                      child: SizedBox(
                                        width: Dimensions.webScreenWidth,
                                        child: ResponsiveHelper.isDesktop(
                                                context)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  AddressAddButtonWidget(
                                                      onTap: () => Navigator.pushNamed(
                                                          context,
                                                          Routes.getAddAddressRoute(
                                                              'address',
                                                              'add',
                                                              AddressModel()))),
                                                  GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            crossAxisSpacing:
                                                                Dimensions
                                                                    .paddingSizeDefault,
                                                            childAspectRatio:
                                                                4),
                                                    padding: const EdgeInsets
                                                        .all(Dimensions
                                                            .paddingSizeSmall),
                                                    itemCount: locationProvider
                                                        .addressList!.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            AddressWidget(
                                                      addressModel:
                                                          locationProvider
                                                                  .addressList![
                                                              index],
                                                      index: index,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: const EdgeInsets.all(
                                                    Dimensions
                                                        .paddingSizeSmall),
                                                itemCount: locationProvider
                                                    .addressList!.length,
                                                itemBuilder: (context, index) =>
                                                    AddressWidget(
                                                  addressModel: locationProvider
                                                      .addressList![index],
                                                  index: index,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  const FooterWebWidget(
                                      footerType: FooterType.nonSliver),
                                ],
                              ),
                            ),
                          )
                        : ResponsiveHelper.isDesktop(context)
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        constraints: BoxConstraints(
                                            minHeight:
                                                !ResponsiveHelper.isDesktop(
                                                            context) &&
                                                        height < 600
                                                    ? height
                                                    : height - 400),
                                        width: Dimensions.webScreenWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (ResponsiveHelper.isDesktop(
                                                context))
                                              AddressAddButtonWidget(
                                                  onTap: () => Navigator.pushNamed(
                                                      context,
                                                      Routes.getAddAddressRoute(
                                                          'address',
                                                          'add',
                                                          AddressModel()))),
                                            const NoDataScreen(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const FooterWebWidget(
                                        footerType: FooterType.nonSliver),
                                  ],
                                ),
                              )
                            : const NoDataScreen(showFooter: false)
                    : Center(
                        child: CustomLoaderWidget(
                            color: Theme.of(context).primaryColor));
              },
            )
          : const NotLoggedInScreen(),
    );
  }
}
