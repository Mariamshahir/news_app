import 'package:flutter/material.dart';
import 'package:news_app/data/api_manger.dart';
import 'package:news_app/model/source.dart';

class TabsList extends StatelessWidget {
  const TabsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.loadTabsList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return errorView(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return tabsList(snapshot.data!.sources!);
          } else {
            return loadingView();
          }
        });
  }
}

Widget errorView(String error) {
  return Column(
    children: [
      Text(error),
      ElevatedButton(onPressed: () {}, child: Text("Refresh"))
    ],
  );
}

Widget tabsList(List<Source> sources) {
  return const Text("Succesfull api call");
}

Widget loadingView() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.blue,
    ),
  );
}
