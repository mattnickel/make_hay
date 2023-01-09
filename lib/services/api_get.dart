import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote_model.dart';


Future <Quote?> callQuotesApi() async{
  // var dir = await getTemporaryDirectory();
  // File quoteFile = File("${dir.path}/quote.json");
  // Quote randomQuote=Quote(text: '', author:'');
  // DateTime update = await quoteFile.lastModified();
  // print("here");
  // if (update.day == DateTime.now().day) {
  //   var random = quoteFile.readAsStringSync();
  //
  //   randomQuote = random as Quote;
  //
  // } else {
  Uri url = Uri.parse("https://type.fit/api/quotes");
  final tokenHeaders = { 'content-type': 'application/json'};
  final response = await http.get(
    url, headers: tokenHeaders,
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    int max = parsed.length ?? 0;
    int randomInt = Random().nextInt(max);
    print(Quote.fromJson(parsed[randomInt]));
    // quoteFile.writeAsStringSync(parsed[randomInt], flush: true, mode: FileMode.write);
    return  Quote.fromJson(parsed[randomInt]);
  }else{
    print("problem here");
  }

}

