import 'package:flutter/material.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:untitled1/util/validation_utils.dart';

class TouristInfo {
  String name = '';
  String family = '';
  String birthday = '';
  String citizenship = '';
  String passportNumber = '';
  String passportValidity = '';
// Add other fields for citizenship, passport, etc.
}

class TouristsForm extends StatefulWidget {
  @override
  _TouristsFormState createState() => _TouristsFormState();
}

class _TouristsFormState extends State<TouristsForm> {
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _birthdayTextController = TextEditingController();
  final TextEditingController _citizenshipTextController =
      TextEditingController();

  final TextEditingController _passportNumberTextController =
      TextEditingController();

  final TextEditingController _passportValidityTextController =
      TextEditingController();
  List<TouristInfo> tourists = [];
  final List<String> suffixes = [
    "Второй",
    "Третий",
    "Четвертый",
    "Пятый",
    "Fourthly",
    "Fifthly",
    "Шестой",
    "Седьмой",
    "Восьмой",
    "Девятый",
    "Десятый"
  ];

  bool isTapped = false;
  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var birthdayMaskFormatter = MaskTextInputFormatter(
    mask: '##/##/####', // Customize the mask as needed
    filter: {"#": RegExp(r'[0-9]')},
  );

  void addTourist() {
    setState(() {
      tourists.add(TouristInfo());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
          color: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Добавить туриста',
                      style: TextStyle(
                        fontSize: 22,
                        height: 26.4 / 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: addTourist,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xff0D72FF).withOpacity(.10),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xff0D72FF),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // List of tourists

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tourists.length,
          itemBuilder: (context, index) {
            final touristIndex = index;

            // Determine the suffix based on the index or use "th" for indices >= 10
            final touristSuffix =
                touristIndex < suffixes.length ? suffixes[touristIndex] : "th";

            return Card(
              color: Colors.white,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    color: Colors.white,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$touristSuffix туриста ',
                          style: const TextStyle(
                            fontSize: 22,
                            height: 26.4 / 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffF6F6F9)),
                          child: TextFormField(
                            controller: _NameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xffA9ABB7),
                                fontWeight: FontWeight.w400,
                                height: 14.4 / 12,
                                letterSpacing: 0.12,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              labelText: 'Имя',
                              hintText: '',
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (value) {
                              final validationError =
                                  ValidationUtils.validateName(value);
                            },
                            validator: (value) =>
                                ValidationUtils.validateName(value!),
                          ),
                        ),

                        const SizedBox(height: 8),
                        // Фамилия
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffF6F6F9)),
                          child: TextFormField(
                            controller: _familyController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xffA9ABB7),
                                fontWeight: FontWeight.w400,
                                height: 14.4 / 12,
                                letterSpacing: 0.12,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              labelText: 'Фамилия',
                              hintText: '',
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (value) {
                              final validationError =
                                  ValidationUtils.validateFamily(value);
                            },
                            validator: (value) =>
                                ValidationUtils.validateFamily(value!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Дата рождения
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffF6F6F9)),
                          child: TextFormField(
                            controller: _birthdayTextController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [birthdayMaskFormatter],
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                color: Color(0xffA9ABB7),
                                fontWeight: FontWeight.w400,
                                height: 14.4 / 12,
                                letterSpacing: 0.12,
                              ),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              labelText: 'Дата рождения',
                              // hintText: '',
                              hintText: isTapped ? 'DD/MM/YYYY' : '',

                              contentPadding: const EdgeInsets.all(10),
                            ),
                            validator: (value) =>
                                ValidationUtils.validateBirthday(value!),
                            onChanged: (value) {
                              final validationError =
                                  ValidationUtils.validateBirthday(value);
                            },
                            onTap: () {
                              if (!isTapped) {
                                _birthdayTextController.text = '';
                                isTapped = true;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Гражданство
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffF6F6F9)),
                          child: TextFormField(
                            controller: _citizenshipTextController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xffA9ABB7),
                                fontWeight: FontWeight.w400,
                                height: 14.4 / 12,
                                letterSpacing: 0.12,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              labelText: 'Гражданство',
                              hintText: '',
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (value) {
                              final validationError =
                                  ValidationUtils.validateCitizenship(value);
                            },
                            validator: (value) =>
                                ValidationUtils.validateCitizenship(value!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Номер загранпаспорта
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffF6F6F9)),
                          child: TextFormField(
                            controller: _passportNumberTextController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xffA9ABB7),
                                fontWeight: FontWeight.w400,
                                height: 14.4 / 12,
                                letterSpacing: 0.12,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              labelText: 'Номер загранпаспорта',
                              hintText: '',
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (value) {
                              final validationError =
                                  ValidationUtils.validatePassportNumber(value);
                            },
                            validator: (value) =>
                                ValidationUtils.validatePassportNumber(value!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Срок действия загранпаспорта
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffF6F6F9)),
                          child: TextFormField(
                            controller: _passportValidityTextController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xffA9ABB7),
                                fontWeight: FontWeight.w400,
                                height: 14.4 / 12,
                                letterSpacing: 0.12,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              labelText: 'Срок действия загранпаспорта',
                              hintText: '',
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (value) {
                              final validationError =
                                  ValidationUtils.validatePassportValidity(
                                      value);
                            },
                            validator: (value) =>
                                ValidationUtils.validatePassportValidity(
                                    value!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Add more TextFormField widgets for other tourist information
                      ],
                    ),
                  ),

                  // Divider()
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
