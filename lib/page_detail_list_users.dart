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
        body: _builListDetailUsersBody(idUsers));
  }
}

Widget _builListDetailUsersBody(id) {
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.LoadDetailUsers(id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }

        if (snapshot.hasData) {
          UsersDetailModel usersDetailModel =
              UsersDetailModel.fromJson(snapshot.data);
          return _buildSuccesSection(usersDetailModel);
        }

        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildSuccesSection(UsersDetailModel user) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.data!.avatar!),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          user.data!.firstName! + " " + user.data!.lastName!,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          user.data!.email!,
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
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
