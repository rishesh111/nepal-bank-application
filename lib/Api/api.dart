import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nepal_bank/constants.dart';

class CallApi{
  final String _url = '${Constants.baseUrl}api/register';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async{
    var fullUrl = _url + apiUrl;
    return await http.get(
      fullUrl,
      headers: _setHeaders()
    );
  }

  _setHeaders() =>
        {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };

}