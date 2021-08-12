import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:shop/modules/setting_screen/setting_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';

class ProductScreen extends StatelessWidget {
  final int index;
  const ProductScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ChangeFavSuccessState) {
            if (state.model.status == false) {
              showToast(
                state: ToastState.ERROR,
                msg: state.model.message,
              );
            }
          }

          if (state is ChangeFavErrorState) {
            showToast(
              state: ToastState.ERROR,
              msg: "No Internet Connection",
            );
          }
        },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);

          return Scaffold(
              backgroundColor: Colors.indigo,

              // endDrawer: Drawer(
              //   child: ListView(
              //     physics: BouncingScrollPhysics(),
              //     children: [
              //       if (cubit.userProfile != null)
              //         DrawerHeader(
              //           decoration: BoxDecoration(color: Colors.indigo),
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               CircleAvatar(
              //                 radius: 40,
              //                 backgroundImage: NetworkImage(
              //                   '${cubit.userProfile!.data!.image}',
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 15,
              //               ),
              //               Expanded(
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       '${cubit.userProfile!.data!.name}',
              //                       maxLines: 2,
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                           fontSize: 17,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w600),
              //                     ),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                     Text(
              //                       '${cubit.userProfile!.data!.email}',
              //                       maxLines: 1,
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                           fontSize: 10, color: Colors.white),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               CircleAvatar(
              //                   child: IconButton(
              //                       onPressed: () {
              //                         navigateTo(context, EditProfileScreen());
              //                       },
              //                       icon: Icon(Icons.edit))),
              //             ],
              //           ),
              //         ),
              //       ListTile(
              //         title: Text(
              //           'Home',
              //           style: TextStyle(fontSize: 16),
              //         ),
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         leading: Icon(Icons.home),
              //       ),
              //       ListTile(
              //         title: Text(
              //           'Setting',
              //           style: TextStyle(fontSize: 16),
              //         ),
              //         onTap: () {
              //           //Navigator.pop(context);
              //           navigateTo(context, SettingScreen());
              //         },
              //         leading: Icon(Icons.settings),
              //       ),
              //       Container(
              //         height: 280,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           FloatingActionButton(
              //             onPressed: () {
              //               logOut(context);
              //             },
              //             child: Icon(Icons.logout),
              //           ),
              //           SizedBox(width: 30),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              appBar: AppBar(
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.indigo,
                    statusBarIconBrightness: Brightness.light),
                elevation: 0,
                backgroundColor: Colors.indigo,
                backwardsCompatibility: false,
                leading:
                  IconButton(
                      onPressed: () {
                        print('back');
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),

                title: Text(
                  'MATGAR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                titleSpacing: 3,
              ),
              body: cubit.homeModel != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Stack(children: [
                                  Image(
                                    image: NetworkImage(
                                        '${cubit.homeModel!.data!.products[index].image}'),
                                    width: double.infinity,
                                    height: 200,
                                    //fit: BoxFit.cover,
                                  ),
                                  cubit.homeModel!.data!.products[index]
                                              .discount >
                                          0
                                      ? Container(
                                          color:
                                              Colors.redAccent.withOpacity(0.8),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                            ),
                                            child: Text(
                                              'DISCOUNT',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ]),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  '${cubit.homeModel!.data!.products[index].name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${cubit.homeModel!.data!.products[index].price.toString()} LE',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        cubit.homeModel!.data!.products[index]
                                                    .discount >
                                                0
                                            ? Text(
                                                '${cubit.homeModel!.data!.products[index].oldPrice.toString()} LE',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     ShopCubit.get(context).changeFavourites(
                                    //         id: cubit.homeModel!.data!
                                    //             .products[index].id);
                                    //   },
                                    //   icon: ShopCubit.get(context).favourites[
                                    //               cubit.homeModel!.data!
                                    //                   .products[index].id] ==
                                    //           true
                                    //       ? CircleAvatar(
                                    //           backgroundColor: Colors
                                    //               .indigoAccent
                                    //               .withOpacity(0.8),
                                    //           radius: 13,
                                    //           child: Icon(
                                    //             Icons.favorite_outline,
                                    //             size: 18,
                                    //             color: Colors.white,
                                    //           ),
                                    //         )
                                    //       : CircleAvatar(
                                    //           backgroundColor:
                                    //               Colors.grey.withOpacity(0.8),
                                    //           radius: 13,
                                    //           child: Icon(
                                    //             Icons.favorite_outline,
                                    //             size: 18,
                                    //             color: Colors.white,
                                    //           ),
                                    //         ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                    '${cubit.homeModel!.data!.products[index].description}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    )));
        },
      ),
    );
  }
}
