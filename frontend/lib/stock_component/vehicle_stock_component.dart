import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';  // Make sure this import is correct
import '../services/api_service.dart';

class VehicleStock extends StatefulWidget {
  final Map<String, String?>? filters;

  const VehicleStock({Key? key, this.filters}) : super(key: key);

  @override
  State<VehicleStock> createState() => _VehicleStockState();
}

class _VehicleStockState extends State<VehicleStock> {
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  List<Vehicle> _vehicles = [];
  int _totalVehicles = 0;
  int _currentPage = 1;
  bool _hasNextPage = false;
  bool _hasPreviousPage = false;

  @override
  void initState() {
    super.initState();
    _fetchVehicles();
  }

  @override
  void didUpdateWidget(VehicleStock oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refetch vehicles if filters change
    if (oldWidget.filters != widget.filters) {
      _fetchVehicles();
    }
  }

  Future<void> _fetchVehicles() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final result = await ApiService.fetchVehicles(
        filters: widget.filters,
        page: _currentPage,
      );

      setState(() {
        _vehicles = result['vehicles'] as List<Vehicle>;
        _totalVehicles = result['count'] as int;
        _hasNextPage = result['next'] != null;
        _hasPreviousPage = result['previous'] != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        if (e.toString().contains('SocketException') || 
            e.toString().contains('Connection refused')) {
          _errorMessage = 'Could not connect to the server. Please check your internet connection or try again later.';
        } else {
          _errorMessage = 'Failed to load vehicles: ${e.toString()}';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final bool isSmallScreen = screenSize.width < 360;

    // Determine grid columns based on screen size
    int gridColumns;
    if (screenSize.width > 1200) {
      gridColumns = 4;
    } else if (screenSize.width > 900) {
      gridColumns = 3;
    } else if (screenSize.width > 600) {
      gridColumns = 2;
    } else {
      gridColumns = 1;
    }

    // Adjust child aspect ratio based on screen size
    double childAspectRatio;
    if (isMobile) {
      childAspectRatio = isSmallScreen ? 0.85 : 0.95;
    } else {
      childAspectRatio = screenSize.width > 1200 ? 0.85 : 0.9;
    }

    // Red, white, and black color scheme
    final Color primaryColor = Colors.red.shade800;
    const Color secondaryColor = Colors.black;
    const Color backgroundColor = Colors.white;

    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 16.0 : 32.0,
                horizontal: isMobile ? 8.0 : 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          height: 3,
                          width: 60,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 40),

                  // Loading state
                  if (_isLoading)
                    Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(color: primaryColor),
                          const SizedBox(height: 16),
                          const Text(
                            'Loading vehicles...',
                            style: TextStyle(color: secondaryColor),
                          ),
                        ],
                      ),
                    )
                  // Error state
                  else if (_hasError)
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Failed to load vehicles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _fetchVehicles,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  // Empty state
                  else if (_vehicles.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 20.0 : 32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: isMobile ? 48 : 64,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            Text(
                              'No vehicles found matching your criteria',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  // Show vehicle grid
                  else
                    Column(
                      children: [
                        // Results counter
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Found $_totalVehicles vehicles',
                            style: const TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        
                        // Vehicle grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridColumns,
                            childAspectRatio: childAspectRatio,
                            crossAxisSpacing: isMobile ? 12 : 24,
                            mainAxisSpacing: isMobile ? 12 : 24,
                          ),
                          itemCount: _vehicles.length,
                          itemBuilder: (context, index) => VehicleCard(
                            vehicle: _vehicles[index],
                            primaryColor: primaryColor,
                            secondaryColor: secondaryColor,
                            isMobile: isMobile,
                          ),
                        ),
                        
                        // Pagination controls
                        if (_totalVehicles > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_hasPreviousPage)
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _currentPage--;
                                      });
                                      _fetchVehicles();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: primaryColor,
                                    ),
                                    child: const Text('Previous'),
                                  ),
                                SizedBox(width: _hasPreviousPage && _hasNextPage ? 16.0 : 0),
                                if (_hasNextPage)
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _currentPage++;
                                      });
                                      _fetchVehicles();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Next'),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VehicleCard extends StatefulWidget {
  final Vehicle vehicle;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isMobile;

  const VehicleCard({
    Key? key,
    required this.vehicle,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  bool isHovered = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            Matrix4.identity()
              ..scale(isHovered ? 1.03 : 1.0)
              ..translate(0.0, isHovered ? -5.0 : 0.0),
        child: Card(
          elevation: isHovered ? 16 : 4,
          shadowColor: widget.primaryColor.withOpacity(0.4),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isHovered ? widget.primaryColor : Colors.white,
              width: 2,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section with improved gradient
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Vehicle image with fallback
                    Hero(
                      tag: widget.vehicle.id.toString(),
                      child: Image.network(
                        widget.vehicle.getImageUrl(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/car_placeholder.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[100],
                            child: Icon(
                              Icons.directions_car,
                              size: 40,
                              color: widget.primaryColor.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Enhanced gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.8),
                            ],
                            stops: const [0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Stock number badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: widget.primaryColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          widget.vehicle.stockNo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    // Enhanced title overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.vehicle.getTitle(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Enhanced details and actions section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade100, width: 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Key specs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Engine capacity
                        Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.vehicle.engineCapacity}cc',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        // Transmission
                        Row(
                          children: [
                            Icon(
                              Icons.sync_alt,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.vehicle.transmission,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        // Year
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.vehicle.regYear,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    
                    // Location info
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: widget.primaryColor,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Location: ${widget.vehicle.location}',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _showDetailsDialog(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: widget.primaryColor,
                              side: BorderSide(
                                color: isHovered ? widget.primaryColor : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.info_outline, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Details',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showInquiryDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: isHovered ? 4 : 1,
                              shadowColor: widget.primaryColor.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.send, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Inquire',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: widget.primaryColor, width: 1.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Close button at top right
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close, color: widget.primaryColor),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),

                    // Vehicle image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.vehicle.getImageUrl(),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/car_placeholder.png',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.directions_car,
                              size: 50,
                              color: widget.primaryColor.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title with red underline
                    Column(
                      children: [
                        Text(
                          widget.vehicle.getTitle(),
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 2,
                          width: 60,
                          color: widget.primaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Stock number and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: widget.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Stock #: ${widget.vehicle.stockNo}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.vehicle.getPrice(),
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Vehicle specifications in a scrollable container if needed
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: widget.primaryColor.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vehicle Specifications',
                                style: TextStyle(
                                  color: widget.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.vehicle.getSpecifications(),
                                style: const TextStyle(
                                  color: Colors.black87,
                                  height: 1.6,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: widget.primaryColor,
                            side: BorderSide(color: widget.primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Close'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showInquiryDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Inquire Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInquiryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width:
                MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width * 0.9
                    : 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.primaryColor.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Quick Inquiry',
                            style: TextStyle(
                              color: widget.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: widget.primaryColor),
                          onPressed: () => Navigator.of(context).pop(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const Divider(height: 20),

                    // Vehicle title and stock number
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.vehicle.getTitle(),
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Stock #: ${widget.vehicle.stockNo}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Form fields with validation
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: _getInputDecoration('Your Name'),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: _getInputDecoration('Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _messageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                      maxLines: 2,
                      decoration: _getInputDecoration('Your Message'),
                    ),
                    const SizedBox(height: 20),

                    // Send button with loading state
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _handleInquirySubmit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Send Inquiry',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _getInputDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      hintStyle: TextStyle(
        color: widget.primaryColor.withOpacity(0.5),
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: widget.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: widget.primaryColor.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: widget.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade800),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade800),
      ),
    );
  }

  Future<void> _handleInquirySubmit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        // Prepare the inquiry data
        final inquiryData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'message': _messageController.text,
          'vehicle_id': widget.vehicle.id,
          'vehicle_stock_no': widget.vehicle.stockNo,
          'vehicle_title': widget.vehicle.getTitle(),
        };
        
        // In a real app, you would send this data to your backend API
        // Example:
        // await ApiService.submitInquiry(inquiryData);
        
        // Simulate API call for now
        await Future.delayed(const Duration(seconds: 2));

        // Clear form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        // Close dialog
        Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Inquiry sent successfully! Our team will contact you shortly.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: widget.primaryColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to send inquiry: ${e.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red.shade800,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }
}
