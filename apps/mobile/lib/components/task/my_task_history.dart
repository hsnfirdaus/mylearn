import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/task/task_item.dart';
import 'package:mylearn/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyTaskHistory extends StatefulWidget {
  const MyTaskHistory({super.key});

  @override
  State<MyTaskHistory> createState() => _MyTaskHistoryState();
}

class _MyTaskHistoryState extends State<MyTaskHistory> {
  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int offset) async {
    try {
      final pageSize = 20;
      final end = offset + pageSize - 1;
      final res = await Supabase.instance.client
          .from("subject_task_student")
          .select(
            "id, status, updated_at, subject_task(id, title, semester_id, subject_id, student_nim, deadline, created_at, subject(name, code))",
          )
          .inFilter("status", ['submitted'])
          .range(offset, end)
          .order('updated_at', ascending: false)
          .count(CountOption.exact);
      final List<Map<String, dynamic>> data =
          res.data.map((item) {
            return {
              "id": item['subject_task']['id'],
              "title": item['subject_task']['title'],
              "semester_id": item['subject_task']['semester_id'],
              "subject_id": item['subject_task']['subject_id'],
              "student_nim": item['subject_task']['student_nim'],
              "deadline": item['subject_task']['deadline'],
              "created_at": item['subject_task']['created_at'],
              "subject_name": item['subject_task']['subject']['name'],
              "subject_code": item['subject_task']['subject']['code'],
              "status": item['status'],
              "updated_at": item['updated_at'],
            };
          }).toList();
      final int count = res.count;

      final isLastPage = count <= end;
      if (isLastPage) {
        _pagingController.appendLastPage(data);
      } else {
        final nextPageKey = end + 1;
        _pagingController.appendPage(data, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void onDetail(String id) async {
    await context.push<bool>(AppRoute.taskDetail(subjectTaskId: id));
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Map<String, dynamic>>(
      padding: EdgeInsets.all(24),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
        noItemsFoundIndicatorBuilder: (context) {
          return const Empty(
            icon: LucideIcons.smile,
            label: "Tidak Ada Tugas.",
          );
        },
        itemBuilder:
            (context, item, index) => TaskItem(
              isHistory: true,
              item: item,
              onPress: () {
                onDetail(item['id']);
              },
            ),
      ),
    );
  }
}
