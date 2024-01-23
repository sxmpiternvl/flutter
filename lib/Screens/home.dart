import 'package:flutter/material.dart';
import 'package:untitled1/models/hotels.dart';

class MyHotelWidget extends StatefulWidget {
  const MyHotelWidget({super.key});

  @override
  _MyHotelWidgetState createState() => _MyHotelWidgetState();
}

class _MyHotelWidgetState extends State<MyHotelWidget> {
  Map<String, dynamic>? hotelData;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchHotelData().then((data) {
      setState(() {
        hotelData = data;
      });
    });
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: hotelData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 63), // Расстояние от верха экрана
                    const Center(
                      child: Text(
                        'Отель',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 257.0,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: hotelData!['image_urls']?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      hotelData!['image_urls']![index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 10.0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 30.0,
                                color: Colors.white.withOpacity(0.7),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    hotelData!['image_urls']?.length ?? 0,
                                    (index) => buildIndicator(index),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(51, 255, 168, 0)),
                        height: 29,
                        width: 149,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 255, 168, 0),
                            ),
                            Text(
                              "5 Превосходно",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 168, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Text('${hotelData!['name'] ?? 'Нет данных'}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                          child: Text(
                        '${hotelData!['adress'] ?? 'Нет данных'}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 13, 114, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Row(
                        children: [
                          Text(
                            'от 134 268 ₽',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'За тур с перелётом',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 130, 135, 150)),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Об отеле',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: const Color(0xFFFBFBFC),
                            // color: const Color.fromARGB(255, 251, 251, 252),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Text(
                                '${hotelData!['about_the_hotel']?['peculiarities'][0] ?? 'Нет данных'}',
                                style: const TextStyle(
                                  color: Color(0xFF828796),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // color: ,
                                color: const Color.fromARGB(1, 130, 135, 150),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Text(
                                    '${hotelData!['about_the_hotel']?['peculiarities'][1] ?? 'Нет данных'}',
                                    style: const TextStyle(
                                      color: Color(0xFF828796),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // color: ,
                                color: const Color.fromARGB(1, 130, 135, 150),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Text(
                                    '${hotelData!['about_the_hotel']?['peculiarities'][2] ?? 'Нет данных'}',
                                    style: const TextStyle(
                                      color: Color(0xFF828796),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // color: ,
                            color: const Color.fromARGB(1, 130, 135, 150),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Text(
                                '${hotelData!['about_the_hotel']?['peculiarities'][3] ?? 'Нет данных'}',
                                style: const TextStyle(
                                  color: Color(0xFF828796),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        '${hotelData!['about_the_hotel']?['description'] ?? 'Нет данных'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 251, 251, 252),
                      ),
                      height: 184,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceAround, // Устанавливаем распределение по вертикали
                        children: [
                          buildRow('Удобства', 'Самое необходимое',
                              Icons.insert_emoticon_outlined),
                          buildRow('Что включено', 'Самое необходимое',
                              Icons.check_circle_outline),
                          buildRow('Что не включено', 'Самое необходимое',
                              Icons.close_rounded),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 13, 114, 255)),
                              height: 48,
                              width: double.infinity,
                              child: const Center(
                                  child: Text(
                                "К ВЫБОРУ НОМЕРА",
                                style: TextStyle(color: Colors.white),
                              ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

Widget buildRow(String title, String subtitle, IconData iconData) {
  return Container(
    height: 38,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Icon(iconData),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 44, 48, 53)),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 130, 135, 150)),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios_rounded),
      ],
    ),
  );
}
