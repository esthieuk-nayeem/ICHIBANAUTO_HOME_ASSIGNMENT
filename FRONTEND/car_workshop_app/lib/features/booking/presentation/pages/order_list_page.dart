import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/components/order_card_item.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/admin_dashboard.dart';
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
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        carName: widget.orders[index].carMake.toString(),
                        orderDate:
                            widget.orders[index].appointmentDate.toString(),
                        carRegistrationPlate: widget
                            .orders[index].carRegistrationPlate
                            .toString(),
                        status: widget.orders[index].status.toString(),
                        mechanicName:
                            widget.orders[index].mechanic!.fullName.toString(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Get.offAll(AdminDashboardPage());
              break;
            case 1:
              Get.offAll(BookingListPage(
                orders: [BookingDataModel()],
              ));
              break;
            case 2:
              // Add routing logic for index 2
              break;
            case 3:
              // Add routing logic for index 3
              break;
          }
        },
      ),
    );
  }
}
