import 'package:flutter/material.dart';

/// Featured Vehicles Component
///
/// Displays a curated selection of premium vehicles with details
/// and call-to-action buttons in a responsive grid or list layout.

class FeaturedVehicles extends StatelessWidget {
  const FeaturedVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60.0,
        horizontal: isMobile ? 20.0 : 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Center(
            child: Column(
              children: [
                Text(
                  'FEATURED VEHICLES',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Discover Our Premium Collection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24.0 : 32.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 50.0,
                  height: 3.0,
                  color: Colors.red,
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
          
          // Vehicle Grid/List
          isMobile
              ? Column(
                  children: [
                    _buildVehicleCard(context, 'Luxury Sedan', '\$75,000', 'assets/images/car_01.png'),
                    SizedBox(height: 20.0),
                    _buildVehicleCard(context, 'Premium SUV', '\$85,000', 'assets/images/car_02.jpg'),
                    SizedBox(height: 20.0),
                    _buildVehicleCard(context, 'Sports Coupe', '\$95,000', 'assets/images/car_03.png'),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildVehicleCard(context, 'Luxury Sedan', '\$75,000', 'assets/images/car_01.png'),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: _buildVehicleCard(context, 'Premium SUV', '\$85,000', 'assets/images/car_02.jpg'),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: _buildVehicleCard(context, 'Sports Coupe', '\$95,000', 'assets/images/car_03.png'),
                    ),
                  ],
                ),
          
          // View All Button
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 15.0,
                  ),
                ),
                child: Text(
                  'View All Vehicles',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(BuildContext context, String title, String price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vehicle Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.directions_car,
                      size: 50.0,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Vehicle Details
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    _buildFeatureItem(Icons.speed, '300 hp'),
                    SizedBox(width: 15.0),
                    _buildFeatureItem(Icons.local_gas_station, '25 mpg'),
                    SizedBox(width: 15.0),
                    _buildFeatureItem(Icons.timer, '4.5 sec'),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: Text('Details'),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: Text('Test Drive'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: Colors.grey[600],
        ),
        SizedBox(width: 5.0),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}