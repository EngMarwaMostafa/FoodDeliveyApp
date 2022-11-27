import 'package:fooddeliveryapp/data/api/api_client.dart';
import 'package:fooddeliveryapp/data/repository/user_repo.dart';
import 'package:fooddeliveryapp/models/user_model.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo{
  final ApiClient apiClient;
    UserRepo({required this.apiClient});

  Future<Response> getUserInfo()async{
   return await apiClient.getData(AppConstants.USER_INFO_URI);
    }
}
