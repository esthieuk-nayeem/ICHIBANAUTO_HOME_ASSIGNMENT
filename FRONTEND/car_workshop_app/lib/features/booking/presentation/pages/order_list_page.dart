import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/components/order_card_item.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/admin_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_details_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class BookingListPage extends StatefulWidget {
  final List<BookingDataModel> orders;

  BookingListPage({Key? key, required this.orders}) : super(key: key);

  @override
  _BookingListPageState createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Order List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: widget.orders.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: OrderListCard(
                        onTap: () {
                          Get.to(BookingDetailsPage());
                        },
                        carName: widget.orders[index].carMake.toString(),
                        orderDate:
                            widget.orders[index].appointmentDate.toString(),
                        carRegistrationPlate: widget
                            .orders[index].carRegistrationPlate
                            .toString(),
                        status: widget.orders[index].status.toString(),
                        mechanicName: widget.orders[index].mechanic?.fullName
                                .toString() ??
                            '',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: controller.currentMenuIndex.value,
          onItemSelected: (index) async {
            controller.currentMenuIndex.value = index;

            switch (index) {
              case 0:
                Get.offAll(AdminDashboardPage());
                break;
              case 1:
                await controller.getBookings(context);
                break;
              case 2:
                await controller.getBookings(context);
                break;
              case 3:
                Get.to(ProfilePage());
                // Add routing logic for index 3
                break;
            }
          },
        ),
      ),
    );
  }
}
