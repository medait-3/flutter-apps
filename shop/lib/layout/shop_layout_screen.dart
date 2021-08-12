import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/get_cart_model.dart';
import 'package:shop/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:shop/modules/search_screen/search_screen.dart';
import 'package:shop/modules/setting_screen/setting_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';

class ShopLayoutScreen extends StatefulWidget {
  @override
  _ShopLayoutScreenState createState() => _ShopLayoutScreenState();
}

class _ShopLayoutScreenState extends State<ShopLayoutScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isBottomSheetChanged = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getProfile()
        ..getHomeData()
        ..getCategories()
        ..getFavourites()
        ..getCarts(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          // if (state is GetCartSuccessState) {
          //   if (isBottomSheetChanged == true) {
          //     isBottomSheetChanged = false;
          //     Navigator.pop(context);
          //     ShopCubit.get(context).changeBottomSheetShown(false);
          //     ShopCubit.get(context).changeFabIcon(Icons.shopping_cart_sharp);
          //
          //     if (ShopCubit.get(context).isBottomSheetShown == true) {
          //       Navigator.pop(context);
          //       ShopCubit.get(context).changeBottomSheetShown(false);
          //       ShopCubit.get(context).changeFabIcon(Icons.shopping_cart_sharp);
          //     } else {
          //       ShopCubit.get(context).changeBottomSheetShown(true);
          //       ShopCubit.get(context).changeFabIcon(Icons.check);
          //       if (ShopCubit.get(context).bottomNavBarCurrentIndex == 0 ||
          //           ShopCubit.get(context).bottomNavBarCurrentIndex == 1 ||
          //           ShopCubit.get(context).bottomNavBarCurrentIndex == 2) {
          //         scaffoldKey.currentState!
          //             .showBottomSheet(
          //               (context) => bottomSheetArea(context),
          //             )
          //             .closed
          //             .then((value) {
          //           ShopCubit.get(context).changeBottomSheetShown(false);
          //           ShopCubit.get(context)
          //               .changeFabIcon(Icons.shopping_cart_sharp);
          //         });
          //       }
          //     }
          //   }
          // }
        },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);

          //////////////////////////////////
          late Widget showFloatingButtonIf;
          if (cubit.bottomNavBarCurrentIndex == 0 ||
              cubit.bottomNavBarCurrentIndex == 1 ||
              cubit.bottomNavBarCurrentIndex == 2) {
            showFloatingButtonIf = FloatingActionButton(
              elevation: 10,
              heroTag: 'fl1',
              onPressed: () {
                if (cubit.isBottomSheetShown == true) {
                  Navigator.pop(context);
                  cubit.changeBottomSheetShown(false);
                  cubit.changeFabIcon(Icons.shopping_cart_sharp);
                } else {
                  cubit.changeBottomSheetShown(true);
                  cubit.changeFabIcon(Icons.check);
                  if (cubit.bottomNavBarCurrentIndex == 0 ||
                      cubit.bottomNavBarCurrentIndex == 1 ||
                      cubit.bottomNavBarCurrentIndex == 2) {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => bottomSheetArea(context),
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetShown(false);
                      cubit.changeFabIcon(Icons.shopping_cart_sharp);
                    });
                  }
                }
              },
              backgroundColor: Colors.indigo[400],
              child: Icon(
                cubit.fabIcon,
                color: Colors.white,
              ),
            );
          } else {
            showFloatingButtonIf = Container();
          }
//////////////////////////////////////////////

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.indigo,
            drawer: Drawer(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  if (cubit.userProfile != null)
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.indigo),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  '${cubit.userProfile!.data!.image}',
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${cubit.userProfile!.data!.name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${cubit.userProfile!.data!.email}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        navigateTo(
                                            context, EditProfileScreen());
                                      },
                                      icon: Icon(Icons.edit))),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Credit: ${cubit.userProfile!.data!.credit}',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Points: ${cubit.userProfile!.data!.points}',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.home),
                  ),
                  ListTile(
                    title: Text(
                      'Setting',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      //Navigator.pop(context);
                      navigateTo(context, SettingScreen());
                    },
                    leading: Icon(Icons.settings),
                  ),
                  Container(
                    height: 280,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          logOut(context);
                        },
                        child: Icon(Icons.logout),
                      ),
                      SizedBox(width: 30),
                    ],
                  )
                ],
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.indigo,
                  statusBarIconBrightness: Brightness.light),
              elevation: 0,
              backgroundColor: Colors.indigo,
              backwardsCompatibility: false,
              actions: [
                IconButton(
                    onPressed: () {
                      print('search');
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
              ],
              title: Text(
                'MATGAR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              titleSpacing: 3,
            ),
            body: cubit.homeModel != null ||
                    cubit.catModel != null ||
                    cubit.getFavModel != null ||
                    cubit.userProfile != null
                ? cubit.chooseBotNavBarScreen(cubit.bottomNavBarCurrentIndex)
                : Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottomNavBarCurrentIndex(index);
              },
              currentIndex: cubit.bottomNavBarCurrentIndex,
              selectedItemColor: Colors.indigo,
              unselectedItemColor: Colors.black38,
              showSelectedLabels: false,
              backgroundColor: Colors.white,
              showUnselectedLabels: false,
              elevation: 0,
              iconSize: 25,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
              ],
            ),
            floatingActionButton: showFloatingButtonIf,
          );
        },
      ),
    );
  }

  Widget itemBuilder(GetCartsModel? model, index, context) {
    return Dismissible(
      key: Key(model!.data!.cartItems[index]!.product!.id.toString()),
      onDismissed: (direction) {
        ShopCubit.get(context)
            .changeCarts(id: model.data!.cartItems[index]!.product!.id);
        // setState(() {
        //   isBottomSheetChanged = true;
        // });
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: Row(
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  '${model.data!.cartItems[index]!.product!.image}',
                ),
              ),

              //fit: BoxFit.cover,
            ]),
            SizedBox(
              width: 9,
            ),
            Expanded(
              child: Text(
                '${model.data!.cartItems[index]!.product!.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white70),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${model.data!.cartItems[index]!.product!.price.toString()} LE',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 1,
                ),
                model.data!.cartItems[index]!.product!.discount > 0
                    ? Text(
                        '${model.data!.cartItems[index]!.product!.oldPrice.toString()} LE',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheetArea(context) => Container(
        decoration: BoxDecoration(
          color: Colors.indigo[300],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
        ),
        height: 410,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                // if (ShopCubit.get(context).getCartModel!.data!.total !=0)
                  false?Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'TOTAL',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${ShopCubit.get(context).getCartModel!.data!.total} LE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ):Container(),
                SizedBox(
                  height: 20,
                ),
                if (ShopCubit.get(context).getCartModel!.data!.cartItems.length > 0)
                  ShopCubit.get(context).getCartModel != null
                      ? ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => itemBuilder(
                              ShopCubit.get(context).getCartModel,
                              index,
                              context),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: ShopCubit.get(context).getCartModel!.data!.cartItems.length)
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.white70,
                          ),
                        ),
                if (ShopCubit.get(context).isCartCounter == 0)
                  Text(
                    'No items',
                    style: TextStyle(color: Colors.white),
                  ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
}
