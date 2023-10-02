import 'package:expense_application/constants/image_constants.dart';

class AppDataConstants {
  static const List<Map<String, dynamic>> categories = [
    {"id": 1, "name": "Travel", "img": ImageConstants.travelPath},
    {"id": 2, "name": "Coffee", "img": ImageConstants.coffeePath},
    {"id": 3, "name": "Food", "img": ImageConstants.cookingPath},
    {"id": 4, "name": "Scakes ", "img": ImageConstants.scakesPath},
    {"id": 5, "name": "Petrol", "img": ImageConstants.petrolPath},
    {"id": 6, "name": "Gift", "img": ImageConstants.giftPath},
    {"id": 7, "name": "Rent", "img": ImageConstants.rentPath},
    {
      "id": 8,
      "name": "Online Shopping",
      "img": ImageConstants.onlineShoppingPath
    },
    {
      "id": 9,
      "name": "Money Transfer",
      "img": ImageConstants.moneyTransferPath
    },
    {"id": 10, "name": "Recharge", "img": ImageConstants.rechargePath},
    {"id": 11, "name": "Restaturant", "img": ImageConstants.restaurantPath},
    {"id": 12, "name": "Movie", "img": ImageConstants.moviePath}
  ];
}
