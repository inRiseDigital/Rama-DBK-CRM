import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactMapComponent extends StatefulWidget {
  const ContactMapComponent({super.key});

  @override
  State<ContactMapComponent> createState() => _ContactMapComponentState();
}

class _ContactMapComponentState extends State<ContactMapComponent> {
  late GoogleMapController _controller;

  // Example coordinates - replace with your actual business location
  static const LatLng _center = LatLng(35.6812, 139.7671); // Tokyo coordinates

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('business_location'),
      position: _center,
      infoWindow: InfoWindow(
        title: 'Rama DBK',
        snippet: '123 Business Street, Tokyo',
      ),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          markers: _markers,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          mapToolbarEnabled: true,
        ),
      ),
    );
  }
}
