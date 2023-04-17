import 'package:flutter/material.dart';
import 'package:flutter_pertemuan_6/api_data_source.dart';
import 'users_detail_model.dart';

class PageDetalListUsers extends StatelessWidget {
  final int idUsers;

  const PageDetalListUsers({Key? key, required this.idUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail User"),
        ),
        body: _builListUsersBody(idUsers));
  }
}

Widget _builListUsersBody(id) {
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.LoadDetailUsers(id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }

        if (snapshot.hasData) {
          UsersDetailModel usersModel =
              UsersDetailModel.fromJson(snapshot.data);
          return _buildSuccesSection(usersModel);
        }

        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildSuccesSection(UsersDetailModel user) {
  return ListView.builder(
    itemCount: user.data!.length,
    itemBuilder: (context, index) {
      return _buildItemsUsers(user.data![index], context);
    },
  );
}

Widget _buildErrorSection() {
  return Text("ERROR");
}

Widget _buildLoadingSection() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
