import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

/// Flutter code sample for [SearchAnchor.bar].

class MySearchTextField extends StatefulWidget {
  const MySearchTextField({super.key, this.hintText, required this.listSearch});
  final String? hintText;
  final List<SearchItem> listSearch;
  @override
  State<MySearchTextField> createState() => _MySearchTextFieldState();
}

class _MySearchTextFieldState extends State<MySearchTextField> {
  IconData? icon;
  List<SearchItem> searchHistory = <SearchItem>[];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (SearchItem searchItem) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => searchItem.navigateTo,
              ));
        },
        leading: const Icon(Icons.history),
        title: Text(searchItem.label),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = searchItem.label;
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return widget.listSearch
        .where((SearchItem item) =>
            formatString(item.label).contains(formatString(input)))
        .map(
          (SearchItem searchItem) => ListTile(
            leading: CircleAvatar(
              child: Icon(searchItem.iconData, color: myColor),
              backgroundColor: Colors.transparent,
            ),
            title: Text(searchItem.label),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = searchItem.label;
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => searchItem.navigateTo,
                  ));
              handleSelection(searchItem);
            },
          ),
        );
  }

  void handleSelection(SearchItem searchItem) {
    setState(() {
      icon = searchItem.iconData;
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, searchItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      viewBackgroundColor: Theme.of(context).cardColor,
      viewConstraints: BoxConstraints(maxWidth: 500),
      isFullScreen: false,
      barLeading: Icon(UniconsLine.search, color: Colors.grey),
      viewHeaderHintStyle: TextStyle(color: Colors.grey),
      barHintText: widget.hintText ?? 'Tìm kiếm bác sĩ, khoa...',
      barHintStyle: MaterialStateTextStyle.resolveWith(
          (states) => TextStyle(color: Colors.grey, letterSpacing: 1)),
      barBackgroundColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
      barElevation: MaterialStatePropertyAll(0),
      viewHintText: "Tìm kiếm tên bác sĩ, điều dưỡng,...",
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        if (controller.text.isEmpty) {
          if (searchHistory.isNotEmpty) {
            return getHistoryList(controller);
          }
          return <Widget>[
            Center(
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.history_sharp, color: Colors.grey, size: 30),
                    SizedBox(height: 20),
                    Text(
                      'Chưa có lịch sử tìm kiếm',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ];
        }
        return getSuggestions(controller);
      },
    );
  }
}

SizedBox cardSize = const SizedBox(
  width: 80,
  height: 30,
);

class SearchItem {
  const SearchItem(this.label, this.iconData, this.navigateTo);
  final String label;
  final IconData iconData;
  final Widget navigateTo;
}
