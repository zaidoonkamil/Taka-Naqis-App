import 'package:dio/dio.dart';
import 'package:taka_naqis/features/agent/cubit/states.dart';
import 'package:taka_naqis/features/agent/model/OrdersAgentModel.dart';
import 'package:taka_naqis/features/user/model/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/network/remote/dio_helper.dart';
import '../../../core/widgets/constant.dart';
import '../../../core/widgets/show_toast.dart';
import '../../user/model/CatModel.dart';
import '../../user/model/GetAdsModel.dart';
import '../../user/model/ProfileModel.dart';


class AgentCubit extends Cubit<AgentStates> {
  AgentCubit() : super(AgentInitialState());
  static AgentCubit get(context) => BlocProvider.of(context);

  void slid(){
    emit(ValidationState());
  }

  bool isLiked = false;

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'صباح الخير';
    } else if (hour < 18) {
      return 'مساء الخير';
    } else {
      return 'مساء الخير';
    }
  }


  List<GetAds> getAdsModel = [];
  void getAds({required BuildContext context,}) {
    emit(GetAdsLoadingState());
    DioHelper.getData(
      url: '/ads',
    ).then((value) {
      getAdsModel = (value.data as List)
          .map((item) => GetAds.fromJson
        (item as Map<String, dynamic>)).toList();
      emit(GetAdsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(), context: context,);
        print(error.toString());
        emit(GetAdsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  ProfileModel? profileModel;
  void getProfile({required BuildContext context,}) {
    emit(GetProfileLoadingState());
    DioHelper.getData(
        url: '/profile',
        token: token
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        print(error.toString());
        emit(GetProfileErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<Product> products = [];
  PaginationProducts? paginationProducts;
  int currentPageProducts = 1;
  bool isLastPageProducts = false;
  ProductsModel? productsModel;
  void getProducts({required BuildContext context,required String page,}) {
    emit(GetProductsLoadingState());
    DioHelper.getData(
      url: '/products/$id?page=$page',
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      products.addAll(productsModel!.products);
      paginationProducts = productsModel!.paginationProducts;
      currentPageProducts = paginationProducts!.currentPage;
      if (currentPageProducts >= paginationProducts!.totalPages) {
        isLastPageProducts = true;
      }
      emit(GetProductsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(), context: context,);
        print(error.toString());
        emit(GetProductsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void deleteProducts({required String idProducts,required BuildContext context}) {
    emit(DeleteProductsLoadingState());

    DioHelper.deleteData(
      url: '/products/$idProducts',
    ).then((value) {
      productsModel!.products.removeWhere((ads) => ads.id.toString() == idProducts);
      showToastSuccess(
        text: 'تم الحذف بنجاح',
        context: context,
      );
      emit(DeleteProductsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),context: context,);
        print(error.toString());
        emit(DeleteProductsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<XFile> selectedImages = [];
  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> resultList = await picker.pickMultiImage();

    if (resultList.isNotEmpty) {
      selectedImages = resultList;
      emit(SelectedImagesState());
    }
  }

  addProducts({required String tittle, required String desc, required String price, required String categoryId, required BuildContext context,})async{
    emit(AddProductsLoadingState());
    if (selectedImages.isEmpty) {
      showToastInfo(text: "الرجاء اختيار صور أولاً!", context: context);
      emit(AddProductsErrorState());
      return;
    }
    FormData formData = FormData.fromMap(
        {
          'title': tittle,
          'description': desc,
          'price': price,
          'userId': '3',
          'categoryId': categoryId,
        },
        ListFormat.multiCompatible
    );

    for (var file in selectedImages) {
      formData.files.add(
        MapEntry(
          "images",
          await MultipartFile.fromFile(
            file.path, filename: file.name,
            contentType: MediaType('image', 'jpeg'),
          ),
        ),
      );
    }

    DioHelper.postData(
      url: '/products',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    ).then((value) {
      emit(AddProductsSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"],
          context: context,
        );
        emit(AddProductsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<CatModel> getCatModel = [];
  void getCat({required BuildContext context,}) {
    emit(GetCatLoadingState());
    DioHelper.getData(
      url: '/categories',
    ).then((value) {
      getCatModel = (value.data as List)
          .map((item) => CatModel.fromJson
        (item as Map<String, dynamic>)).toList();
      emit(GetCatSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(), context: context,);
        print(error.toString());
        emit(GetCatErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<Order> ordersAgent = [];
  PaginationOrdersUser? paginationOrdersAgent;
  int currentPageOrdersAgent = 1;
  bool isLastPageOrdersAgent = false;
  OrdersAgentModel? ordersAgentModel;
  void getOrdersAgent({required BuildContext context,required String page,required String status}) {
    emit(GetOrdersAgentLoadingState());
    DioHelper.getData(
      url: '/agent/orders/status?status=$status&agentId=$id&page=$page',
    ).then((value) {
      ordersAgentModel = OrdersAgentModel.fromJson(value.data);
      ordersAgent.addAll(ordersAgentModel!.orders);
      paginationOrdersAgent = ordersAgentModel!.paginationOrdersUser;
      currentPageOrdersAgent = paginationOrdersAgent!.currentPage;
      if (currentPageOrdersAgent >= paginationOrdersAgent!.totalPages) {
        isLastPageOrdersAgent = true;
      }
      emit(GetOrdersAgentSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(), context: context,);
        print(error.toString());
        emit(GetOrdersAgentErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  void updateOrder({required BuildContext context, required String id, required String status,}) {
    emit(UpdateOrderLoadingState());
    DioHelper.patchData(
        url: '/orders/$id/status',
        token: token,
        data: {
          'status':status
        }
    ).then((value) {
      ordersAgentModel!.orders.removeWhere((p) => p.id.toString() == id);
      emit(UpdateOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(), context: context);
        print(error.toString());
        emit(UpdateOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

}