import 'package:flutter_test/flutter_test.dart';

import 'package:logdna/logdna.dart';
import 'package:logdna/models/dna_line.dart';

void main() {
  test("test logDna", () async {
    final _logDna = LogDNA(
      apiKey: 'a92ad6d21931a030d60a224289b14f17',
      hostName: 'android',
    );
    await _logDna.log(DnaLine(
      timestamp: (DateTime.now().millisecondsSinceEpoch / 100).toString(),
      line: 'line',
      app: 'testApp',
      level: DnaLevel.info,
      env: 'dev',
      meta: {'meta': 'body'},
    ), tags: ['test1, test2']);
  });
}
