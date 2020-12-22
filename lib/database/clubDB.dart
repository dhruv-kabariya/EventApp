import 'package:event/model/club.dart';
import 'package:hive/hive.dart';

class ClubDB {
  Future<int> addClub(Club club) async {
    final Box clubs = Hive.box("club");

    await clubs.put(club.id, club);
    return club.id;
  }

  static Club getClub(int id) {
    final Box clubs = Hive.box("club");

    return clubs.get(id) as Club;
  }

  static List<Club> getclubList() {
    final Box clubs = Hive.box("club");

    try {
      print(clubs.values.map((e) => e as Club).toList());
    } catch (e) {
      print(e.toString());
    }
    return clubs.values.map((e) => e as Club).toList();
  }

  Future<void> addClubList(List<Club> club) async {
    final Box clubs = Hive.box("club");
    for (int i = 0; i < club.length; i++) {
      await clubs.put(club[i].id, club[i]);
    }
    return;
  }

  Future<void> updateChache(List<Club> listClubs) async {
    final Box clubs = Hive.box("club");

    await clubs.deleteAll(clubs.keys);
    for (int i = 0; i < listClubs.length; i++) {
      print(listClubs[i].poster);

      await clubs.put(listClubs[i].id, listClubs[i]);
    }
    return;
  }
}
