import 'dart:async';

import 'package:mysql1/mysql1.dart';

void main() async {
  connectDB();
}

Future connectDB() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: '178.128.31.129',
    port: 3306,
    user: 'phradabos',
    password: 'GJQPg29zWvZu3vXW',
    db: 'dbphradabos',
  ));

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
