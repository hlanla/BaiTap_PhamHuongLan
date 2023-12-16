import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jogging_app/common/choose_date_dialog.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';
import 'package:jogging_app/data/local/hiking.dart';
import 'package:jogging_app/data/repository/hiking_repository.dart';
import 'package:jogging_app/date_utils.dart';
import 'package:jogging_app/extensions/string_extension.dart';

import '../../common/common_textfield.dart';

class AddHikingScreen extends StatefulWidget {
  final Hiking? editJog;

  const AddHikingScreen({
    super.key,
    this.editJog,
  });

  @override
  State<AddHikingScreen> createState() => _AddHikingScreenState();
}

class _AddHikingScreenState extends State<AddHikingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startPositionController = TextEditingController();
  TextEditingController endPositionController = TextEditingController();
  TextEditingController jogDateController = TextEditingController();
  TextEditingController jogLengthController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final HikingRepository _joggingRepository = HikingRepository();

  DateTime jogDate = DateTime.now();
  String? jogDateError;
  bool packingAvaialbe = true;
  int level = 0;
  BuildContext? dialogContext;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    if (widget.editJog != null) {
      jogDate = widget.editJog?.startDate ?? DateTime.now();
      nameController.text = widget.editJog?.hikeName ?? "";
      startPositionController.text = widget.editJog?.startPoint ?? "";
      endPositionController.text = widget.editJog?.endPoint ?? "";
      jogDateController.text = DateUtil.format(
        kSimpleDateDMY,
        jogDate,
      );
      jogLengthController.text = (widget.editJog?.hikeLength).toString();
      noteController.text = widget.editJog?.description ?? '';
      packingAvaialbe = widget.editJog?.packingAvailble ?? true;
      level = widget.editJog?.level ?? 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.editJog != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit" : "Add Hike",
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
                title: "Name hike",
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
                title: "Start location",
                enableCheckValid: true,
                onValueChanged: (value) {
                  startPositionController.text = value;
                  setState(() {});
                },
                controller: startPositionController,
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
                title: "End location",
                enableCheckValid: true,
                controller: endPositionController,
                onValueChanged: (value) {
                  endPositionController.text = value;
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
              child: Stack(
                children: [
                  InputField(
                    title: "Start date",
                    readOnly: true,
                    controller: jogDateController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        jogDateChoose();
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ],
              ),
            ),
            kVerticalSpace16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Packing Avaialbe",
                  textAlign: TextAlign.left,
                  style:
                      AppStyles.caption12Semibold(color: kColorBackgroundBlur),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: const Text('Yes'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: packingAvaialbe,
                      onChanged: (bool? value) {
                        setState(() {
                          packingAvaialbe = value ?? false;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('No'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: packingAvaialbe,
                      onChanged: (bool? value) {
                        setState(() {
                          packingAvaialbe = value ?? false;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            kVerticalSpace16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputField(
                title: "Length of hike",
                enableCheckValid: true,
                controller: jogLengthController,
                keyboardType: TextInputType.number,
                suffixIcon: Text(
                  "Km",
                  style: AppStyles.caption12Semibold(
                    color: kColorBackgroundBlur,
                  ),
                ),
                onValueChanged: (value) {
                  jogLengthController.text = value;
                  setState(() {});
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                ],
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Level",
                  textAlign: TextAlign.left,
                  style:
                      AppStyles.caption12Semibold(color: kColorBackgroundBlur),
                ),
              ),
            ),
            _buildLevel(),
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

  Widget _buildLevel() {
    return Row(
      children: <Widget>[
        Radio<int>(
          value: 0,
          groupValue: level,
          onChanged: (int? value) {
            setState(() {
              level = value ?? 0;
            });
          },
        ),
        const Expanded(child: Text('Low', style: TextStyle(fontSize: 12))),
        kHorizontalSpace12,
        Radio<int>(
          value: 1,
          groupValue: level,
          onChanged: (int? value) {
            setState(() {
              level = value ?? 0;
            });
          },
        ),
        const Expanded(child: Text('Medium', style: TextStyle(fontSize: 12))),
        kHorizontalSpace12,
        Radio<int>(
          value: 2,
          groupValue: level,
          onChanged: (int? value) {
            setState(() {
              level = value ?? 0;
            });
          },
        ),
        const Expanded(child: Text('High', style: TextStyle(fontSize: 12))),
      ],
    );
  }

  Widget _buildButton() {
    final name = nameController.text;
    final startPosition = startPositionController.text;
    final endPosition = endPositionController.text;
    final jogDateText = jogDateController.text;
    final jogLength = jogLengthController.text;
    final note = noteController.text;
    final isValid = name.isNotNullAndNotEmpty &&
        startPosition.isNotNullAndNotEmpty &&
        endPosition.isNotNullAndNotEmpty &&
        jogDateText.isNotNullAndNotEmpty &&
        jogLength.isNotNullAndNotEmpty;
    return GestureDetector(
      onTap: () async {
        if (isValid) {
          final length = double.parse(jogLength);
          final Hiking hiking = Hiking(
            id: widget.editJog?.id ?? -1,
            hikeName:name,
            startPoint: startPosition,
            endPoint: endPosition,
            startDate: jogDate,
            packingAvailble: packingAvaialbe,
            hikeLength:length,
            level: level,
            description: note,
          );
          await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext ctx) => buildPopUp(context, hiking),
          ).then((value) {
            if (value ?? false) {
              Navigator.pop(context);
            }
          });
        } else {
          Fluttertoast.showToast(msg: "Please enter complete data");
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
            "Continue",
            style: AppStyles.button01(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  ///Chọnngày
  void jogDateChoose() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        dialogContext = context;
        return chooseDateDialog(
          initialDate: jogDate,
          onChanged: (value) {
            if (jogDate != value) {
              jogDate = value;
              jogDateController.text = DateUtil.format(
                kSimpleDateDMY,
                jogDate,
              );
              jogDateError = null;
              Navigator.pop(dialogContext!);
              setState(() {});
            }
          },
        );
      },
    );
  }

  ///Show popup confirm

  Widget buildPopUp(context, Hiking editJog) {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, false);
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
            ),
            Text(
              "Hike name: ${editJog.hikeName}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            Text(
              "Start Location: ${editJog.startPoint}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            Text(
              "End Location: ${editJog.endPoint}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            Text(
              "Start date: ${DateUtil.format(
                kSimpleDateDMY,
                editJog.startDate,
              )}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            Text(
              "Packing Availble: ${editJog.packingAvailble ? "Yes" : "No"}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            Text(
              "Length of hike: ${editJog.hikeLength.toString()}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            Text(
              "Level: ${editJog.level == 0 ? "Low" : editJog.level == 1 ? "Medium" : "High"}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            Text(
              "Description: ${editJog.description.toString()}",
              style: AppStyles.caption12Semibold(
                color: kColorBackgroundBlur,
              ),
            ),
            kVerticalSpace16,
            _buildButtonSave(context, editJog),
            kVerticalSpace30,
          ],
        ),
      ),
    );
  }


  ///Button Save
  Widget _buildButtonSave(context, Hiking editJog) {
    return GestureDetector(
      onTap: () async {
        await _joggingRepository.addEditHiking(editJog).then((value) {
          Navigator.pop(context, true);
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
            "Save",
            style: AppStyles.button01(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
