package com.dairy.backend.util;
public class PriceCalculator {

    // A simple price calculation: base price plus a premium for fat content.
    public static double calculatePrice(double fatPercentage, double basePrice) {
        // For example, each percentage point above 3% fat adds a premium
        double premium = 0;
        if (fatPercentage > 3) {
            premium = (fatPercentage - 3) * 2; // ₹2 per percentage point above 3%
        }
        return basePrice + premium;
    }
}
