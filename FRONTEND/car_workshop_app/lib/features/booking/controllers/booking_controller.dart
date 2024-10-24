import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:car_workshop_app/core/common/widgets/loading_indicator.dart';
import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/booking/data/booking_provider.dart';
import 'package:car_workshop_app/features/booking/models/booking_count_model.dart';
import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/models/booking_post_model.dart';
import 'package:car_workshop_app/features/booking/models/mechanic_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_calender_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_confirmation_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/order_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController queryController = TextEditingController();
  RxList<BookingDataModel> allBookings = <BookingDataModel>[].obs;
  RxList<MechanicDataModel> filteredMechanics = <MechanicDataModel>[].obs;
  Rx<BookingCountModel> bookingCount = BookingCountModel().obs;

  BookingPostModel bookingPostModel = BookingPostModel();

  final AppStorage storage = AppStorage();
  RxBool isObscurePassword = false.obs;
  RxInt currentMenuIndex = 0.obs;

  final BookingProvider bookingProvider = BookingProvider();

  Future<void> getBookings(BuildContext context, bool route) async {
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
        final errorMessage = response['data'] ??
            'Unknown error'; // Ensure error message is not null
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Getting Booking Data Failed!',
            message: errorMessage,
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      }

      final responseData = response['data'];
      if (responseData != null) {
        for (var i in responseData) {
          // Ensure the data you're parsing is valid and handle null safety
          try {
            BookingDataModel booking = BookingDataModel.fromJson(i ?? {});
            allBookings.add(booking);
          } catch (e) {
            print("Error parsing booking data: $e");
          }
        }
        allBookings.refresh();
        print("Booking query output: $allBookings");

        // Handle routing based on route parameter
        if (route) {
          if (currentMenuIndex.value == 1) {
            Get.to(() => BookingListPage(
                  orders: allBookings,
                ));
          } else if (currentMenuIndex.value == 2) {
            Get.to(BookingCalendarScreen(bookings: allBookings));
          }
        } else {
          print("Not routing");
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
      print('Error occurred during getting booking data: $error');
    }
  }

  Future<void> getBookingsdatas(BuildContext context) async {
    // Show loading overlay

    allBookings.clear();
    try {
      final response = await bookingProvider.getBookingData();

      // Ensure the widget is still mounted before popping the dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

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

        // Ensure the widget is still mounted before showing the SnackBar
        if (context.mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
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
      } else {
        print("Error: Null response received from provider");
      }
    } catch (error) {
      // Ensure the widget is still mounted before popping the dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      } else {}

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

      // Ensure the widget is still mounted before showing the SnackBar
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      print('Error occurred during login: $error');
    }
  }

  Future<void> getfilteredMechanics(BuildContext context) async {
    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const MinimalLoadingIndicator();
      },
    );

    filteredMechanics.clear();
    try {
      final response =
          await bookingProvider.getMechanicData(queryController.text);

      // Hide loading overlay
      Navigator.of(context).pop();

      if (response['status'] != 200) {
        final errorMessage = response['data'];
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Getting Mechanics Data Failed!',
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
          MechanicDataModel mechanic = MechanicDataModel.fromJson(i);
          filteredMechanics.add(mechanic);
          filteredMechanics.refresh();
        }
        print("Mechanic query output: $filteredMechanics");
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

  Future<void> assignNewMechanic(
      BuildContext context, String mechanicID, String bookingID) async {
    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const MinimalLoadingIndicator();
      },
    );

    try {
      final response =
          await bookingProvider.assignMechanic(mechanicID, bookingID);

      // Hide loading overlay
      Navigator.of(context).pop();

      if (response['status'] != 200) {
        final errorMessage = response['data'];
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Getting Mechanics Data Failed!',
            message: '$errorMessage',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      } else {
        getBookings(context, false);
        Get.back();
      }

      final responseData = response['data'];
      print("printing response data : $responseData");
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

  Future<void> changeBookingStatus(
      BuildContext context, String status, String bookingID) async {
    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const MinimalLoadingIndicator();
      },
    );

    try {
      final response = await bookingProvider.changeStatus(status, bookingID);

      // Hide loading overlay

      if (response['status'] != 200) {
        final errorMessage = response['data'];
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Updating Data Failed!',
            message: '$errorMessage',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      } else {
        getBookingsdatas(context);

        // Get.back();
      }

      final responseData = response['data'];
      print("printing response data : $responseData");
    } catch (error) {
      // Hide loading overlay
      Navigator.of(context).pop();

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Updating Data Failed',
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

  Future<void> bookAppointment(BuildContext context) async {
    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const MinimalLoadingIndicator();
      },
    );

    try {
      final response = await bookingProvider.postBooking(bookingPostModel);

      // Hide loading overlay

      if (response['status'] != 201) {
        final errorMessage = response['data'];
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Updating Data Failed!',
            message: '$errorMessage',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      } else {
        // Get.back();
        Get.back();
      }

      final responseData = response['data'];
      print("printing response data : $responseData");
    } catch (error) {
      // Hide loading overlay
      Navigator.of(context).pop();

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Posting Data Failed',
          message: '$error!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print('Error occurred during posting booking data: $error');
    }
  }

  Future<void> getBookingDataCount() async {
    // Show loading overlay
    // Get.dialog(
    //   const MinimalLoadingIndicator(),
    //   barrierDismissible: false,
    // );

    try {
      final response = await bookingProvider.getBookingCount();

      // Hide loading overlay
      // Get.back();

      if (response['status'] != 200) {
        final errorMessage = response['data'];
        // final snackBar = SnackBar(
        //   elevation: 0,
        //   behavior: SnackBarBehavior.floating,
        //   backgroundColor: Colors.transparent,
        //   content: AwesomeSnackbarContent(
        //     title: 'Updating Data Failed!',
        //     message: '$errorMessage',
        //     contentType: ContentType.failure,
        //   ),
        // );
        // ScaffoldMessenger.of(Get.context!)
        //   ..hideCurrentSnackBar()
        //   ..showSnackBar(snackBar);
        return;
      } else {
        final responseData = response['data'];
        bookingCount.value = BookingCountModel.fromJson(responseData);

        print("printing response data : $responseData");
      }
    } catch (error) {
      // Hide loading overlay
      // Get.back();

      // final snackBar = SnackBar(
      //   elevation: 0,
      //   behavior: SnackBarBehavior.floating,
      //   backgroundColor: Colors.transparent,
      //   content: AwesomeSnackbarContent(
      //     title: 'Posting Data Failed',
      //     message: '$error!',
      //     contentType: ContentType.failure,
      //   ),
      // );
      // ScaffoldMessenger.of(Get.context!)
      //   ..hideCurrentSnackBar()
      //   ..showSnackBar(snackBar);
      print('Error occurred during posting booking data: $error');
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
