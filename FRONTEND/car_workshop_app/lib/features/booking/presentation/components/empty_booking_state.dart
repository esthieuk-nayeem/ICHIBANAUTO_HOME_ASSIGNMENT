import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class EmptyBookingState extends StatelessWidget {
  const EmptyBookingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStorage appStorage = AppStorage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Car icon in a circular container
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_car_filled,
              size: 70,
              color: Colors.blue.shade700,
            ),
          ),

          SizedBox(height: 24),

          // Main text
          Text(
            "No Bookings Yet!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),

          SizedBox(height: 12),

          // Subtext
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              appStorage.userGroup.val == "user"
                  ? "Your car service bookings will appear here once you make your first appointment."
                  : "No Booking Data available!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: 32),

          // Action button
          appStorage.userGroup.val == "user"
              ? ElevatedButton.icon(
                  onPressed: () {
                    // Add navigation to booking screen
                  },
                  icon: Icon(Icons.add_circle_outline),
                  label: Text("Book Your First Service"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Container(),

          SizedBox(height: 60), // Extra space at bottom
        ],
      ),
    );
  }
}
