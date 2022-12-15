import 'dart:math';

double _distanceBetween(
  double startLatitude,
  double startLongitude,
  double endLatitude,
  double endLongitude,
) {
  var earthRadius = 6378137.0;
  var dLat = _toRadians(endLatitude - startLatitude);
  var dLon = _toRadians(endLongitude - startLongitude);

  var a = pow(sin(dLat / 2), 2) +
      pow(sin(dLon / 2), 2) *
          cos(_toRadians(startLatitude)) *
          cos(_toRadians(endLatitude));
  var c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}
