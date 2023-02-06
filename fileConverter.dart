import 'dart:convert';
import 'dart:io';

/// It's probably necessary to change the file path to the absolute path
/// For example
/// /Users/anderson/Documents/input.txt

const inputPath = '/input.txt';
const excludePath = '/exclude.txt';
const outputPath = '/output.txt';

void fileConverter() async {
  File input = File(inputPath);

  List<String> inputStringsList = [];

  File exclude = File(excludePath);
  List<String> excludeStringsList = [];

  File output = File(outputPath);

  await input
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .forEach((l) => inputStringsList.add(l));

  await exclude
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .forEach((l) => excludeStringsList.add(l));

  for (var i in excludeStringsList) {
    if (inputStringsList.contains(i.trim())) {
      inputStringsList.remove(i);
    }
  }

  output.writeAsString("");

  for (var i = 0; i < inputStringsList.length; i++) {
    if (inputStringsList[i].isNotEmpty) {
      await output.writeAsString(inputStringsList[i], mode: FileMode.append);

      if ((i + 2) < inputStringsList.length) {
        await output.writeAsString("\n", mode: FileMode.writeOnlyAppend);
      }
    }
  }
}

void main() async => fileConverter();
