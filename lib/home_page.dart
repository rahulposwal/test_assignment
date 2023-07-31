import 'dart:async';
import 'package:assignment_project/bloc/home_bloc.dart';
import 'package:assignment_project/bloc/home_event.dart';
import 'package:assignment_project/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dialogList = [];
  List<String> localDialogList = [];
  Timer? timer;
  int count = 0;
  SharedPreferences? prefs;

  @override
  void initState() {
    initPref();
    BlocProvider.of<HomeBloc>(context).add(LoadUserEvent());
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      BlocProvider.of<HomeBloc>(context).add(LoadUserEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Jocks')),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is DataLoadingState) {
              count++;
              return count == 1
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: dialogList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Card(
                              color: Theme.of(context).primaryColor,
                              child: ListTile(
                                title: Text(
                                  '${dialogList[index]}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                        );
                      });
            }
            if (state is DataLoadedState) {
              //api success and load data into list
              Map<String, dynamic> userList = state.users;
              if (prefs!.getBool("isLocalData")!) {
                dialogList.add(userList['joke']);
              } else {
                if (dialogList.length > 9) {
                  dialogList.removeAt(0);
                  dialogList.add(userList['joke']);
                  localDialogList.add(userList['joke']);
                  prefs!.setStringList('dialogList', localDialogList);
                } else {
                  dialogList.add(userList['joke']);
                  localDialogList.add(userList['joke']);
                  prefs!.setStringList('dialogList', localDialogList);
                }
              }

              //list for display dialog data
              return ListView.builder(
                  itemCount: dialogList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Card(
                          color: Theme.of(context).primaryColor,
                          child: ListTile(
                            title: Text(
                              '${dialogList[index]}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                    );
                  });
            }
            if (state is DataErrorState) {
              return const Center(
                child: Text("Error"),
              );
            }

            return Container();
          },
        ));
  }

  void initPref() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool("isLocalData", false);
    if (prefs!.getStringList('dialogList') != null) {
      count++;
      prefs!.setBool("isLocalData", true);
      dialogList = prefs!.getStringList('dialogList')!;
      localDialogList = prefs!.getStringList('dialogList')!;
    }
  }
}
