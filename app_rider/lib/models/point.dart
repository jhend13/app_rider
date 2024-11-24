class Point {
  final double lat;
  final double long;

  const Point(this.lat, this.long);

  @override
  String toString() {
    return '$long,$lat';
  }
}
