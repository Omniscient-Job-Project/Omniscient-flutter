import 'package:flutter/material.dart';
import '../models/notice.dart';

class NoticeListItem extends StatelessWidget {
  final Notice notice;
  final Function(int) onTap;

  const NoticeListItem({required this.notice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notice.noticeTitle),
      subtitle: Text(DateTime.parse(notice.noticeCreateAt).toLocal().toString().split(' ')[0]),
      trailing: Text(notice.noticeViews.toString()),
      onTap: () => onTap(notice.noticeId),
    );
  }
}
