import 'package:activities_and_weather/constant/app_constant.dart';
import 'package:activities_and_weather/model/activity_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final String url = 'http://10.0.2.2:5208/api/Activity/GetActivities';
  List<ActivitiyModel>? activityList = [];
  bool complated = false;
  int setStateCounter = 0;
  Uuid uuid = const Uuid();
  TextEditingController searchController = TextEditingController();
  TextEditingController addActivityController = TextEditingController();

  final Dio _dio = Dio();
  @override
  void initState() {
    super.initState();
    //activityList = activityListDummy;
    getItems();
  }

  Future<void> getItems() async {
    final res = await _dio.get(url);
    final response = res.data;
    if (response is List) {
      activityList = response.map((e) => ActivitiyModel.fromJson(e)).toList();
      setState(() {
        complated = true;
      });
    }
  }

  Future<bool> deleteItem(String guidId, ActivitiyModel model) async {
    try {
      await _dio.delete("$url/$guidId");

      setState(() {
        activityList!.remove(model);
      });
      return true;
    } catch (e) {
      throw Exception('Hata Oldu: $e');
    }
  }

  Future<void> addItems({required ActivitiyModel model}) async {
    try {
      await _dio.post(
        url,
        data: model.toJson(),
      );
    } catch (e) {
      throw Exception("Hata--------> $e");
    }
  }

  Future<void> updateTodo(int uuid, String title, bool completed) async {
    try {
      await _dio.put(
        '$url/$uuid',
        data: {'title': title, 'completed': completed},
      );
    } catch (error) {
      throw Exception('Failed to update todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$setStateCounter"),
      ),
      body: complated == false
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Aktive Ara",
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        itemCount: activityList!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.backgroundColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          activityList![index].title.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          activityList![index]
                                              .category
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      child: _deleteUpdateAddButton(
                                          index, context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          "+",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Aktivite Ekle'),
                content: TextField(
                  controller: addActivityController,
                  onSubmitted: (value) {
                    addActivityController.text = value;
                  },
                ),
                actions: [
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () async {
                      if (addActivityController.text.isNotEmpty) {
                        ActivitiyModel activitiyModel = ActivitiyModel(
                          id: "a3134fa2-447e-4ac9-821e-681814ac8202",
                          title: addActivityController.text,
                          category: "-",
                          city: "-",
                          description: "-",
                          venue: "-",
                          date: "2023-08-10 15:34:56.789+03",
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        await addItems(model: activitiyModel);
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Row _deleteUpdateAddButton(int index, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: IconButton(
              onPressed: () {
                setState(() {
                  deleteItem(
                    activityList![index].id.toString(),
                    activityList![index],
                  );
                  setStateCounter++;
                });
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.update,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
