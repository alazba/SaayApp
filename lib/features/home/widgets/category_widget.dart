import 'package:enjaz_user/common/widgets/title_widget.dart';
import 'package:enjaz_user/features/category/providers/category_provider.dart';
import 'package:enjaz_user/features/home/widgets/categories_web_widget.dart';
import 'package:enjaz_user/features/home/widgets/category_shimmer_widget.dart';
import 'package:enjaz_user/helper/responsive_helper.dart';
import 'package:enjaz_user/localization/language_constrants.dart';
import 'package:enjaz_user/utill/dimensions.dart';
import 'package:enjaz_user/utill/images.dart';
import 'package:enjaz_user/utill/routes.dart';
import 'package:enjaz_user/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return (category.categoryList == null ||
                (category.categoryList != null &&
                    category.categoryList!.isNotEmpty))
            ? Column(
                children: [
                  ResponsiveHelper.isDesktop(context)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: Dimensions.paddingSizeExtraLarge,
                              bottom: Dimensions.paddingSizeLarge),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                getTranslated('all_categories', context),
                                style: rubikMedium.copyWith(
                                    fontSize: Dimensions.fontSizeOverLarge)),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: TitleWidget(
                            title: getTranslated('all_categories', context),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.getCategoryAllRoute());
                            },
                          ),
                        ),
                  ResponsiveHelper.isDesktop(context)
                      ? const CategoriesWebWidget()
                      : Row(children: [
                          Expanded(
                            child: SizedBox(
                              height: 90,
                              child: category.categoryList != null
                                  ? category.categoryList!.isNotEmpty
                                      ? ListView.builder(
                                          itemCount:
                                              category.categoryList!.length,
                                          padding: const EdgeInsets.only(
                                              left:
                                                  Dimensions.paddingSizeSmall),
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: Dimensions
                                                      .paddingSizeSmall),
                                              child: InkWell(
                                                onTap: () =>
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routes.getCategoryRoute(
                                                          category.categoryList![
                                                              index],
                                                        )),
                                                child: Column(children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    // decoration: BoxDecoration(
                                                    //     borderRadius:
                                                    //         const BorderRadius
                                                    //             .all(
                                                    //             Radius.circular(
                                                    //                 10)),
                                                    //     border: Border.all(
                                                    //         width: .5,
                                                    //         color: Theme.of(
                                                    //                 context)
                                                    //             .dividerColor)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  3)),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                            Images.placeholder(
                                                                context),
                                                        image:
                                                            '${category.categoryList![index].image}',
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                        imageErrorBuilder:
                                                            (c, o, t) =>
                                                                Image.asset(
                                                          Images.placeholder(
                                                              context),
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 70,
                                                    child: Center(
                                                      child: Text(
                                                        category
                                                            .categoryList![
                                                                index]
                                                            .name!,
                                                        style: rubikMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeExtraSmall),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text(getTranslated(
                                              'no_category_available',
                                              context)))
                                  : const CategoryShimmerWidget(),
                            ),
                          ),
                        ]),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
