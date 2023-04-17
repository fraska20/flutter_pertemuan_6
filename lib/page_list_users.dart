import 'package:flutter/material.dart';
import 'package:flutter_pertemuan_6/api_data_source.dart';
import 'package:flutter_pertemuan_6/page_detail_list_users.dart';
import 'package:flutter_pertemuan_6/users_model.dart';

class PageListUsers extends StatelessWidget {
  const PageListUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List dari user"),
      ),
      body: _builListUsersBody(),
    );
  }
}

Widget _builListUsersBody() {
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.LoadUsers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }

        if (snapshot.hasData) {
          UsersModel usersModel = UsersModel.fromJson(snapshot.data);
          return _buildSuccesSection(usersModel);
        }

        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildSuccesSection(UsersModel user) {
  return ListView.builder(
    itemCount: user.data!.length,
    itemBuilder: (context, index) {
      return _buildItemsUsers(user.data![index], context);
    },
  );
}

Widget _buildItemsUsers(Data userData, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PageDetalListUsers(idUsers: userData.id!)),
      );
    },
    child: Card(
      child: Row(
        children: [
          Container(width: 100, child: Image.network(userData.avatar!)),
          SizedBox(
            width: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userData.firstName! + " " + userData.lastName!),
              Text(userData.email!)
            ],
          )
        ],
      ),
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
