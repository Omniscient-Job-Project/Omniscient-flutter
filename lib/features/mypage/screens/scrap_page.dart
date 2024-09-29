import 'package:flutter/material.dart';
import '../repositories/scrap_repository.dart';
import '../models/scrap_item.dart';
import '../widgets/scrap_item_card.dart';

class ScrapPage extends StatefulWidget {
  @override
  _ScrapPageState createState() => _ScrapPageState();
}

class _ScrapPageState extends State<ScrapPage> {
  List<ScrapItem> scrapItems = [];
  late ScrapRepository scrapRepository;

  @override
  void initState() {
    super.initState();
    scrapRepository = ScrapRepository();
    loadScrapItems();
  }

  Future<void> loadScrapItems() async {
    List<ScrapItem> items = await scrapRepository.loadScrapItems();
    setState(() {
      scrapItems = items;
    });
  }

  void removeScrap(int index, String type) {
    setState(() {
      scrapRepository.removeScrapItem(scrapItems, index, type);
      scrapRepository.saveScrapItems(scrapItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스크랩'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (scrapItems.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 48, color: Colors.blue),
                    SizedBox(height: 20),
                    Text('스크랩한 항목이 없습니다.'),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: scrapItems.length,
                itemBuilder: (context, index) {
                  final item = scrapItems[index];
                  return ScrapItemCard(
                    scrapItem: item,
                    onRemove: () => removeScrap(index, item.jobId != null ? 'job' : 'cert'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
