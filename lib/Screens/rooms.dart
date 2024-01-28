import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/Screens/home.dart';
import 'package:untitled1/Screens/reservationPage.dart';
import '../models/rooms.dart';

class RoomsPage extends StatefulWidget {
  late String hotelName;

  RoomsPage({Key? key, required this.hotelName}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  int _currentPage = 0;

  Future<Map<String, dynamic>>? _data;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _data = fetchRoomsData();
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => HotelPage()));
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
        title: Text(
          widget.hotelName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else {
            var rooms = snapshot.data?['rooms'] ?? [];

            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var room in rooms)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 257,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 16,
                                    right: 16,
                                    bottom: 8,
                                  ),
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: room['image_urls'].length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          room['image_urls'][index],
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                    onPageChanged: (int index) {
                                      setState(() {
                                        _currentPage = index;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15.0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    decoration: (BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white)),
                                    height: 17,
                                    width: 89,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        room['image_urls']?.length ?? 0,
                                        (index) => buildIndicator(index),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${room['name']}',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                Wrap(
                                  children: (room['peculiarities']
                                          as List<dynamic>)
                                      .map<Widget>(
                                        (peculiarity) => Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                            top: 16,
                                          ),
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color.fromARGB(
                                                  10, 130, 135, 150),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 10),
                                              child: Text(
                                                peculiarity.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xFF828796),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16, right: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromARGB(
                                          26, 13, 114, 255),
                                    ),
                                    width: 200,
                                    height: 29,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 6.0),
                                            child: Text(
                                              'Подробнее о номере  ',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 13, 114, 255),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SvgPicture.string(
                                              '''<svg width="8" height="15" viewBox="0 0 8 15" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M1 1.5L7 7.5L1 13.5" stroke="#0D72FF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${'${room['price']}'.substring(0, 3)} ${'${room['price']} '.substring(3, 6)} ₽ ',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Text(
                                      'За 7 ночей с перелетом',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 130, 135, 150),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReservationPage()));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromARGB(
                                            255, 13, 114, 255)),
                                    height: 48,
                                    width: double.infinity,
                                    child: const Center(
                                        child: Text(
                                      "Выбрать номер",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }
        },
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
