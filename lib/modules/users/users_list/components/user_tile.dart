import 'package:flutter/material.dart';
import 'package:flutter_api_challenge/data/models/user.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
    );
  }
}
