import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jogging_app/common/common_textfield.dart';
import 'package:jogging_app/common/confirm_dialog.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';
import 'package:jogging_app/data/repository/hiking_repository.dart';
import 'package:jogging_app/date_utils.dart';
import 'package:jogging_app/ui/add_hiking/add_hiking_screen.dart';
import 'package:jogging_app/ui/add_observation/add_observation_screen.dart';

import '../observation_detail/observation_detail_screen.dart';

class HikingDetailScreen extends StatefulWidget {
  final int id;

  const HikingDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<HikingDetailScreen> createState() => _HikingDetailScreenState();
}

class _HikingDetailScreenState extends State<HikingDetailScreen> {
  final HikingRepository _joggingRepository = HikingRepository();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    _joggingRepository.getHikingById(widget.id);
    _joggingRepository.getListObservation(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = _joggingRepository.joggingDetail;
    final cardData = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "Hike name: ",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  data?.hikeName ?? "",
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "Start location:",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  data?.startPoint ?? "",
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "End location:",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  data?.endPoint ?? "",
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "StartDate:",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  DateUtil.format(
                    kSimpleDateDMY,
                    data?.startDate ?? DateTime.now(),
                  ),
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "Packing Availble:",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  data?.packingAvailble ?? false ? "Yes" : "No",
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "Length of hike (Km):",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  (data?.hikeLength ?? 0).toString(),
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "Level:",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  data?.level == 0
                      ? "Low"
                      : data?.level == 1
                          ? "Medium"
                          : "High",
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
          Row(
            children: [
              kHorizontalSpace16,
              Text(
                "Description:",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  data?.description ?? "",
                  style: AppStyles.caption12Semibold(
                    color: Colors.black,
                  ),
                ),
              ),
              kHorizontalSpace16,
            ],
          ),
          kVerticalSpace16,
        ],
      ),
    );

    final listObservation = ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _joggingRepository.listObservation?.length ?? 0,
        itemBuilder: (context, index) {
          final data = _joggingRepository.listObservation?[index];
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          ObservationDetailScreen(
                        id: data?.id ?? -1,
                      ),
                    ),
                  ).then((value) {
                    _getData();
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Obervation name: ${data?.observationName ?? ""}",
                              style: AppStyles.caption12Regular(
                                color: Colors.black,
                              ),
                            ),
                            kVerticalSpace4,
                            Text(
                              "Obervation time: ${DateUtil.format(
                                kHourMinute,
                                data?.observationTime ?? DateTime.now(),
                              )}",
                              style: AppStyles.caption12Regular(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        elevation: 10,
                        child: Image.file(
                          File(data?.images[0] ?? ""),
                          width: 40,
                          height: 50,
                          fit: BoxFit.fill,
                        ),
                      ),
                      if ((data?.images.length ?? 0) > 1)
                        Container(
                          width: 20,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "+${(data?.images.length ?? 0) - 1}",
                              style: AppStyles.caption12Regular(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      kHorizontalSpace16,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () async {
                    await showDialog<bool>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext ctx) => ConfirmDialog(
                          title:
                              "Are you sure you want to delete ${data?.observationName ?? ""}?",
                          onConfirmTap: () {
                            _joggingRepository
                                .removeObservation(data?.id ?? -1)
                                .then((value) {
                              _getData();
                            });
                          }),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
          );
        });
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Detail",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AddHikingScreen(editJog: data),
                  ),
                ).then((value) {
                  _getData();
                });
              },
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            kHorizontalSpace16,
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cardData,
            kVerticalSpace16,
            listObservation,
            kVerticalSpace16,
            _buildButton(),
          ],
        ),
      ),
    );
  }



  ///thêm quan sat

  Widget _buildButton() {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => AddObservationScreen(
              joggingId: _joggingRepository.joggingDetail?.id ?? -1,
            ),
          ),
        ).then((value) {
          _getData();
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.lightBlue,
        ),
        child: Center(
          child: Text(
            "Add obervation",
            style: AppStyles.button01(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
