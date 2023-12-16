import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';
import 'package:jogging_app/data/repository/observation_repository.dart';
import 'package:jogging_app/date_utils.dart';
import 'package:jogging_app/ui/add_observation/add_observation_screen.dart';

class ObservationDetailScreen extends StatefulWidget {
  final int id;

  const ObservationDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<ObservationDetailScreen> createState() =>
      _ObservationDetailScreenState();
}

class _ObservationDetailScreenState extends State<ObservationDetailScreen> {
  final ObservationRepository _observationRepository = ObservationRepository();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    _observationRepository.getObservationById(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = _observationRepository.observationDetail;
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
                "Obervation name: ",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  data?.observationName ?? "",
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
                "Obervation Time:",
                style: AppStyles.caption12Semibold(
                  color: Colors.black,
                ),
              ),
              kHorizontalSpace4,
              Expanded(
                child: Text(
                  DateUtil.format(
                    kHourMinute,
                    data?.observationTime ?? DateTime.now(),
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
                "Mô tả:",
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

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Obervation detail",
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
                    builder: (BuildContext context) => AddObservationScreen(
                      joggingId: data?.joggingId ?? -1,
                      observation: data,
                    ),
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
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (data?.images.length ?? 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                            File(
                              data?.images[index] ?? "",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
