import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/models/hoteldata.dart';
import 'package:untitled1/models/reserv.dart';
import 'package:untitled1/models/numberToWord.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  List<bool> _touristFormValidity = [];

  List<Color> _textFieldBackgroundColors = [];
  final FocusNode _emailFocusNode = FocusNode();
  bool _isEmailInvalid = false;
  Map<String, dynamic>? _data;
  final List<bool> _expandedList = [true];
  final List<Widget> _touristForms = [];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addTouristForm();
    for (int i = 0; i < _touristForms.length; i++) {
      _touristFormValidity.add(true); // По умолчанию форма валидна
      _textFieldBackgroundColors
          .add(Colors.transparent); // По умолчанию фон прозрачный
    }
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
      _expandedList.add(false); // Add new panel in collapsed state
      int touristIndex = _touristForms.length + 1;
      _touristForms.add(_buildTouristForm(touristIndex));
    });
  }

  Widget _buildTouristForm(int touristIndex) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Фамилия'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Дата рождения'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Гражданство'),
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Номер загранпаспорта'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Срок действия загранпаспорта'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star),
                            Text(
                                '${_data?['horating']} ${_data?['rating_name']}')
                          ],
                        ),
                        Text(
                          '${_data?['hotel_name']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        Text('${_data?['hotel_adress']}')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${_data!['departure']}'), //vilet iz
                        Text('${_data!['arrival_country']}'), // strana gorod
                        Text('${_data!['tour_date_start']}'
                            '-'
                            '${_data!['tour_date_stop']}'), //dati
                        Text(
                            '${_data!['number_of_nights']}Number of Nights'), //kolvo nochei

                        Text('${_data!['hotel_name']}'),
                        Text('${_data!['room']}'),
                        Text('${_data!['nutrition']}'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Информация о покупателе',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 246, 246, 249)),
                          child: TextFormField(
                            controller: _controller,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(12),
                              _PhoneNumberFormatter(),
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: '+7 (***) ***-**-**',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: _isEmailInvalid
                                ? const Color(0x15EB5757)
                                : const Color.fromARGB(255, 246, 246, 249),
                          ),
                          child: TextFormField(
                            focusNode: _emailFocusNode,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
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
                        ),
                        const Text(
                          'Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExpansionPanelList.radio(
                      elevation: 0.0,
                      expansionCallback: (panelIndex, isExpanded) {
                        setState(() {
                          panelIndex = isExpanded ? panelIndex : panelIndex;
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
                              title: Text('${numbers[index + 1]} турист'),
                            );
                          },
                          body: touristForm,
                        );
                      }).toList(),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Добавить туриста',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          onPressed: _addTouristForm,
                          icon: SvgPicture.string(
                              '''<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect x="32" width="32" height="32" rx="6" transform="rotate(90 32 0)" fill="#0D72FF"/>
<path d="M11 16H21" stroke="white" stroke-width="2" stroke-linecap="round"/>
<path d="M16 21L16 11" stroke="white" stroke-width="2" stroke-linecap="round"/>
</svg>

'''),
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
                      children: [
                        Row(
                          children: [
                            const Text('Тур '),
                            Text(
                                '${'${_data!['tour_price']}'.substring(0, 3)} ${'${_data!['tour_price']}'.substring(3, 6)}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('FUel '),
                            Text(
                                '${'${_data!['fuel_charge']}'.substring(0, 1)} ${'${_data!['fuel_charge']}'.substring(1, 4)}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Тур '),
                            Text(
                                '${'${_data!['service_charge']}'.substring(0, 1)} ${'${_data!['service_charge']}'.substring(1, 4)}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('К оплате '),
                            Text(
                                '${res.substring(0, 3)} ${res.substring(3, 6)}'),
                          ],
                        ),
                      ],
                    ),
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
                          onTap: () {},
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
//
