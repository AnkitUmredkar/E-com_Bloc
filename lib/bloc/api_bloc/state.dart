abstract class ApiState{}

class LoadingApi extends ApiState{}

class LoadedApi extends ApiState{
  List usersData = [];
  late String errorMsg;

  LoadedApi(this.usersData,this.errorMsg);
}