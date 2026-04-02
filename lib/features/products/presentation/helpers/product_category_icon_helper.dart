import 'package:flutter/material.dart';

class ProductCategoryIconHelper {
  static IconData resolve(String category) {
    final normalizedName = category.toLowerCase();

    //Entries
    if (normalizedName.contains('entradas')) {
      return Icons.soup_kitchen_rounded;
    }

    //Beef
    if (normalizedName.contains('carnes')) {
      return Icons.outdoor_grill;
    }

    //Alcoholic Drinks
    if (normalizedName.contains('bebidas alcoholicas')) {
      return Icons.liquor;
    }

    //hot drinks
    if (normalizedName.contains('bebidas calientes')) {
      return Icons.local_cafe_rounded;
    }

    //cold drinks
    if (normalizedName.contains('bebidas frías')) {
      return Icons.local_drink_rounded;
    }

    //Other Drinks
    if (normalizedName.contains('postres')) {
      return Icons.icecream_rounded;
    }

    //Fast Food
    if (normalizedName.contains('comida rápida')) {
      return Icons.fastfood;
    }

    //Seafood
    if (normalizedName.contains('marisco')) {
      return Icons.set_meal_rounded;
    }

    //kids menu
    if (normalizedName.contains('infantil')) {
      return Icons.child_care;
    }

    //combo
    if (normalizedName.contains('combos')) {
      return Icons.local_dining;
    }

    //Vegetarian
    if (normalizedName.contains('vegetariano')) {
      return Icons.eco_rounded;
    }

    //Pasta
    if (normalizedName.contains('pasta')) {
      return Icons.ramen_dining_rounded;
    }

    //Rices
    if (normalizedName.contains('arroces')) {
      return Icons.rice_bowl_rounded;
    }

    //Breakfast
    if (normalizedName.contains('desayunos')) {
      return Icons.breakfast_dining_rounded;
    }

    //Lunch
    if (normalizedName.contains('almuerzos')) {
      return Icons.dining_rounded;
    }

    return Icons.category_rounded;
  }
}
