import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/Screens/rooms.dart';
import 'package:untitled1/models/hotels.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  _HotelPageState createState() {
    return _HotelPageState();
  }
}

class _HotelPageState extends State<HotelPage> {
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
      backgroundColor: const Color.fromARGB(255, 246, 246, 249),
      body: hotelData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: Center(
                                child: Text(
                                  'Отель',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                      itemCount:
                                          hotelData!['image_urls']?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              hotelData!['image_urls']![index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      bottom: 8.0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          decoration: (BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white)),
                                          height: 17,
                                          width: 89,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              hotelData!['image_urls']
                                                      ?.length ??
                                                  0,
                                              (index) => buildIndicator(index),
                                            ),
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
                                    color:
                                        const Color.fromARGB(51, 255, 168, 0)),
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
                                      '${hotelData?['rating']} ${hotelData?['rating_name']}',
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 255, 168, 0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: Text(
                                    '${hotelData!['name'] ?? 'Нет данных'}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500)),
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
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 16),
                              child: Row(
                                children: [
                                  Text(
                                    '${'от ${hotelData!['minimal_price']!}'.substring(0, 6)} ${'от ${hotelData!['minimal_price']!}₽'.substring(6, 9)} ₽',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${hotelData!['price_for_it']}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 130, 135, 150)),
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
                    ////
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                'Об отеле',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Wrap(
                                children: List.generate(
                                  hotelData!['about_the_hotel']
                                              ?['peculiarities']
                                          .length ??
                                      0,
                                  (index) => Container(
                                    color:
                                        const Color.fromARGB(1, 130, 135, 150),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${hotelData!['about_the_hotel']?['peculiarities'][index] ?? 'Нет данных'}',
                                          style: const TextStyle(
                                            color: Color(0xFF828796),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 251, 251, 252),
                                ),
                                height: 184,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround, // Устанавливаем распределение по вертикали
                                  children: [
                                    buildRow(
                                        'Удобства', 'Самое необходимое', '''
  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M9 22H15C20 22 22 20 22 15V9C22 4 20 2 15 2H9C4 2 2 4 2 9V15C2 20 4 22 9 22Z" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
    <path d="M15.5 9.75C16.3284 9.75 17 9.07843 17 8.25C17 7.42157 16.3284 6.75 15.5 6.75C14.6716 6.75 14 7.42157 14 8.25C14 9.07843 14.6716 9.75 15.5 9.75Z" stroke="black" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/>
    <path d="M8.5 9.75C9.32843 9.75 10 9.07843 10 8.25C10 7.42157 9.32843 6.75 8.5 6.75C7.67157 6.75 7 7.42157 7 8.25C7 9.07843 7.67157 9.75 8.5 9.75Z" stroke="black" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/>
    <path d="M8.4 13.3H15.6C16.1 13.3 16.5 13.7 16.5 14.2C16.5 16.69 14.49 18.7 12 18.7C9.51 18.7 7.5 16.69 7.5 14.2C7.5 13.7 7.9 13.3 8.4 13.3Z" stroke="black" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>
'''),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 56.0, right: 24),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(38, 130, 135, 150),
                                        height: 5,
                                        thickness: 2,
                                      ),
                                    ),
                                    buildRow(
                                        'Что включено', 'Самое необходимое', '''
 <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M9 22H15C20 22 22 20 22 15V9C22 4 20 2 15 2H9C4 2 2 4 2 9V15C2 20 4 22 9 22Z" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M7.75 12L10.58 14.83L16.25 9.16998" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

'''),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 56.0, right: 24),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(38, 130, 135, 150),
                                        height: 5,
                                        thickness: 2,
                                      ),
                                    ),
                                    buildRow('Что не включено',
                                        'Самое необходимое', '''
  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M9.17004 14.83L14.83 9.16998" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M14.83 14.83L9.17004 9.16998" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M9 22H15C20 22 22 20 22 15V9C22 4 20 2 15 2H9C4 2 2 4 2 9V15C2 20 4 22 9 22Z" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

'''),
                                  ],
                                ),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoomsPage(
                                          hotelName: "${hotelData?['name']}")));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 13, 114, 255)),
                                height: 48,
                                width: double.infinity,
                                child: const Center(
                                    child: Text(
                                  "К выбору номера",
                                  style: TextStyle(
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
        color: _currentPage == index ? Colors.black : Colors.grey,
      ),
    );
  }
}

Widget buildRow(String title, String subtitle, String svgString) {
  return Container(
    height: 38,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SvgPicture.string(svgString),
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
        const Padding(
          padding: EdgeInsets.only(right: 23.0),
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    ),
  );
}
