import 'package:flutter/material.dart';
import 'package:untitled1/models/reserv.dart';

class HotelData extends StatefulWidget {
  @override
  State<HotelData> createState() => _HotelDataState();
}

class _HotelDataState extends State<HotelData> {
  Map<String, dynamic>? _data;
  void initState() {
    super.initState();

    fetchReservationData().then(
      (data) {
        setState(() {
          _data = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Departure City'),
          Text('Destination City'),
          Text('Booking Dates'),
          Text('Number of Nights'),
          Text('Hotel Name'),
          Text('Room Name'),
          Text('Meal Plan'),
        ],
      ),
    );
  }
}
