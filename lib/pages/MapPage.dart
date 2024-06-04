import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_car_parking/config/colors.dart';
import 'package:smart_car_parking/pages/history_page/history_page.dart';
import 'package:smart_car_parking/pages/homepage/homepage.dart';
import 'package:smart_car_parking/pages/payment_page/payment_page.dart'; // Ensure this import is correct

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> controller = Completer();
    const LatLng center = LatLng(2.9852, 101.7600); // Center near UNITEN Bangi

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/white_logo.png",
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 20),
            const Text(
              "SMART PARKING",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/about-us");
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: blueColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payment'),
              onTap: () {
                Get.to(PaymentPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {
                Get.to(HistoryPage());
              },
            ),
            // Add more menu items if needed
          ],
        ),
      ),
      body: GoogleMap(
        buildingsEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: center,
          zoom: 18.0,
        ),
        markers: {
          Marker(
            visible: true,
            onTap: () {
              Get.to(HomePage());
            },
            markerId: const MarkerId('parking_1'),
            position: const LatLng(
                2.9855, 101.7603), // Example coordinates near UNITEN Bangi
          ),
          Marker(
            visible: true,
            onTap: () {
              Get.to(HomePage());
            },
            markerId: const MarkerId('parking_2'),
            position: const LatLng(
                2.9850, 101.7598), // Example coordinates near UNITEN Bangi
          ),
          Marker(
            visible: true,
            onTap: () {
              Get.to(HomePage());
            },
            markerId: const MarkerId('parking_3'),
            position: const LatLng(
                2.9847, 101.7595), // Example coordinates near UNITEN Bangi
          ),
          Marker(
            visible: true,
            onTap: () {
              Get.to(HomePage());
            },
            markerId: const MarkerId('parking_4'),
            position: const LatLng(
                2.9853, 101.7597), // Example coordinates near UNITEN Bangi
          ),
          Marker(
            visible: true,
            onTap: () {
              Get.to(HomePage());
            },
            markerId: const MarkerId('parking_5'),
            position: const LatLng(
                2.9851, 101.7602), // Example coordinates near UNITEN Bangi
          ),
        },
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }
}
