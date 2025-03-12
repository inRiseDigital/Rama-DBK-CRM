import 'dart:convert';
import 'package:http/http.dart' as http;
// Import with correct path
import '../models/vehicle_model.dart';

class ApiService {
  // Base URL for the API - make sure this matches your Django server
  static const String baseUrl = 'http://127.0.0.1:8000';
  
  // Fetch all vehicles with optional filtering
  static Future<Map<String, dynamic>> fetchVehicles({
    Map<String, String?>? filters,
    int page = 1,
  }) async {
    // Build query parameters including pagination
    final queryParams = {'page': page.toString()};
    
    // Map filter keys from frontend to backend API parameters
    final Map<String, String> filterKeyMap = {
      'brand': 'brand',
      'model': 'model',
      'steering': 'steering',
      'yearFrom': 'yearFrom',
      'yearTo': 'yearTo',
      'type': 'type',
      'bodyType': 'bodyType',
      'engine': 'engine',
      'transmission': 'transmission',
      'drive': 'drive',
      'fuel': 'fuel',
      'country': 'country',
      'stockNumber': 'stockNumber',
      'search': 'search',
    };
    
    // Add filters to query parameters if they exist
    if (filters != null) {
      filters.forEach((key, value) {
        if (value != null && value.isNotEmpty) {
          final apiKey = filterKeyMap[key] ?? key;
          queryParams[apiKey] = value;
        }
      });
    }
    
    // Construct the URI with query parameters
    final uri = Uri.parse('$baseUrl/vehicles/').replace(queryParameters: queryParams);
    
    // Debug output
    print('Fetching vehicles with URL: $uri');
    
    try {
      final response = await http.get(uri);
      
      print('API Response Status Code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        // Parse the results into Vehicle objects
        final List<dynamic> results = data['results'];
        final vehicles = results.map((vehicle) => Vehicle.fromJson(vehicle)).toList();
        
        return {
          'vehicles': vehicles,
          'count': data['count'] ?? 0,
          'next': data['next'],
          'previous': data['previous'],
        };
      } else {
        print('API Error Response: ${response.body}');
        // For testing/development, create mock data if the API fails
        return _getMockVehicleData();
      }
    } catch (e) {
      print('API Connection Error: $e');
      // Return mock data during development when API is not available
      return _getMockVehicleData();
    }
  }
  
  // Fetch a single vehicle by ID
  static Future<Vehicle> fetchVehicleById(int id) async {
    final uri = Uri.parse('$baseUrl/vehicle/$id/');
    
    try {
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        return Vehicle.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load vehicle: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to API: $e');
    }
  }
  
  // Mock data for development when API is not available
  static Map<String, dynamic> _getMockVehicleData() {
    final currentDate = DateTime.now().toIso8601String();
    final List<Map<String, dynamic>> mockVehicles = [
      {
        'id': 1,
        'stock_no': 'SN-001',
        'make': 'Toyota',
        'model': 'Corolla',
        'reg_year': '2020',
        'type': 'Sedan',
        'body_type': 'Sedan',
        'grade': 'LE',
        'chassis': 'ABC123456',
        'mileage': 25000,
        'engine_capacity': 1800,
        'transmission': 'Automatic',
        'fuel': 'Petrol',
        'steering': 'Left',
        'model_no': 'CRL-20',
        'drive': '2WD',
        'seats': 5,
        'doors': 4,
        'engine_model': '2ZR-FE',
        'color': 'Silver',
        'location': 'Japan',
        'm3_size': 12.5,
        'length_cm': 464,
        'width_cm': 178,
        'height_cm': 145,
        'created_at': currentDate,
        'updated_at': currentDate,
        'image_url': 'https://via.placeholder.com/640x480.png?text=Toyota+Corolla',
      },
      {
        'id': 2,
        'stock_no': 'SN-002',
        'make': 'Honda',
        'model': 'Civic',
        'reg_year': '2021',
        'type': 'Sedan',
        'body_type': 'Sedan',
        'grade': 'EX',
        'chassis': 'DEF789012',
        'mileage': 18000,
        'engine_capacity': 1500,
        'transmission': 'CVT',
        'fuel': 'Petrol',
        'steering': 'Left',
        'model_no': 'CIV-21',
        'drive': '2WD',
        'seats': 5,
        'doors': 4,
        'engine_model': 'L15B7',
        'color': 'Blue',
        'location': 'USA',
        'm3_size': 13.0,
        'length_cm': 458,
        'width_cm': 180,
        'height_cm': 142,
        'created_at': currentDate,
        'updated_at': currentDate,
        'image_url': 'https://via.placeholder.com/640x480.png?text=Honda+Civic',
      },
      {
        'id': 3,
        'stock_no': 'SN-003',
        'make': 'Nissan',
        'model': 'X-Trail',
        'reg_year': '2019',
        'type': 'SUV',
        'body_type': 'SUV',
        'grade': 'Ti',
        'chassis': 'GHI345678',
        'mileage': 32000,
        'engine_capacity': 2500,
        'transmission': 'CVT',
        'fuel': 'Diesel',
        'steering': 'Left',
        'model_no': 'XT-19',
        'drive': '4WD',
        'seats': 7,
        'doors': 5,
        'engine_model': 'QR25DE',
        'color': 'White',
        'location': 'Australia',
        'm3_size': 18.0,
        'length_cm': 485,
        'width_cm': 184,
        'height_cm': 171,
        'created_at': currentDate,
        'updated_at': currentDate,
        'image_url': 'https://via.placeholder.com/640x480.png?text=Nissan+X-Trail',
      },
    ];

    final vehicles = mockVehicles.map((json) => Vehicle.fromJson(json)).toList();
    
    return {
      'vehicles': vehicles,
      'count': vehicles.length,
      'next': null,
      'previous': null,
    };
  }
  
  // Submit a vehicle inquiry
  static Future<Map<String, dynamic>> submitInquiry(Map<String, dynamic> inquiryData) async {
    final uri = Uri.parse('$baseUrl/inquiries/');
    
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(inquiryData),
      );
      
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to submit inquiry: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to API: $e');
    }
  }
}
