// [{"ROI":1.00,"MaxRate":4045}]

import 'package:money2me/common/response_model.dart';

ApiResponse<HighestRateAndLowerROI> highestRateAndLowerROIList(dynamic data) =>
    ApiResponse.fromJson(data,(data)=>HighestRateAndLowerROI.fromJson(data.first));

class HighestRateAndLowerROI extends Serializable{
  double? roi;
  int? maxRate;

  HighestRateAndLowerROI({required this.roi, required this.maxRate});

  factory HighestRateAndLowerROI.fromJson(Map<String, dynamic> json) {
    return HighestRateAndLowerROI(roi: json["ROI"], maxRate: json["MaxRate"]);
  }
  Map<String, dynamic> toJson() => {
        "ROI": roi,
        "MaxRate": maxRate,
      };
}
