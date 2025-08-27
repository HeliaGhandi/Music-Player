import 'package:login/json-handler.dart';

class Music {
  String? name;
  String? singer;
  String? URL;
  String? iconURL;
  @override
  String toString() {
    return ("{MUSIC : \nName : " +
        name! +
        "\nSinger : " +
        singer! +
        "\nURL : " +
        URL!);
  }

  Music({this.name, this.URL, this.singer, this.iconURL});
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Music && other.URL == URL;
  }

  @override
  int get hashCode => URL.hashCode;
}
