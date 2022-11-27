
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/models/order_model.dart';
import 'package:fooddeliveryapp/routes/route_helper.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final   OrderModel orderModel;
  const PaymentPage({Key? key,
    required this.orderModel}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading=true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
 void initState() {
    super.initState();
    selectedUrl='${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}';
  }

  @override
  Widget build(BuildContext context) {
    return
      //WillPopScope(
    //  onWillPop:
      //    ()=>_exitApp(context),
    //  child:
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Payment'),
       /*   leading: IconButton(
         icon: Icon(Icons.arrow_back_ios),
            onPressed: ()=>_exitApp(context),
          ),*/
          backgroundColor: AppColors.mainColor,
       ),
        body: Center(
          child: Container(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                WebView(
             javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: selectedUrl,
                  gestureNavigationEnabled: true,

                 // userAgent: ,
                  onWebViewCreated: (WebViewController webViewController){
                  _controller.future.then((value) => controllerGlobal=value);
                  _controller.complete(webViewController);
                  },
                  onProgress: (int progress){
                  },
                  onPageStarted: (String url){
                   setState(() {
                     _isLoading=true;
                   });
                  },
                  onPageFinished: (String url){
               setState((){
                 _isLoading=false;
               });
               _redirect(url);
                  },
                ),
                _isLoading?Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>
                      (Theme.of(context).primaryColor),),
                ):SizedBox.shrink(),
              ],
            ),
          ),
        ),
     // ),
    );
  }

  void _redirect(String url){
    if(_canRedirect){
      bool _isSuccess=url.contains('success')&&url.contains(AppConstants.BASE_URL);
      bool _isFailed=url.contains('fail')&&url.contains(AppConstants.BASE_URL);
      bool _isCancel=url.contains('cancel')&&url.contains(AppConstants.BASE_URL);
      if(_isSuccess || _isFailed || _isCancel){
        _canRedirect=false;
      }
      if(_isSuccess){
        Get.offNamed(RouteHelper.getOrderSuccessPage(widget.orderModel.id.toString(), 'success'));
      }else if(_isFailed || _isCancel){
        Get.offNamed(RouteHelper.getOrderSuccessPage(widget.orderModel.id.toString(), 'fail'));
      }else{
        print('Encountered Problem');
      }
    }
  }
}
