import 'package:shared_preferences/shared_preferences.dart';
import '../models/scrap_item.dart';
import 'dart:convert';

class ScrapRepository {
  Future<List<ScrapItem>> loadScrapItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedItems = prefs.getString('bookmarks');
    if (savedItems != null) {
      List<dynamic> jsonList = json.decode(savedItems);
      return jsonList.map((json) => ScrapItem.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> saveScrapItems(List<ScrapItem> scrapItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(scrapItems.map((item) => item.toJson()).toList());
    await prefs.setString('bookmarks', jsonString);
  }

  // 새로 추가된 메서드
  Future<void> addScrapItem(ScrapItem item) async {
    List<ScrapItem> scrapItems = await loadScrapItems();
    scrapItems.add(item);
    await saveScrapItems(scrapItems);
  }

  Future<void> removeScrapItemById(String jmNm) async {
    List<ScrapItem> scrapItems = await loadScrapItems();
    scrapItems.removeWhere((item) => item.jmNm == jmNm);
    await saveScrapItems(scrapItems);
  }

// 기존 메서드 삭제 또는 필요에 따라 수정
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
