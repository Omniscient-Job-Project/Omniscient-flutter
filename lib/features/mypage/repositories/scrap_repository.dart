import 'package:shared_preferences/shared_preferences.dart';
import '../../certificate/models/test_job.dart';
import '../models/scrap_item.dart';
import 'dart:convert';

class ScrapRepository {
  // 스크랩 아이템 로드
  Future<List<ScrapItem>> loadScrapItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedItems = prefs.getString('bookmarks');
    if (savedItems != null) {
      List<dynamic> jsonList = json.decode(savedItems);
      return jsonList.map((json) => ScrapItem.fromJson(json)).toList();
    }
    return [];
  }

  // 스크랩 아이템 저장
  Future<void> saveScrapItems(List<ScrapItem> scrapItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(scrapItems.map((item) => item.toJson()).toList());
    await prefs.setString('bookmarks', jsonString);
  }

  // 즐겨찾기된 시험 일정 로드
  Future<List<TestJob>> loadFavoriteTestJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedItems = prefs.getString('favorite_test_jobs');
    if (savedItems != null) {
      List<dynamic> jsonList = json.decode(savedItems);
      return jsonList.map((json) => TestJob.fromJson(json)).toList();
    }
    return [];
  }

  // 즐겨찾기된 시험 일정 저장
  Future<void> saveFavoriteTestJobs(List<TestJob> favoriteTestJobs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(favoriteTestJobs.map((job) => job.toJson()).toList());
    await prefs.setString('favorite_test_jobs', jsonString);
  }

  // 스크랩 아이템 추가
  Future<void> addScrapItem(ScrapItem item) async {
    List<ScrapItem> scrapItems = await loadScrapItems();
    scrapItems.add(item);
    await saveScrapItems(scrapItems);
  }

  // ID를 기준으로 스크랩 아이템 제거
  Future<void> removeScrapItemById(String jmNm) async {
    List<ScrapItem> scrapItems = await loadScrapItems();
    scrapItems.removeWhere((item) => item.jmNm == jmNm);
    await saveScrapItems(scrapItems);
  }

  // 기존 메서드: 스크랩 아이템 제거
  void removeScrapItem(List<ScrapItem> scrapItems, int index, String type) {
    if (type == 'job') {
      scrapItems.removeWhere((item) => item.jobId == scrapItems[index].jobId);
    } else if (type == 'cert') {
      scrapItems.removeWhere((item) => item.jmNm == scrapItems[index].jmNm);
    } else if (type == 'employment') {
      scrapItems.removeWhere((item) => item.instNm == scrapItems[index].instNm);
    }
  }
}
