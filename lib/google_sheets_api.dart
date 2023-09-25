import 'package:gsheets/gsheets.dart';



class GoogleSheetsApi{

  static const _credentials = r'''
    {
  "type": "service_account",
  "project_id": "expence-tracker-400008",
  "private_key_id": "46a975ce1d5f9fe0a1ed1443e1f8bc1353935617",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDUJdOuF97Myz8S\n9hsyiaZVEqYKEyD2xwJF1fFlBlJ7jJXtcl5GPqr546J+i4vz+GRrR98WkbqKLBD7\nzGpMcH6U9U1y3a1SQKghoegU4VDqdKzQhAuxPHoc8tO4Udvs2kkdcIMVStFz36TC\ntdMvaFg9NFVdN7e5Jyo0Lxdm2HtQe7JJ9dcuV1FH31PeX6J6wfYeZFxh8BWbgA5M\nbvEvbb/GvFP3GLALtfz+qrpUtwuV4Rp8JeTt6Pb81GYB0EJSd3EVp3C93Puzzo7F\n+dMFA5oPClrVu2YnAS7SBTY0yxx+0Pj/q+8pv+eAWzpRWGq039ckcC6jCQ2yYf6X\nq/4smjTdAgMBAAECggEAEjNOlkyA9lPnjOJlUfAiP4EykoGynclUBhbFN3QT5nqY\nsD7UHLWqqHahjba+IoeoYdXQK1kERm9iY5/VbMpn6bKj2ttuz7QxWHVR+lycOwkY\nfGkfsaxtE4e3p0QKmKbfh/GLpWt+TbEdqwC7ZgFPNK0FN9KcZfuYsNJrcQzYg355\nO02z/27dyCEXNFxPq3efkrmXsIUs5FZTiLLNv6yBwO2ktXKT6emcN/pd/VPnW9Ek\nBdXq5wICBK7Ze8ujbPH8SJd8UtIihIhe8daJJve6jTJwxQEuRqMakzD0oVwXwlXg\nyNgCwoJzePM+vbCfr4n3KOLHb0f2vXqmQmLCKNna9wKBgQDwSS2E6uoVJ7Ons+nL\n18jVZXK/LdzH1jqhLk66cq7RAVwdsbSgv28H1UoGbXkP++qAZo5kzY1iDex7nJ6+\nTDlaJwjvB9jyW+bqQY++kzvVBTSLyfUQrKB97RIWxMgnwRildw9u2yiS+sDQf6f4\nQ2wa3qoCHd79Yum/CCIeK4iJ9wKBgQDiBZD22l6KjbmORtkvupFcK6cJoZWeVnXy\nHRYEZ0WYT1cq887zbucV3zQJuJPNCRr3ScAsAriOOz7IJiwn3Xkn9RKGQAvC6+jZ\nqmNux0ssGhzuJXq9NOzTqra1+PuBmHgZT8wq9SKcgu4ADYA2VZpQcDZNkry98mLK\ny0CLco4iywKBgFfXCJLspcIyD1UhSjjAm6SXP4lwJKPRRwGhQhqazhmN27TnP9b7\n5IUCjdsnrfgP6bwiwa9MDYFpAah2qvl6OAUi+/sV7VM8EYBVk0zh2h+XlYv8ul/s\nG4etYM1+BoWx62ahzbyC1aRVkqMl56u0ShLQj2nSrbAHttelC4Pn+jQlAoGBAKot\nBrjWMdigXNWDAoOtNUTwmRPnVX+iGavxumIWX5AOLNNqPqeLGPKe28916dK2yFbo\ncIiyg8KTWPHZy+U4G8C6BPiPwEtC1E8Ou07tPuw1vRKRpZhQAQBdyLO6g6NP6R0l\nt9OgPi8ZZZkkkSRXz5hA5KIDmZhqp3eJEU/tMJeBAoGBAMR7j5OEOT9Su0CU1+Y3\n8AiCsZ3lLvzs/Mr/B4zz78oxDZqxhkI2gc3C0LQMAtspqu529MQ6BQ+5L/9M/Tgb\nqoWZoX5R/YNA3LXRtInba60b+awv+aGtyXvbczZlX0Oc8FqAX/pvtwMY62jA3aI3\ntfYRA/B6pzEWQDw2BJuvi1jp\n-----END PRIVATE KEY-----\n",
  "client_email": "expence-tracker@expence-tracker-400008.iam.gserviceaccount.com",
  "client_id": "111453760325396926307",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expence-tracker%40expence-tracker-400008.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';

static final  _spreadsheetId = '18gbevMoIiy5DrU2cZNVnPLiXHrupkEcqHuY7npdsiCY';

static final _gsheets = GSheets(_credentials);
static Worksheet? _worksheet;

 static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }


 static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
   // print(currentTransactions);
    
    loading = false;
  }
  
    static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

   static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }

}