import 'dart:async';

import 'package:mysql1/mysql1.dart';

void main() async {
  connectDB();
}

Future connectDB() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: '143.198.198.227',
    port: 3306,
    user: 'phradabos_user',
    password: 'Admin1234-',
    db: 'dbphradabos',
  ));

  // await conn.query(
  //     'INSERT INTO users (first_name, last_name, email, password, user_year, date_added) '
  //     'VALUES (?, ?, ?, ?, ?, ?, ?)',
  //     ['John', 'Doe', 'asdasd', '123456', '1', 2, 1234567890]);

  var results = await conn.query('SELECT * FROM users');
  for (var row in results) {
    print('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  }

  await conn.close();

  return results;
}

Future insertData(
  String firstname,
  String lastname,
  String year,
  String email,
  String password,
) async {
  var timestamp = DateTime.now().millisecondsSinceEpoch;

  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: '127.0.0.1',
    port: 3306,
    user: 'root',
    password: null,
    db: 'dbphradabos',
  ));
  try {
    final result = await conn.query(
        'INSERT INTO users (first_name, lastname, email, password, user_year, role_id, date_added) '
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        [firstname, lastname, email, password, year, 2, timestamp]);
    print('Inserted ${result.affectedRows} row(s)');
  } finally {
    await conn.close();
  }
}
