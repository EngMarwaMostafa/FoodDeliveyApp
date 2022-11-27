import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/base/custom_app_bar.dart';
import 'package:fooddeliveryapp/controllers/auth_controller.dart';
import 'package:fooddeliveryapp/controllers/order_controller.dart';
import 'package:fooddeliveryapp/pages/order/view_order.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
  //  _isLoggedIn = Get.find<AuthController>().userLoggedIn();
   // if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      // Get.find<OdrerController>().getOrderList();
  //  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Orders',),
      body: Column(
        children: [
          Container(
        //    height:500,
            width: Dimensions.screenWidth,
            child: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor:AppColors.yellowColor,
              controller: _tabController,
              tabs: [
                Tab(text: 'Current',),
                Tab(text: 'History',),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller:_tabController,
              children: const [
               ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
