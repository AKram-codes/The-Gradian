import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng location) {
    setState(() {
      if (_pickupLocation == null) {
        _pickupLocation = location;
        _markers.add(Marker(
          markerId: MarkerId('pickup'),
          position: _pickupLocation!,
          infoWindow: InfoWindow(title: 'Pickup Location'),
        ));
      } else if (_dropoffLocation == null) {
        _dropoffLocation = location;
        _markers.add(Marker(
          markerId: MarkerId('dropoff'),
          position: _dropoffLocation!,
          infoWindow: InfoWindow(title: 'Drop-off Location'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Ride'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers,
              onTap: _onTap,
            ),
          ),
          if (_pickupLocation != null && _dropoffLocation != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking logic here
                },
                child: Text('Confirm Booking'),
              ),
            ),
        ],
      ),
    );
  }
}