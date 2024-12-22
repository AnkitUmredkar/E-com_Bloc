import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_com_bloc/bloc/api_bloc/event.dart';
import 'package:e_com_bloc/bloc/api_bloc/state.dart';
import 'package:flutter/cupertino.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(LoadingApi()) {
    on<CallApi>(
      (event, emit) async {
        try {
          emit(LoadingApi());
          Dio dio = Dio();
          Response response =
              await dio.get("https://jsonplaceholder.typicode.com/posts");
          if (response.statusCode == 200) {
            final data = response.data;
            emit(LoadedApi(data,"No"));
          } else {
            log(response.statusCode.toString());
            emit(LoadedApi([], "Status code -> ${response.statusCode.toString()}"));
          }
        } catch (error) {
          log("Error in bloc -> ${error.toString()}");
        }
      },
    );
  }
}
