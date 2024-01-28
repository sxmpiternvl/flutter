import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/Screens/4paid.dart';
import 'package:untitled1/models/reserv.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  bool _isEmailInvalid = false;
  Map<String, dynamic>? _data;
  final List<bool> _expandedList = [false];
  final List<Widget> _touristForms = [];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> surnameControllers = [];
  List<TextEditingController> dobControllers = [];
  List<TextEditingController> citizenshipControllers = [];
  List<TextEditingController> passportNumberControllers = [];
  List<TextEditingController> passportValidityControllers = [];

  final Color _errorColor = const Color(0x15EB5757);
  Color nameContainerColor = const Color(0xFFF6F6F9);
  Color surnameContainerColor = const Color(0xFFF6F6F9);
  Color dobContainerColor = const Color(0xFFF6F6F9);
  Color citizenshipContainerColor = const Color(0xFFF6F6F9);
  Color passportNumberContainerColor = const Color(0xFFF6F6F9);
  Color passportValidityContainerColor = const Color(0xFFF6F6F9);

  @override
  void initState() {
    super.initState();
    _addTouristForm();
    fetchReservationData().then(
      (data) {
        setState(() {
          _data = data;
        });
      },
    );
    if (_controller.text.isEmpty) {
      _controller.text = '+7 (***) ***-**-**';
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        final value = _emailController.text;
        if (value == null || value.isEmpty) {
          setState(() {
            _isEmailInvalid = true;
          });
        } else if (!RegExp(r"""
^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$""").hasMatch(value)) {
          setState(() {
            _isEmailInvalid = true;
          });
        } else {
          setState(() {
            _isEmailInvalid = false;
          });
        }
      }
    });
  }

  void _addTouristForm() {
    setState(() {
      _expandedList.add(false);
      int touristIndex = _touristForms.length + 1;

      TextEditingController nameController = TextEditingController();
      TextEditingController surnameController = TextEditingController();
      TextEditingController dobController = TextEditingController();
      TextEditingController citizenshipController = TextEditingController();
      TextEditingController passportNumberController = TextEditingController();
      TextEditingController passportValidityController =
          TextEditingController();

      nameControllers.add(nameController);
      surnameControllers.add(surnameController);
      dobControllers.add(dobController);
      citizenshipControllers.add(citizenshipController);
      passportNumberControllers.add(passportNumberController);
      passportValidityControllers.add(passportValidityController);

      _touristForms.add(_buildTouristForm(touristIndex));
    });
  }

  Widget _buildTouristForm(int touristIndex) {
    TextEditingController nameController = nameControllers[touristIndex - 1];
    TextEditingController surnameController =
        surnameControllers[touristIndex - 1];
    TextEditingController dobController = dobControllers[touristIndex - 1];
    TextEditingController citizenshipController =
        citizenshipControllers[touristIndex - 1];
    TextEditingController passportNumberController =
        passportNumberControllers[touristIndex - 1];
    TextEditingController passportValidityController =
        passportValidityControllers[touristIndex - 1];

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFormField('Имя', nameController, nameContainerColor),
          _buildTextFormField(
              'Фамилия', surnameController, surnameContainerColor),
          _buildTextFormField(
              'Дата рождения', dobController, dobContainerColor),
          _buildTextFormField(
              'Гражданство', citizenshipController, citizenshipContainerColor),
          _buildTextFormField('Номер загранпаспорта', passportNumberController,
              passportNumberContainerColor),
          _buildTextFormField('Срок действия загранпаспорта',
              passportValidityController, passportValidityContainerColor),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(String labelText, TextEditingController controller,
      Color containerColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                nameContainerColor = const Color(0xFFF6F6F9);
                surnameContainerColor = const Color(0xFFF6F6F9);
                dobContainerColor = const Color(0xFFF6F6F9);
                citizenshipContainerColor = const Color(0xFFF6F6F9);
                passportNumberContainerColor = const Color(0xFFF6F6F9);
                passportValidityContainerColor = const Color(0xFFF6F6F9);
              });
            }
          },
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 189, 171, 183),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_touristForms.length);
    print(_expandedList.length);
    print(_touristForms[0]);
    List<String> numbers = [
      "",
      "Первый",
      "Второй",
      "Третий",
      "Четвертый",
      "Пятый",
      "Шестой",
      "Седьмой",
      "Восьмой",
      "Девятый",
    ];
    String res = "0";
    if (_data != null) {
      int result = _data!['tour_price'] +
          _data!['fuel_charge'] +
          _data!['service_charge'];
      res = result.toString();
    }
    return Scaffold(
      key: _formKey,
      backgroundColor: const Color.fromARGB(255, 246, 246, 249),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Бронирование",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _data == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 16, right: 16, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(51, 255, 168, 0)),
                            height: 29,
                            width: 149,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 255, 168, 0),
                                ),
                                Text(
                                  '${_data?['horating']} ${_data?['rating_name']}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 168, 0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '${_data?['hotel_name']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 16, right: 16, bottom: 16),
                          child: Text(
                            '${_data?['hotel_adress']}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 13, 114, 255),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: const Text(
                                'Вылет из ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 135, 150),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 203,
                                child: Text(
                                  '${_data!['departure']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: const Text(
                                'Страна/город ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 135, 150),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 203,
                                child: Text(
                                  '${_data!['arrival_country']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: const Text(
                                'Даты ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 135, 150),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 203,
                              child: Text(
                                '${_data!['tour_date_start']}-${_data!['tour_date_stop']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: const Text(
                                'Количество ночей ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 135, 150),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 203,
                              child: Text(
                                '${_data!['number_of_nights']} ночей',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: const Text(
                                'Название отеля ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 135, 150),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 203,
                              child: Text(
                                '${_data!['hotel_name']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: const Text(
                                'Тип номера ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 135, 150),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 203,
                                child: Text(
                                  '${_data!['room']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: const Text(
                                'Питание ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 135, 150),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 203,
                                child: Text(
                                  '${_data!['nutrition']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16),
                          child: Text(
                            'Информация о покупателе',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 16, right: 16, bottom: 8),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 246, 246, 249),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, top: 10),
                                  child: Text(
                                    'Номер телефона',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 189, 171, 183)),
                                  ),
                                ),
                                TextFormField(
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  controller: _controller,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(12),
                                    _PhoneNumberFormatter(),
                                  ],
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    isDense: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: _isEmailInvalid
                                  ? const Color(0x15EB5757)
                                  : const Color.fromARGB(255, 246, 246, 249),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, top: 10),
                                  child: Text(
                                    'Почта',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 189, 171, 183)),
                                  ),
                                ),
                                TextFormField(
                                  focusNode: _emailFocusNode,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    isDense: true,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r"""
^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$""").hasMatch(value)) {
                                      setState(() {
                                        _isEmailInvalid = true;
                                      });
                                      return 'Please enter a valid email';
                                    }
                                    setState(() {
                                      _isEmailInvalid = false;
                                    });
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 130, 135, 150)),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        ExpansionPanelList.radio(
                          materialGapSize: 8,
                          expandIconColor:
                              const Color.fromARGB(255, 13, 114, 255),
                          elevation: 0.0,
                          expansionCallback: (panelIndex, isExpanded) {
                            setState(() {
                              _expandedList[panelIndex] = !isExpanded;
                            });
                          },
                          children: _touristForms
                              .asMap()
                              .entries
                              .map<ExpansionPanelRadio>((entry) {
                            final index = entry.key;
                            final touristForm = entry.value;
                            return ExpansionPanelRadio(
                              value: index,
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(
                                    '${numbers[index + 1]} турист',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                    ),
                                  ),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: touristForm,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Добавить туриста',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: _addTouristForm,
                            icon: SvgPicture.string(
                                '''<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect x="32" width="32" height="32" rx="6" transform="rotate(90 32 0)" fill="#0D72FF"/>
<path d="M11 16H21" stroke="white" stroke-width="2" stroke-linecap="round"/>
<path d="M16 21L16 11" stroke="white" stroke-width="2" stroke-linecap="round"/>
</svg>

'''),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Тур ',
                                  style: TextStyle(
                                      color: Color(0xFF828796),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${'${_data!['tour_price']}'.substring(0, 3)} ${'${_data!['tour_price']}'.substring(3, 6)} ₽',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Топливный сбор ',
                                  style: TextStyle(
                                      color: Color(0xFF828796),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${'${_data!['fuel_charge']}'.substring(0, 1)} ${'${_data!['fuel_charge']}'.substring(1, 4)} ₽',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Сервисный сбор ',
                                  style: TextStyle(
                                      color: Color(0xFF828796),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${'${_data!['service_charge']}'.substring(0, 1)} ${'${_data!['service_charge']}'.substring(1, 4)} ₽',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'К оплате ',
                                  style: TextStyle(
                                      color: Color(0xFF828796),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${res.substring(0, 3)} ${res.substring(3, 6)} ₽',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0D72FF)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            _navigateToPaidScreen(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 13, 114, 255)),
                              height: 48,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                "Оплатить ${res.substring(0, 3)} ${res.substring(3, 6)} ₽",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _colorEmptyFieldsForAllTourists() {
    setState(() {
      for (int i = 0; i < _touristForms.length; i++) {
        TextEditingController nameController = nameControllers[i];
        TextEditingController surnameController = surnameControllers[i];
        TextEditingController dobController = dobControllers[i];
        TextEditingController citizenshipController = citizenshipControllers[i];
        TextEditingController passportNumberController =
            passportNumberControllers[i];
        TextEditingController passportValidityController =
            passportValidityControllers[i];

        if (nameController.text.isEmpty) {
          nameContainerColor = _errorColor;
        }
        if (surnameController.text.isEmpty) {
          surnameContainerColor = _errorColor;
        }
        if (dobController.text.isEmpty) {
          dobContainerColor = _errorColor;
        }
        if (citizenshipController.text.isEmpty) {
          citizenshipContainerColor = _errorColor;
        }
        if (passportNumberController.text.isEmpty) {
          passportNumberContainerColor = _errorColor;
        }
        if (passportValidityController.text.isEmpty) {
          passportValidityContainerColor = _errorColor;
        }
        _touristForms[i] = _buildTouristForm(i + 1);
      }
    });
  }

  void _navigateToPaidScreen(BuildContext context) {
    bool allFieldsFilled = true;
    for (int i = 0; i < _touristForms.length; i++) {
      TextEditingController nameController = nameControllers[i];
      TextEditingController surnameController = surnameControllers[i];
      TextEditingController dobController = dobControllers[i];
      TextEditingController citizenshipController = citizenshipControllers[i];
      TextEditingController passportNumberController =
          passportNumberControllers[i];
      TextEditingController passportValidityController =
          passportValidityControllers[i];

      if (nameController.text.isEmpty ||
          surnameController.text.isEmpty ||
          dobController.text.isEmpty ||
          citizenshipController.text.isEmpty ||
          passportNumberController.text.isEmpty ||
          passportValidityController.text.isEmpty) {
        allFieldsFilled = false;
        break;
      }
    }

    if (allFieldsFilled) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaidScreen(),
        ),
      );
    } else {
      _colorEmptyFieldsForAllTourists();
    }
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.startsWith('7')) {
      newText = newText.substring(1);
    }

    const String maskedText = '+7 (***) ***-**-**';

    String formattedText = '';
    int maskIndex = 0;

    for (int i = 0; i < maskedText.length; i++) {
      final maskChar = maskedText[i];
      if (maskChar == '*' && maskIndex < newText.length) {
        formattedText += newText[maskIndex];
        maskIndex++;
      } else {
        formattedText += maskChar;
      }
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
