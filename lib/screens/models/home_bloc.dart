
import 'package:money_tap_app/data/money_tap_repo.dart';
import 'package:money_tap_app/screens/models/HomeSectionModel.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final MoneyTapRepo _repository = MoneyTapRepo();
  final BehaviorSubject<HomeSectionModel> _subject =
  BehaviorSubject<HomeSectionModel>();

  getHomeSectionData(String searchtext) async {
    HomeSectionModel response = await _repository.getHomeSectionData(searchtext);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<HomeSectionModel> get subject => _subject;
}

final bloc = HomeBloc();
