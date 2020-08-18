import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FishReduxPage extends Page<fishReduxState, Map<String, dynamic>> {
  FishReduxPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<fishReduxState>(
              adapter: null, slots: <String, Dependent<fishReduxState>>{}),
          middleware: <Middleware<fishReduxState>>[],
        );
}
