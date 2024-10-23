import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/components/mechanic_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAddUser extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());
  final int bookingID;

  DialogAddUser({required this.bookingID});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: width * .9, // Mobile device only logic
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: width * .73, // Width for mobile only
                      child: SearchBar(
                        controller: controller.queryController,
                        onSubmitted: (value) {},
                        hintText: "Search User..",
                        leading: Icon(Icons.search_sharp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.search,
                    size: 16,
                  ),
                  onPressed: () {
                    controller.getfilteredMechanics(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  label: const Text('Search'),
                ),
                SizedBox(height: 15),
                Obx(
                  () => Container(
                    width: width * .75, // Mobile-specific width
                    child: controller.filteredMechanics.isEmpty
                        ? Text("No user found!")
                        : Column(
                            children: List.generate(
                              controller.filteredMechanics.length,
                              (index) => MechanicListCard(
                                email:
                                    controller.filteredMechanics[index].email,
                                name: controller
                                        .filteredMechanics[index].fullName ??
                                    "No Mechanic assigned",
                                onPressed: () {
                                  controller.assignNewMechanic(
                                      context,
                                      controller.filteredMechanics[index].id
                                          .toString(),
                                      bookingID.toString());
                                },
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
