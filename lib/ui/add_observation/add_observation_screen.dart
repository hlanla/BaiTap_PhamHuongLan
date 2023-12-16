import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jogging_app/common/common_textfield.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';
import 'package:jogging_app/data/local/observation.dart';
import 'package:jogging_app/data/repository/observation_repository.dart';
import 'package:jogging_app/date_utils.dart';
import 'package:jogging_app/extensions/string_extension.dart';
import 'package:jogging_app/utils.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class AddObservationScreen extends StatefulWidget {
  final int joggingId;
  final Observation? observation;

  const AddObservationScreen({
    super.key,
    required this.joggingId,
    this.observation,
  });

  @override
  State<AddObservationScreen> createState() => _AddObservationScreenState();
}

class _AddObservationScreenState extends State<AddObservationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController observationTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime observationTime = DateTime.now();
  List<String> listImages = [];

  final ObservationRepository _observationRepository = ObservationRepository();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    if (widget.observation != null) {
      nameController.text = widget.observation?.observationName ?? "";
      observationTime = widget.observation?.observationTime ?? DateTime.now();
      noteController.text = widget.observation?.description ?? "";
      listImages=widget.observation?.images ?? [];
    }
    observationTimeController.text = DateUtil.format(
      kHourMinute,
      observationTime,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.observation != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit" : "Add Obervation",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kVerticalSpace16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputField(
                title: "Obervation name",
                enableCheckValid: true,
                controller: nameController,
                onValueChanged: (value) {
                  nameController.text = value;
                  setState(() {});
                },
                onValidate: (value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be empty";

                  } else {
                    return null;
                  }
                },
              ),
            ),
            kVerticalSpace16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputField(
                title: "Obervation Time",
                readOnly: true,
                controller: observationTimeController,
                suffixIcon: IconButton(
                  onPressed: () {
                    selectTime();
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            kVerticalSpace16,
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (listImages.length) + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == (listImages.length)) {
                  return GestureDetector(
                    onTap: () {
                      Utils.showOptionPickImage(
                        context,
                        (file) async {
                          final path = await Utils.saveLocalImage(file);
                          listImages.add(path);
                          setState(() {});
                        },
                      );
                    },
                    child: DottedBorder(
                      padding: const EdgeInsets.only(bottom: 8),
                      borderType: BorderType.RRect,
                      color: Colors.lightBlue,
                      dashPattern: [6, 6],
                      radius: const Radius.circular(40),
                      strokeWidth: 1,
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  );
                }
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
                              listImages[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          listImages.remove(listImages[index]);
                          setState(() {});
                        },
                        child: Container(
                          height: 30,
                          width: 30,
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
              },
            ),
            kVerticalSpace16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputField(
                height: 120,
                title: "Description",
                minLines: 20,
                controller: noteController,
                onValueChanged: (value) {
                  noteController.text = value;
                  setState(() {});
                },
              ),
            ),
            kVerticalSpace16,
            _buildButton(),
            kVerticalSpace30,
          ],
        ),
      ),
    );
  }

  ///Nút thêm quan sát

  Widget _buildButton() {
    final name = nameController.text;
    final jogDateText = observationTimeController.text;
    final note = noteController.text;
    final isValid = name.isNotNullAndNotEmpty &&
        jogDateText.isNotNullAndNotEmpty &&
        listImages.isNotEmpty;
    return GestureDetector(
      onTap: () async {
        Observation observation = Observation(
          id: widget.observation?.id ?? -1,
          observationName: name,
          description: note,
          observationTime: observationTime,
          images: listImages,
          joggingId: widget.joggingId,
        );
        if (isValid) {
          await _observationRepository
              .addOrEditObservation(observation)
              .then((value) {
            Navigator.pop(context);
          });
        } else {
          {
            Fluttertoast.showToast(msg: "Please enter complete data");
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: isValid ? Colors.lightBlue : Colors.grey,
        ),
        child: Center(
          child: Text(
            "Save",
            style: AppStyles.button01(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void selectTime() async {
    await showDialog<DateTime?>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TimePickerSpinner(
                  locale: const Locale('en', ''),
                  time: observationTime,
                  is24HourMode: true,
                  isShowSeconds: false,
                  itemHeight: 40,
                  normalTextStyle: const TextStyle(
                    fontSize: 24,
                  ),
                  highlightedTextStyle:
                      const TextStyle(fontSize: 24, color: Colors.blue),
                  isForce2Digits: true,
                  onTimeChange: (value) {
                    if (observationTime != value) {
                      observationTime = value;
                      observationTimeController.text = DateUtil.format(
                        kHourMinute,
                        observationTime,
                      );
                      setState(() {});
                    }
                  },
                ),
                kVerticalSpace16,
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
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
                        "OK",
                        style: AppStyles.button01(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
