import 'package:MySearch/views/home/widgets/ad-list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MySearch/views/home/home-view-model.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        viewModelBuilder: () => HomeScreenViewModel(context),
        disposeViewModel: false,
        builder: (context, viewModel, child) {
          return Container(
              color: Colors.white,
              child: SafeArea(
                  child: Scaffold(
                appBar: buildAppBar(),
                body: buildBody(viewModel, context),
                drawer: buildDrawer(context),
              )));
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("MySearch"),
    );
  }

  Widget buildBody(viewModel, context) {
    /// building our UI
    /// notice we are observing viewModel.apiResponseModel
    /// Hence buildDataWidget will rebuild when apiResponse changes in ViewModel
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("All")),
              Tab(icon: Text("Newest")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            adListWidget(viewModel.ads, viewModel.messageToShowAds, context),
            adListWidget(viewModel.adsSinceLastConnection,
                viewModel.messageToShowAdsSince, context)
          ],
        ),
      ),
    );
  }

  Widget buildDrawer(context) {
    return Drawer(
      child: Material(
          child: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4, left: 15),
                    child: GestureDetector(
                      onTap: () {
                        print("Container was tapped");
                      },
                      child: PopupMenuButton<String>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircleAvatar(
                                    child: Icon(Icons.person,
                                        color: Colors.white, size: 12),
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "   Guest",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, height: 1.2),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2, right: 25),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onSelected: (String s) {
                          if (s == "Logout") {
                            //AuthenticationManager.logout();
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return <String>["Lougout"].map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    )),
                Divider(),
                ListTile(
                  title: Text("Saved search"),
                  leading: Icon(Icons.search),
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (_) => SearchList()),
                    // );
                  },
                ),
                ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (_) => Settings()),
                    // );
                  },
                )
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  width: 20,
                  decoration: BoxDecoration(
                      //color: Colors.grey,
                      border: Border(
                          top: BorderSide(
                    color: Colors.grey[200],
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.settings,
                        size: 18,
                      ),
                      Text(
                        "  Settings",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
