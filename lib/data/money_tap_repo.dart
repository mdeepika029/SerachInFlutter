

import 'package:money_tap_app/data/money_tap_api_provider.dart';
import 'package:money_tap_app/screens/models/HomeSectionModel.dart';

class MoneyTapRepo {
  MoneyTapAPiProvider _aPiProvider = MoneyTapAPiProvider();

  Future<HomeSectionModel> getHomeSectionData(String searchtext) {
    return _aPiProvider.getHomeSectionData(searchtext);
  }

}
