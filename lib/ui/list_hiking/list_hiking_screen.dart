import 'package:flutter/material.dart';
import 'package:jogging_app/common/common_textfield.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';
import 'package:jogging_app/data/local/hiking.dart';
import 'package:jogging_app/data/repository/hiking_repository.dart';
import 'package:jogging_app/date_utils.dart';
import 'package:jogging_app/ui/add_hiking/add_hiking_screen.dart';
import 'package:jogging_app/ui/hiking_detail/hiking_detail_screen.dart';

import '../../common/confirm_dialog.dart';

class ListHikingScreen extends StatefulWidget {
  const ListHikingScreen({super.key});

  @override
  State<ListHikingScreen> createState() => _ListHikingScreenState();
}

class _ListHikingScreenState extends State<ListHikingScreen> {
  TextEditingController searchController = TextEditingController();
  final HikingRepository _joggingRepository = HikingRepository();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    await _joggingRepository.getListHiking();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "List hike",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [

          ///XOá hết bản ghi
          TextButton(
            onPressed: () async {
              await showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext ctx) => ConfirmDialog(
                    title: "Are you sure you want to delete all?",
                    onConfirmTap: () {
                      _joggingRepository.deleteAllHiking().then((value) {
                        _getData();
                      });
                    }),
              );
            },
            child: const Text(
              "Delete all",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {

              ///Thêm chuyến đi
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AddHikingScreen(),
                ),
              ).then((value) {
                _getData();
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add_circle_outline,
              ),
            ),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (_joggingRepository.listData == null ||
            _joggingRepository.listData == []) {
          return const Center(
            child: Text(
              "No Data",
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              kVerticalSpace16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InputField(
                  controller: searchController,
                  hintText: "Input to search...",
                  onValueChanged: (value) async {
                    searchController.text = value;
                    await _joggingRepository.searchByName(value).then((value) {
                      setState(() {});
                    });
                  },
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  top: 16,
                ),
                itemBuilder: (context, index) {
                  final data = _joggingRepository.listData![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              HikingDetailScreen(id: data.id),
                        ),
                      ).then((value) {
                        _getData();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 8,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hike name: ${data.hikeName ?? ''}",
                                    style: AppStyles.caption12Semibold(),
                                  ),
                                  kVerticalSpace4,
                                  Text(
                                    "Start location: ${data.startPoint ?? ''}",
                                    style: AppStyles.caption12Semibold(),
                                  ),
                                  kVerticalSpace4,
                                  Text(
                                    "End location: ${data.endPoint ?? ''}",
                                    style: AppStyles.caption12Semibold(),
                                  ),
                                  kVerticalSpace4,
                                  Text(
                                    "Hike time: ${DateUtil.format(
                                      kSimpleDateDMY,
                                      data.startDate,
                                    )}",
                                    style: AppStyles.caption12Semibold(),
                                  )
                                ],
                              ),
                            ),
                            kHorizontalSpace4,
                            GestureDetector(
                              onTap: () async {
                                await showDialog<bool>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext ctx) => ConfirmDialog(
                                      title:
                                          "Are you sure you want to delete ${data.hikeName ?? ''}?",
                                      onConfirmTap: () {
                                        _joggingRepository
                                            .removeHiking(data.id)
                                            .then((value) {
                                          _getData();
                                        });
                                      }),
                                );
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                            kHorizontalSpace16
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _joggingRepository.listData?.length,
              ),
            ],
          ),
        );
      }),
    );
  }
}
