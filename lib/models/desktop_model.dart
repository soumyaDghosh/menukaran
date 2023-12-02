class Desktop {
  final int? id;
  final String filename;
  final String name;
  final String type;
  final String executable;
  final String? icon;
  final String? genericname;
  final String? comment;
  final String? onlyshowin;
  final String? tryexec;

  const Desktop({
    this.id,
    required this.name,
    required this.executable,
    required this.type,
    required this.filename,
    this.icon,
    this.genericname,
    this.comment,
    this.onlyshowin,
    this.tryexec,
  });
  factory Desktop.fromJson(Map<String, dynamic> json) => Desktop(
        id: json['id'],
        name: json['name'],
        executable: json['executable'],
        filename: json['filename'],
        type: json['type'],
        icon: json['icon'],
        genericname: json['genericname'],
        comment: json['comment'],
        onlyshowin: json['onlyshowin'],
        tryexec: json['tryexec'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'executable': executable,
        'filename': filename,
        'type': type,
        'icon': icon,
        'genericname': genericname,
        'comment': comment,
        'onlyshowin': onlyshowin,
        'tryexec': tryexec,
      };
}
