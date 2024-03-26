import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/pushPage.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

/// Flutter code sample for [SearchAnchor.bar].

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key, this.hintText, required this.listSearch});
  final String? hintText;
  final Map<String, List<SearchItem>> listSearch;
  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  IconData? icon;
  List<SearchItem> searchHistory = <SearchItem>[];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (SearchItem searchItem) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PushPage(page: searchItem.navigateTo),
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
    return ["Bác sĩ", "Khoa", "Phòng"].map(
      (String title) => (widget.listSearch[title] ?? [])
              .where((SearchItem item) =>
                  formatString(item.label).contains(formatString(input)))
              .isEmpty
          ? SizedBox()
          : ListTile(
              title: DividerTitle(
                title: title,
                color: Colors.grey,
                padding: EdgeInsets.zero,
                thickness: .5,
                icon: Icon(
                    title == "Bác sĩ"
                        ? UniconsLine.stethoscope_alt
                        : (title == "Khoa"
                            ? UniconsLine.building
                            : UniconsLine.bed),
                    color: myColor),
                dividerColor: Colors.grey.withOpacity(.5),
              ),
              subtitle: Column(
                children: (widget.listSearch[title] ?? [])
                    .where((SearchItem item) =>
                        formatString(item.label).contains(formatString(input)))
                    .map((SearchItem searchItem) => ListTile(
                          title: Text(searchItem.label),
                          trailing: IconButton(
                            icon: const Icon(Icons.call_missed),
                            onPressed: () {
                              controller.text = searchItem.label;
                              controller.selection = TextSelection.collapsed(
                                  offset: controller.text.length);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PushPage(page: searchItem.navigateTo),
                                ));
                            handleSelection(searchItem);
                          },
                        ))
                    .toList(),
              ),
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

  SearchController controller = SearchController();
  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barLeading: Container(
        height: 55,
        width: 50,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: myColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(UniconsLine.search, color: Theme.of(context).cardColor),
      ),
      barPadding: MaterialStatePropertyAll(EdgeInsets.zero),
      barHintText: widget.hintText ?? 'Tìm kiếm...',
      barHintStyle: MaterialStateTextStyle.resolveWith(
          (states) => TextStyle(letterSpacing: 1)),
      // barBackgroundColor:
      //     MaterialStateColor.resolveWith((states) => Colors.transparent),
      dividerColor: Colors.grey.withOpacity(.5),
      barElevation: MaterialStatePropertyAll(0),
      viewHintText: "Tìm kiếm...",
      viewHeaderHintStyle: TextStyle(color: Colors.grey),
      viewBackgroundColor: Theme.of(context).cardColor,

      onTap: () {
        print("object");
      },
      searchController: controller,
      viewLeading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          controller.text = "";
        },
        icon: Icon(
          Icons.arrow_back,
          color: myColor,
        ),
      ),

      barShape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      // viewConstraints: BoxConstraints(maxWidth: 500),
      // isFullScreen: false,
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
