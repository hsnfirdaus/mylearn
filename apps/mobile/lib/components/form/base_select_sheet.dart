import 'package:flutter/material.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/show_error.dart';
import 'package:mylearn/theme/theme_extension.dart';

class BaseSelectSheet<T> extends StatefulWidget {
  final String initialSearchTerm;
  final void Function(String) onSearch;
  final Future<List<T>> Function(BuildContext context, String term) fetchFn;
  final Widget Function(BuildContext context, T item, int index) buildItem;

  const BaseSelectSheet({
    super.key,
    required this.fetchFn,
    required this.buildItem,
    required this.initialSearchTerm,
    required this.onSearch,
  });

  @override
  State<BaseSelectSheet<T>> createState() => _BaseSelectSheetState<T>();
}

class _BaseSelectSheetState<T> extends State<BaseSelectSheet<T>> {
  late TextEditingController _searchController;
  late String _searchTerm;

  @override
  void initState() {
    super.initState();
    _searchTerm = widget.initialSearchTerm;
    _searchController = TextEditingController(text: _searchTerm);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: theme.background,
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(24),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Cari disini...",
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                  widget.onSearch(value);
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: widget.fetchFn(context, _searchTerm),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ShowError(label: snapshot.error.toString());
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final items = snapshot.data!;
                  if (items.isEmpty) {
                    return Empty();
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    itemCount: items.length,
                    itemBuilder: ((context, index) {
                      final item = items[index];
                      return widget.buildItem(context, item, index);
                    }),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Tutup', style: theme.elevatedButtonText),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
