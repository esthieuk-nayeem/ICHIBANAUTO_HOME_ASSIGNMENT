import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:car_workshop_app/core/common/widgets/loading_indicator.dart';
import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/booking/data/booking_provider.dart';
import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_calender_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/order_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  RxList<BookingDataModel> allBookings = <BookingDataModel>[].obs;

  final AppStorage storage = AppStorage();
  RxBool isObscurePassword = false.obs;
  RxInt currentMenuIndex = 0.obs;

  final BookingProvider bookingProvider = BookingProvider();
  Future<void> getBookings(BuildContext context) async {
    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const MinimalLoadingIndicator();
      },
    );

    allBookings.clear();
    try {
      final response = await bookingProvider.getBookingData();

      // Hide loading overlay
      Navigator.of(context).pop();

      if (response['status'] != 200) {
        final errorMessage = response['data'];
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Getting Booking Data Failed!',
            message: '$errorMessage',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      }

      final responseData = response['data'];
      print("printing response data : $responseData");

      if (responseData != null) {
        for (var i in responseData) {
          BookingDataModel booking = BookingDataModel.fromJson(i);
          allBookings.add(booking);
          allBookings.refresh();
        }
        print("Booking query output: $allBookings");

        if (currentMenuIndex.value == 1) {
          Get.to(() => BookingListPage(
                orders: allBookings,
              ));
        } else if (currentMenuIndex.value == 2) {
          Get.to(BookingCalendarScreen(bookings: allBookings));
        }
      } else {
        print("Error: Null response received from provider");
      }
    } catch (error) {
      // Hide loading overlay
      Navigator.of(context).pop();

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Getting Booking Data Failed',
          message: '$error!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print('Error occurred during login: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
