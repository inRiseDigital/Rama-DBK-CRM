class Vehicle {
  final int id;
  final String stockNo;
  final String make;
  final String model;
  final String regYear;
  final String type;
  final String bodyType;
  final String grade;
  final String chassis;
  final int mileage;
  final int engineCapacity;
  final String transmission;
  final String fuel;
  final String steering;
  final String modelNo;
  final String drive;
  final int seats;
  final int doors;
  final String engineModel;
  final String color;
  final String location;
  final double m3Size;
  final int lengthCm;
  final int widthCm;
  final int heightCm;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? imageUrl;

  Vehicle({
    required this.id,
    required this.stockNo,
    required this.make,
    required this.model,
    required this.regYear,
    required this.type,
    required this.bodyType,
    required this.grade,
    required this.chassis,
    required this.mileage,
    required this.engineCapacity,
    required this.transmission,
    required this.fuel,
    required this.steering,
    required this.modelNo,
    required this.drive,
    required this.seats,
    required this.doors,
    required this.engineModel,
    required this.color,
    required this.location,
    required this.m3Size,
    required this.lengthCm,
    required this.widthCm,
    required this.heightCm,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      stockNo: json['stock_no'],
      make: json['make'],
      model: json['model'],
      regYear: json['reg_year'],
      type: json['type'],
      bodyType: json['body_type'],
      grade: json['grade'],
      chassis: json['chassis'],
      mileage: json['mileage'],
      engineCapacity: json['engine_capacity'],
      transmission: json['transmission'],
      fuel: json['fuel'],
      steering: json['steering'],
      modelNo: json['model_no'],
      drive: json['drive'],
      seats: json['seats'],
      doors: json['doors'],
      engineModel: json['engine_model'],
      color: json['color'],
      location: json['location'],
      m3Size: json['m3_size'].toDouble(),
      lengthCm: json['length_cm'],
      widthCm: json['width_cm'],
      heightCm: json['height_cm'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      imageUrl: json['image_url'],
    );
  }

  String getTitle() {
    return '$make $model $regYear';
  }

  String getImageUrl() {
    return imageUrl ?? 'assets/images/car_placeholder.png';
  }

  String getPrice() {
    return 'Price on request';
  }
  
  String getSpecifications() {
    return '''
• Make: $make
• Model: $model
• Year: $regYear
• Body Type: $bodyType
• Grade: $grade
• Mileage: $mileage km
• Engine: ${engineCapacity}cc
• Transmission: $transmission
• Fuel: $fuel
• Steering: $steering
• Drive: $drive
• Color: $color
• Seats: $seats
• Doors: $doors
• Dimensions: ${lengthCm}cm × ${widthCm}cm × ${heightCm}cm
• Engine Model: $engineModel
• Chassis: $chassis
''';
  }
}
