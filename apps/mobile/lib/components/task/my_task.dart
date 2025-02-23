import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/task/task_item.dart';
import 'package:mylearn/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyTask extends StatefulWidget {
  final bool? isHome;
  final double? topPadding;
  final double? bottomPadding;
  final PagingController<int, Map<String, dynamic>>? pagingController;
  const MyTask({
    super.key,
    this.isHome,
    this.topPadding,
    this.bottomPadding,
    this.pagingController,
  });

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  late PagingController<int, Map<String, dynamic>> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController =
        widget.pagingController ?? PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int offset) async {
    try {
      final pageSize = widget.isHome == true ? 5 : 20;
      final end = offset + pageSize - 1;
      final res = await Supabase.instance.client
          .from("not_submitted_task")
          .select("*")
          .range(offset, end)
          .count(CountOption.exact);
      final data = res.data;
      final int count = res.count;

      final isLastPage = widget.isHome == true || count <= end;
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
    if (widget.pagingController == null) {
      _pagingController.dispose();
    }
    super.dispose();
  }

  void onDetail(String id) async {
    await context.push<bool>(AppRoute.taskDetail(subjectTaskId: id));
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Map<String, dynamic>>(
      shrinkWrap: widget.isHome == true,
      padding: EdgeInsets.only(
        top: widget.topPadding ?? 0,
        bottom: widget.bottomPadding ?? 0,
        left: 24,
        right: 24,
      ),
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
              item: item,
              onPress: () {
                onDetail(item['id']);
              },
            ),
        noMoreItemsIndicatorBuilder: (context) {
          if (widget.isHome == true) {
            return Padding(
              padding: EdgeInsets.only(top: 12),
              child: ElevatedButton(
                onPressed: () async {
                  await context.push(AppRoute.task);
                  _pagingController.refresh();
                },
                child: Text("Lihat Tugas Lainnya"),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
