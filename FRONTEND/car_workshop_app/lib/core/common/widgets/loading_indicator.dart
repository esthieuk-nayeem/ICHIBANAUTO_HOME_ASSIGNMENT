import 'package:flutter/material.dart';

class MinimalLoadingIndicator extends StatelessWidget {
  const MinimalLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3), // Semi-transparent background
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9), // Slightly transparent white
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
