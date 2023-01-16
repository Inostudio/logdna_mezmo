import 'dart:convert' show jsonEncode;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:logdna/models/dna_line.dart';

import 'models/response.dart';

class LogDNA {
  /// Ingestion key
  final String apiKey;

  /// The hostname of the source
  final String hostName;

  LogDNA({required this.apiKey, required this.hostName});

  //// Sends the log via the logdna ingest API
  Future<DnaResponse> log(DnaLine line, {List<String>? tags}) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch / 100;
    try {
      String uriString = "https://logs.mezmo.com/logs/ingest?hostname=$hostName"
          "&now=$now&apikey=$apiKey";
      if (tags != null) {
        uriString += '&tags=${tags.join(",")}';
      }
      final uri = Uri.parse(uriString);

      http.Response response = await http.post(uri,
          body: jsonEncode({
            "lines": [line]
          }),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          });

      if (response.statusCode == 200) {
        print(true);
        var result = DnaResponse(true, response.body);
        return result;
      } else {
        print(true);
        return DnaResponse(false, response.body);
      }
    } catch (e) {
      debugPrint("DNALogs Error: ${e.toString()}");
      return DnaResponse(false, e.toString());
    }
  }
}
