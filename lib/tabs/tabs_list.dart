import 'package:flutter/material.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/view_model/tabs_list_view_model.dart';
import 'package:news_app/widgets/taps_widgets.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/widgets/app_error.dart';
import 'package:news_app/widgets/loddingapp.dart';
import 'package:provider/provider.dart';

class TabsList extends StatefulWidget {
  final String categoryId;

  const TabsList({super.key, required this.categoryId});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  int currentTabIndex = 0;
  TabsListViewModel viewModel = TabsListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadTabsList(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Builder(
        builder: (context) {
          viewModel = Provider.of(context, listen: true);
          if (viewModel.state == TapsListState.loading) {
            return const LoaddingApp();
          } else if (viewModel.state == TapsListState.success) {
            return tabsList(viewModel.sources);
          } else {
            return AppError(error: viewModel.errorMessage,onRefreshClick: (){
              viewModel.loadTabsList(widget.categoryId);
            },);
          }
        },
      ),
    );
  }

  Widget tabsList(List<Source> sources) {
    List<Widget> tabsViewList = [];
    for (var source in sources) {
      tabsViewList.add(tabsView(source, true));
    }
    return DefaultTabController(
      length: sources.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            tabs: sources.map((source) {
              return tabsView(
                  source, currentTabIndex == sources.indexOf(source));
            }).toList(),
            isScrollable: true,
            indicatorColor: Colors.transparent,
            onTap: (newTabIndex) {
              setState(() {
                currentTabIndex = newTabIndex;
              });
            },
          ),
          Expanded(
            child: TabBarView(
              children: sources
                  .map((source) => TapsDetails(
                        sourceId: source.id!,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabsView(Source source, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBarBackground, width: 2),
        borderRadius: BorderRadius.circular(25),
        color: isSelected ? AppColors.appBarBackground : Colors.transparent,
      ),
      child: Text(
        source.name ?? "Unknown Source",
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.appBarBackground,
        ),
      ),
    );
  }
}
