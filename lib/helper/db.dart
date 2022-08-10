// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import '../models/sleep.dart';

//Κλάση για την βάση της εφαρμογής
class DB {
  static Future<sql.Database> my_database() async {
    var databasesPath = await sql
        .getDatabasesPath(); //παίρνουμε το τοπικό μονοπάτι της συσκευής
    var dbName = 'theis.db'; //schema name
    var path = join(databasesPath, dbName); //ένωση μονοπατιού συσκευής με βάση
    return sql.openDatabase(path, version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database); //δμιουργία πίνακα
    });
  }

//πεδία πίνακα τα οποία χρειαζόαμστε για την κατάλληλη οπτικοποίηση της πληροφορίας
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""Create TABLE sleep(
      went_to_bed TEXT,
      woke_up TEXT,
      in_bed TEXT,
      sleep_score double NOT NULL,
      recording_day TEXT NOT NULL,
      asleep_min double,
      asleep_after double,
      awake double,
      minutes_deep_sleep double,
      minutes_light_sleep double,
      minutes_rem_sleep double
    )""");
  }

  Future<void> insertDymmy() async {
    //μέθοδος που καλείται στην main για την εισαγωγή των dummy δεδομένων στην βάση
    final db = await DB.my_database();
    String sql = '''
      INSERT INTO sleep (
          went_to_bed,
          woke_up,
          in_bed,
          sleep_score,
          recording_day,
          asleep_min,
          asleep_after,
          awake,
          minutes_deep_sleep,
          minutes_light_sleep,
          minutes_rem_sleep
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''';
    List<Map> data = [
      //dummy δεδομένα
      {
        "went_to_bed": '22:57',
        "woke_up": '07:30',
        "in_bed": '8h 32m',
        "sleep_score": 0.98,
        "recording_day": '2022-05-01',
        "asleep_min": 480.0,
        "asleep_after": 10.0,
        "awake": 30.0,
        "minutes_deep_sleep": 150.0,
        "minutes_light_sleep": 250.0,
        "minutes_rem_sleep": 80.0
      },
      {
        "went_to_bed": '22:42',
        "woke_up": '07:13',
        "in_bed": '8h 30m',
        "sleep_score": 0.65,
        "recording_day": '2022-05-02',
        "asleep_min": 400.0,
        "asleep_after": 8.0,
        "awake": 50.0,
        "minutes_deep_sleep": 80.0,
        "minutes_light_sleep": 300.0,
        "minutes_rem_sleep": 20.0
      },
      {
        "went_to_bed": '22:31',
        "woke_up": '06:03',
        "in_bed": '7h 32m',
        "sleep_score": 0.70,
        "recording_day": '2022-05-03',
        "asleep_min": 420.0,
        "asleep_after": 12.0,
        "awake": 40.0,
        "minutes_deep_sleep": 120.0,
        "minutes_light_sleep": 280.0,
        "minutes_rem_sleep": 20.0
      },
      {
        "went_to_bed": '22:12',
        "woke_up": '04:56',
        "in_bed": '6h 44m',
        "sleep_score": 0.69,
        "recording_day": '2022-05-04',
        "asleep_min": 370.0,
        "asleep_after": 4.0,
        "awake": 22.0,
        "minutes_deep_sleep": 100.0,
        "minutes_light_sleep": 200.0,
        "minutes_rem_sleep": 70.0
      },
      {
        "went_to_bed": '21:34',
        "woke_up": '04:53',
        "in_bed": '7h 18m',
        "sleep_score": 0.71,
        "recording_day": '2022-05-05',
        "asleep_min": 380.0,
        "asleep_after": 4.0,
        "awake": 15.0,
        "minutes_deep_sleep": 90.0,
        "minutes_light_sleep": 250.0,
        "minutes_rem_sleep": 40.0
      },
      {
        "went_to_bed": '21:32',
        "woke_up": '05:00',
        "in_bed": '7h 27m',
        "sleep_score": 0.67,
        "recording_day": '2022-05-06',
        "asleep_min": 330.0,
        "asleep_after": 25.0,
        "awake": 40.0,
        "minutes_deep_sleep": 100.0,
        "minutes_light_sleep": 200.0,
        "minutes_rem_sleep": 30.0
      },
      {
        "went_to_bed": '20:59',
        "woke_up": '06:19',
        "in_bed": '9h 19m',
        "sleep_score": 0.85,
        "recording_day": '2022-05-07',
        "asleep_min": 480.0,
        "asleep_after": 8.0,
        "awake": 25.0,
        "minutes_deep_sleep": 130.0,
        "minutes_light_sleep": 300.0,
        "minutes_rem_sleep": 50.0
      },
      {
        "went_to_bed": '22:58',
        "woke_up": '06:14',
        "in_bed": '7h 16m',
        "sleep_score": 0.79,
        "recording_day": '2022-05-08',
        "asleep_min": 420.0,
        "asleep_after": 4.0,
        "awake": 22.0,
        "minutes_deep_sleep": 100.0,
        "minutes_light_sleep": 310.0,
        "minutes_rem_sleep": 10.0
      },
      {
        "went_to_bed": '22:14',
        "woke_up": '06:20',
        "in_bed": '8h 6m',
        "sleep_score": 0.95,
        "recording_day": '2022-05-09',
        "asleep_min": 470.0,
        "asleep_after": 12.0,
        "awake": 10.0,
        "minutes_deep_sleep": 100.0,
        "minutes_light_sleep": 355.0,
        "minutes_rem_sleep": 15.0
      },
      {
        "went_to_bed": '21:51',
        "woke_up": '05:04',
        "in_bed": '7h 12m',
        "sleep_score": 0.55,
        "recording_day": '2022-05-10',
        "asleep_min": 320.0,
        "asleep_after": 22.0,
        "awake": 60.0,
        "minutes_deep_sleep": 70.0,
        "minutes_light_sleep": 230.0,
        "minutes_rem_sleep": 20.0
      },
      {
        "went_to_bed": '20:55',
        "woke_up": '06:14',
        "in_bed": '9h 19m',
        "sleep_score": 0.69,
        "recording_day": '2022-05-11',
        "asleep_min": 480.0,
        "asleep_after": 22.0,
        "awake": 15.0,
        "minutes_deep_sleep": 100.0,
        "minutes_light_sleep": 350.0,
        "minutes_rem_sleep": 30.0
      },
      {
        "went_to_bed": '23:00',
        "woke_up": '04:10',
        "in_bed": '5h 10m',
        "sleep_score": 0.40,
        "recording_day": '2022-05-12',
        "asleep_min": 270.0,
        "asleep_after": 18.0,
        "awake": 30.0,
        "minutes_deep_sleep": 60.0,
        "minutes_light_sleep": 200.0,
        "minutes_rem_sleep": 70.0
      },
      {
        "went_to_bed": '23:30',
        "woke_up": '05:00',
        "in_bed": '5h 30m',
        "sleep_score": 0.7,
        "recording_day": '2022-05-13',
        "asleep_min": 300.0,
        "asleep_after": 12.0,
        "awake": 30.0,
        "minutes_deep_sleep": 80.0,
        "minutes_light_sleep": 180.0,
        "minutes_rem_sleep": 40.0
      },
      {
        "went_to_bed": '22:47',
        "woke_up": '06:20',
        "in_bed": '7h 32m',
        "sleep_score": 0.75,
        "recording_day": '2022-05-14',
        "asleep_min": 430.0,
        "asleep_after": 9.0,
        "awake": 12.0,
        "minutes_deep_sleep": 30.0,
        "minutes_light_sleep": 390.0,
        "minutes_rem_sleep": 10.0
      },
      {
        "went_to_bed": '22:30',
        "woke_up": '06:48',
        "in_bed": '8h 17m',
        "sleep_score": 0.69,
        "recording_day": '2022-05-15',
        "asleep_min": 460,
        "asleep_after": 19.0,
        "awake": 17.0,
        "minutes_deep_sleep": 250.0,
        "minutes_light_sleep": 150.0,
        "minutes_rem_sleep": 60.0
      },
      {
        "went_to_bed": '22:20',
        "woke_up": '06:20',
        "in_bed": '8h 0m',
        "sleep_score": 0.69,
        "recording_day": '2022-05-16',
        "asleep_min": 380.0,
        "asleep_after": 30.0,
        "awake": 60.0,
        "minutes_deep_sleep": 100.0,
        "minutes_light_sleep": 220.0,
        "minutes_rem_sleep": 60.0
      },
      {
        "went_to_bed": '21:53',
        "woke_up": '05:30',
        "in_bed": '7h 36m',
        "sleep_score": 0.67,
        "recording_day": '2022-05-17',
        "asleep_min": 420.0,
        "asleep_after": 12.0,
        "awake": 10.0,
        "minutes_deep_sleep": 200.0,
        "minutes_light_sleep": 150.0,
        "minutes_rem_sleep": 70.0
      },
      {
        "went_to_bed": '22:16',
        "woke_up": '05:20',
        "in_bed": '7h 4m',
        "sleep_score": 0.74,
        "recording_day": '2022-05-18',
        "asleep_min": 420.0,
        "asleep_after": 10.0,
        "awake": 4.0,
        "minutes_deep_sleep": 200.0,
        "minutes_light_sleep": 150.0,
        "minutes_rem_sleep": 70.0
      },
      {
        "went_to_bed": '23:45',
        "woke_up": '06:16',
        "in_bed": '6h 35m',
        "sleep_score": 0.78,
        "recording_day": '2022-05-19',
        "asleep_min": 360.0,
        "asleep_after": 12.0,
        "awake": 15.0,
        "minutes_deep_sleep": 90.0,
        "minutes_light_sleep": 230.0,
        "minutes_rem_sleep": 40.0
      },
      {
        "went_to_bed": '22:54',
        "woke_up": '07:49',
        "in_bed": '8h 55m',
        "sleep_score": 0.92,
        "recording_day": '2022-05-20',
        "asleep_min": 480.0,
        "asleep_after": 14.0,
        "awake": 30.0,
        "minutes_deep_sleep": 70.0,
        "minutes_light_sleep": 290.0,
        "minutes_rem_sleep": 20.0
      },
      {
        "went_to_bed": '20:14',
        "woke_up": '05:44',
        "in_bed": '9h 29m',
        "sleep_score": 0.8,
        "recording_day": '2022-05-21',
        "asleep_min": 480.0,
        "asleep_after": 19.0,
        "awake": 60.0,
        "minutes_deep_sleep": 150.0,
        "minutes_light_sleep": 300.0,
        "minutes_rem_sleep": 30.0
      },
      {
        "went_to_bed": '21:50',
        "woke_up": '04:51',
        "in_bed": '7h 0m',
        "sleep_score": 0.77,
        "recording_day": '2022-05-22',
        "asleep_min": 340.0,
        "asleep_after": 4.0,
        "awake": 42.0,
        "minutes_deep_sleep": 140.0,
        "minutes_light_sleep": 180.0,
        "minutes_rem_sleep": 20.0
      },
      {
        "went_to_bed": '21:17',
        "woke_up": '06:18',
        "in_bed": '9h 1m',
        "sleep_score": 0.97,
        "recording_day": '2022-05-23',
        "asleep_min": 480.0,
        "asleep_after": 2.0,
        "awake": 22.0,
        "minutes_deep_sleep": 300.0,
        "minutes_light_sleep": 100.0,
        "minutes_rem_sleep": 80.0
      },
      {
        "went_to_bed": '21:41',
        "woke_up": '05:00',
        "in_bed": '7h 18m',
        "sleep_score": 0.69,
        "recording_day": '2022-05-24',
        "asleep_min": 300.0,
        "asleep_after": 30.0,
        "awake": 55.0,
        "minutes_deep_sleep": 80.0,
        "minutes_light_sleep": 200.0,
        "minutes_rem_sleep": 20.0
      },
      {
        "went_to_bed": '21:22',
        "woke_up": '04:57',
        "in_bed": '7h 34m',
        "sleep_score": 0.89,
        "recording_day": '2022-05-25',
        "asleep_min": 420.0,
        "asleep_after": 5.0,
        "awake": 5.0,
        "minutes_deep_sleep": 80.0,
        "minutes_light_sleep": 300.0,
        "minutes_rem_sleep": 40.0
      },
      {
        "went_to_bed": '23:10',
        "woke_up": '04:10',
        "in_bed": '5h 0m',
        "sleep_score": 0.51,
        "recording_day": '2022-05-26',
        "asleep_min": 200.0,
        "asleep_after": 9.0,
        "awake": 60.0,
        "minutes_deep_sleep": 20.0,
        "minutes_light_sleep": 175.0,
        "minutes_rem_sleep": 5.0
      },
      {
        "went_to_bed": '23:45',
        "woke_up": '04:00',
        "in_bed": '4h 15m',
        "sleep_score": 0.57,
        "recording_day": '2022-05-27',
        "asleep_min": 240.0,
        "asleep_after": 9.0,
        "awake": 10.0,
        "minutes_deep_sleep": 40.0,
        "minutes_light_sleep": 195.0,
        "minutes_rem_sleep": 5.0
      },
      {
        "went_to_bed": '22:39',
        "woke_up": '06:20',
        "in_bed": '7h 41m',
        "sleep_score": 0.75,
        "recording_day": '2022-05-28',
        "asleep_min": 400.0,
        "asleep_after": 4.0,
        "awake": 22.0,
        "minutes_deep_sleep": 180.0,
        "minutes_light_sleep": 200.0,
        "minutes_rem_sleep": 20.0
      },
      {
        "went_to_bed": '23:51',
        "woke_up": '07:35',
        "in_bed": '7h 44m',
        "sleep_score": 0.73,
        "recording_day": '2022-05-29',
        "asleep_min": 410.0,
        "asleep_after": 28.0,
        "awake": 12.0,
        "minutes_deep_sleep": 150.0,
        "minutes_light_sleep": 220.0,
        "minutes_rem_sleep": 40.0
      },
      {
        "went_to_bed": '23:00',
        "woke_up": '07:00',
        "in_bed": '8h 0m',
        "sleep_score": 0.80,
        "recording_day": '2022-05-30',
        "asleep_min": 450.0,
        "asleep_after": 4.0,
        "awake": 3.0,
        "minutes_deep_sleep": 28.0,
        "minutes_light_sleep": 336.0,
        "minutes_rem_sleep": 86.0
      },
      {
        "went_to_bed": '23:34',
        "woke_up": '07:04',
        "in_bed": '7h 38m',
        "sleep_score": 0.92,
        "recording_day": '2022-05-31',
        "asleep_min": 440.0,
        "asleep_after": 20.0,
        "awake": 19.0,
        "minutes_deep_sleep": 28.0,
        "minutes_light_sleep": 326.0,
        "minutes_rem_sleep": 86.0
      },
    ];
    data.forEach((element) async {
      await db.rawInsert(sql, [
        element['went_to_bed'],
        element['woke_up'],
        element['in_bed'],
        element['sleep_score'],
        element['recording_day'],
        element['asleep_min'],
        element['asleep_after'],
        element["awake"],
        element["minutes_deep_sleep"],
        element["minutes_light_sleep"],
        element["minutes_rem_sleep"]
      ]);
    });
  }

  Future<List<Sleep>> getHomeInfo(DateTime dateTime) async {
    //δεδομενα αρχικης σελιδας με βαση το τωρινο DateTime
    final db =
        await DB.my_database(); //παίρνουμε το Path που βρίσκεται η βάση μας
    final date = DateFormat('yyyy-MM-dd').format(dateTime);
    final List<Map<String, dynamic>> sleep =
        await db.rawQuery('SELECT * from sleep where recording_day=?', [date]);
    //κανουμε select query  ολα τα δεδομένα με βάση το dateTime
    return sleep.map((sleep) => Sleep.fromJson(sleep)).toList();
    //επιστροφή λίστας
  }

//παίρνουμε τα δεδομένα μιας εβδομάδας(ανάλογα των 7 ημερών που θα επιλέξουμε)
  Future<List<Sleep>> getAllRecordsByWeekend(
      String startDate, String endDate) async {
    final db = await DB.my_database();

    final List<Map<String, dynamic>> recordDay = await db.rawQuery(
      'SELECT * FROM sleep WHERE recording_day>=? AND recording_day<=?',
      [startDate, endDate],
    );

    return List.generate(
        recordDay.length,
        (index) => Sleep(
            went_to_bed: recordDay[index]['went_to_bed'],
            woke_up: recordDay[index]['woke_up'],
            in_bed: recordDay[index]['in_bed'],
            sleep_score: recordDay[index]['sleep_score'],
            recording_day: recordDay[index]['recording_day'],
            asleep_min: recordDay[index]['asleep_min'],
            asleep_after: recordDay[index]['asleep_after'],
            awake: recordDay[index]['awake'],
            minutes_deep_sleep: recordDay[index]['minutes_deep_sleep'],
            minutes_light_sleep: recordDay[index]['minutes_light_sleep'],
            minutes_rem_sleep: recordDay[index]['minutes_rem_sleep']));
  }

  Future<List<Sleep>> getAllRecordsByMonth(
      String startDate, String endDate) async {
    final db = await DB.my_database();

    final List<Map<String, dynamic>> recordDay = await db.rawQuery(
      'SELECT * FROM sleep WHERE recording_day>=? AND recording_day<=?',
      [startDate, endDate],
    );

    return List.generate(
        recordDay.length,
        (index) => Sleep(
            went_to_bed: recordDay[index]['went_to_bed'],
            woke_up: recordDay[index]['woke_up'],
            in_bed: recordDay[index]['in_bed'],
            sleep_score: recordDay[index]['sleep_score'],
            recording_day: recordDay[index]['recording_day'],
            asleep_min: recordDay[index]['asleep_min'],
            asleep_after: recordDay[index]['asleep_after'],
            awake: recordDay[index]['awake'],
            minutes_deep_sleep: recordDay[index]['minutes_deep_sleep'],
            minutes_light_sleep: recordDay[index]['minutes_light_sleep'],
            minutes_rem_sleep: recordDay[index]['minutes_rem_sleep']));
  }

  Future<List<Sleep>> getAllRecordsByWeekendTemp(
      String startDate, String endDate) async {
    final db = await DB.my_database();

    final List<Map<String, dynamic>> recordDay = await db.rawQuery(
      'SELECT * FROM sleep WHERE recording_day>=? AND recording_day<=?',
      [startDate, endDate],
    );

    return List.generate(
        recordDay.length,
        (index) => Sleep(
            went_to_bed: recordDay[index]['went_to_bed'],
            woke_up: recordDay[index]['woke_up'],
            in_bed: recordDay[index]['in_bed'],
            sleep_score: recordDay[index]['sleep_score'],
            recording_day: recordDay[index]['recording_day'],
            asleep_min: recordDay[index]['asleep_min'],
            asleep_after: recordDay[index]['asleep_after'],
            awake: recordDay[index]['awake'],
            minutes_deep_sleep: recordDay[index]['minutes_deep_sleep'],
            minutes_light_sleep: recordDay[index]['minutes_light_sleep'],
            minutes_rem_sleep: recordDay[index]['minutes_rem_sleep']));
  }

  Future<List<Sleep>> getAllRecordsBySpesificDayy() async {
    final db = await DB.my_database();

    final List<Map<String, dynamic>> recordDay = await db.rawQuery(
      'SELECT * FROM sleep WHERE recording_day>=?',
      ['2022-04-18'],
    );

    return List.generate(
        recordDay.length,
        (index) => Sleep(
            went_to_bed: recordDay[index]['went_to_bed'],
            woke_up: recordDay[index]['woke_up'],
            in_bed: recordDay[index]['in_bed'],
            sleep_score: recordDay[index]['sleep_score'],
            recording_day: recordDay[index]['recording_day'],
            asleep_min: recordDay[index]['asleep_min'],
            asleep_after: recordDay[index]['asleep_after'],
            awake: recordDay[index]['awake'],
            minutes_deep_sleep: recordDay[index]['minutes_deep_sleep'],
            minutes_light_sleep: recordDay[index]['minutes_light_sleep'],
            minutes_rem_sleep: recordDay[index]['minutes_rem_sleep']));
  }
}
