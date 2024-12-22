import 'package:e_com_bloc/bloc/api_bloc/bloc.dart';
import 'package:e_com_bloc/bloc/api_bloc/event.dart';
import 'package:e_com_bloc/bloc/api_bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiPractice extends StatelessWidget {
  const ApiPractice({super.key});

  @override
  Widget build(BuildContext context) {
    ApiBloc apiBloc = BlocProvider.of<ApiBloc>(context);
    apiBloc.add(CallApi());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Calling Using Bloc"),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is LoadedApi && state.usersData.isEmpty) {
            return Center(
              child: Text("Error in home page -> ${state.errorMsg}"),
            );
          } else if (state is LoadedApi && state.usersData.isNotEmpty) {
            return ListView.builder(
              itemCount: state.usersData.length,
              itemBuilder: (context, index) {
                final data = state.usersData[index];
                return ListTile(
                  title: Text(data["title"]),
                  subtitle: Text(data["body"]),
                  leading: Text(data["id"].toString()),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
