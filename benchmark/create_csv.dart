import 'dart:io';

void createCsv(List<List<int>> data, String name, String prefix) {
  var file = File("${Directory.current.path}/benchmark/results/$name.csv");

  if (file.existsSync()) {
    file.deleteSync();
  }

  file.createSync();
  var sink = file.openWrite(mode: FileMode.append);

  for (var d in data) {
    sink.writeln(d.join(","));
  }

  sink.flush();
}
