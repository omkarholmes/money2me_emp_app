import 'package:equatable/equatable.dart';
import 'package:money2me/common/response_model.dart';

ListResponse<Slot> slotFromJson(Map<String, dynamic> data) =>
    ListResponse.fromJson(
        data, (data) => List<Slot>.from((data.map((e) => Slot.fromJson(e)))));

Map<String, dynamic> slotToJson(Slot data) => data.toJson();

class Slot extends Serializable with EquatableMixin{
  SlotType? slottype;
  String? slotdesc;
  String? timevalue;
  Slot({
    this.slottype,
    this.slotdesc,
    this.timevalue,
  });

  factory Slot.fromJson(Map<String, dynamic> json) =>
      Slot(
        slottype: slotsFromJson(json["Slottype"]),
        slotdesc: json["Slotdesc"],
        timevalue: json["Timevalue"],
      );

  Map<String, dynamic> toJson() =>
      {
        "Slottype": slottype?.toJson,
        "Slotdesc": slotdesc,
        "Timevalue" : timevalue
      };

  static SlotType? slotsFromJson(String value) {
    switch (value) {
      case "Afternoon":
        return SlotType.AFTERNOON;
      case "Evening":
        return SlotType.EVENING;
      case "Morning":
        return SlotType.MORNING;
    }
    return null;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    slottype,
    slotdesc,
    timevalue
  ];
}

enum SlotType {
  AFTERNOON,
  EVENING,
  MORNING;

  String get toJson {
    switch (this) {
      case SlotType.AFTERNOON:
        return "Afternoon";
      case SlotType.EVENING:
        return "Evening";
      case SlotType.MORNING:
        return "Morning";
    }
  }
}