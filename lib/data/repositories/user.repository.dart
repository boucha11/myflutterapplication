import 'package:projetflutter/data/datasource/localdatasource/user_local_data_source.dart';
import 'package:projetflutter/data/datasource/models/user.model.dart';

class UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepository({required this.localDataSource});

  Future<bool> authenticate(String username, String password) async {
    final user = await localDataSource.getUser(username, password);
    return user != null;
  }

  Future<Map> registerUser(String username, String password) async {
    final user = await localDataSource.insertUser(
      User(id: 0, username: username, password: password),
    );
    return user;
  }
}
