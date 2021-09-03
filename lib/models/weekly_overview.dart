class WeeklyOverView {
  int? id;
  int? numberOfCleaningRoom;
  int? numberOfDishes;
  int? numberOfTakeOutTRash;

  WeeklyOverView(
      {required this.id,
      required this.numberOfCleaningRoom,
      required this.numberOfDishes,
      required this.numberOfTakeOutTRash});

  WeeklyOverView.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        numberOfCleaningRoom = res["number_of_cleaning_room"],
        numberOfDishes = res["number_of_dishes"],
        numberOfTakeOutTRash = res["number_of_take_out_trash"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'number_of_cleaning_room': numberOfCleaningRoom,
      'number_of_dishes': numberOfDishes,
      'number_of_take:out_trash': numberOfTakeOutTRash
    };
  }
}
