import 'package:fooddeliveryapp/controllers/order_controller.dart';
import 'package:fooddeliveryapp/data/repository/order_repo.dart';
import 'package:fooddeliveryapp/models/order_model.dart';
import 'package:fooddeliveryapp/models/place_order_model.dart';
import 'package:get/get.dart';

class OdrerController extends GetxController implements GetxService {
  OrderRepo orderRepo;

  OdrerController({required this.orderRepo});

  bool _isLoading = false;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  bool get isLoading => _isLoading;

  List<OrderModel> get currentOrderList => _currentOrderList;

  List<OrderModel> get historyOrderList => _historyOrderList;

  int _paymentIndex = 0;

  int get paymentIndex => _paymentIndex;

  String _orderType = 'Delivery';

  String get orderType => _orderType;

  String _foodNote = '';

  String get foodNote => _foodNote;

  Future<void> placeOrder(
      PlaceOrderBody placeOrderBody, Function callBack) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrderBody);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callBack(true, message, orderID);
    } else {
      callBack(false, response.statusText, '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up') {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;
    print('the length of the order' + _currentOrderList.length.toString());
    update();
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _orderType = type;
    update();
  }

  void setFoodNote(String note){
    _foodNote=note;

  }
}
