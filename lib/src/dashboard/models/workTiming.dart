
import 'package:money2me/common/response_model.dart';

ListResponse<WorkTiming> workTimingFromJson(Map<String, dynamic> json) =>  ListResponse.fromJson(json,(data)=>List<WorkTiming>.from(data.map((e) => WorkTiming.fromJson(e))));

class WorkTiming extends Serializable{
    String? officeTiming;

    WorkTiming({
        this.officeTiming,
    });

    factory WorkTiming.fromJson(Map<String, dynamic> json) => WorkTiming(
        officeTiming: json["OfficeTiming"],
    );

    @override
  Map<String, dynamic> toJson() => {
        "OfficeTiming": officeTiming,
    };
}
