import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_time_slot_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CarDetailsForm extends StatefulWidget {
  const CarDetailsForm({Key? key}) : super(key: key);

  @override
  State<CarDetailsForm> createState() => _CarDetailsFormState();
}

class _CarDetailsFormState extends State<CarDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _registrationPlateController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _carMakeController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _registrationPlateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.blue.shade50],
            stops: [0.0, 0.2],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Tell us about your car',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Please provide accurate details of your vehicle',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Form Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Car Make
                          _buildTextField(
                            controller: _carMakeController,
                            label: 'Car Make',
                            hint: 'e.g., Toyota',
                            icon: Icons.directions_car,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter car make';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Car Model
                          _buildTextField(
                            controller: _carModelController,
                            label: 'Car Model',
                            hint: 'e.g., Camry',
                            icon: Icons.car_repair,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter car model';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Car Year
                          _buildTextField(
                            controller: _carYearController,
                            label: 'Car Year',
                            hint: 'e.g., 2020',
                            icon: Icons.date_range,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter car year';
                              }
                              int? year = int.tryParse(value!);
                              if (year == null ||
                                  year < 1900 ||
                                  year > DateTime.now().year + 1) {
                                return 'Please enter a valid year';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Registration Plate
                          _buildTextField(
                            controller: _registrationPlateController,
                            label: 'Registration Plate',
                            hint: 'e.g., ABC123',
                            icon: Icons.pin,
                            textCapitalization: TextCapitalization.characters,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter registration plate';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Booking Description
                          _buildTextField(
                            controller: _descriptionController,
                            label: 'Service Description',
                            hint: 'Describe the service needed',
                            icon: Icons.description,
                            maxLines: 3,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter service description';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    // Next Button
                    Container(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // TODO: Navigate to next page with form data
                            Map<String, dynamic> carDetails = {
                              'carMake': _carMakeController.text,
                              'carModel': _carModelController.text,
                              'carYear': _carYearController.text,
                              'registrationPlate':
                                  _registrationPlateController.text,
                              'description': _descriptionController.text,
                            };
                            print(carDetails); // For testing
                            controller.bookingPostModel.carMake =
                                _carMakeController.text;
                            controller.bookingPostModel.carModel =
                                _carModelController.text;
                            controller.bookingPostModel.carYear =
                                _carYearController.text;
                            controller.bookingPostModel.carRegistrationPlate =
                                _registrationPlateController.text;
                            controller.bookingPostModel.bookingDescription =
                                _descriptionController.text;

                            Get.to(BookingTimeSlotPage(carDetails: carDetails));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(icon, color: Colors.blue.shade700),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade700, width: 1),
            ),
          ),
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
