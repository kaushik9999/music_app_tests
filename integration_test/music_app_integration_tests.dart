
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:music_app/main.dart' as app;
import 'package:music_app/main.dart';
import 'package:music_app/presentation/blocs/favorite_albums/bloc/favorite_albums_bloc.dart';
import 'package:music_app/presentation/widgets/album_widget.dart';


void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();



group('integration tests music app', () {

    testWidgets('tap on search icon, verify search icon', (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          final Finder searchIcon = find.byIcon(Icons.search);
          expect(searchIcon, findsOneWidget);// Verify Search Icon's Presence
          await tester.tap(searchIcon);
          await tester.pumpAndSettle();
          final Finder textBox = find.byKey(const ValueKey('searchInput'));
          await tester.enterText(textBox, 'test');
          await tester.pumpAndSettle();
          expect(find.text('test'), findsOneWidget);// Verify Search Text
          bool keyBoardState = WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
          expect(keyBoardState, isTrue);// Verify Keyboard State
          await tester.testTextInput.receiveAction(TextInputAction.done);//Close Keyboard
          await tester.pumpAndSettle();
          await tester.pump(const Duration(milliseconds: 1000));
          keyBoardState = WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
          expect(keyBoardState, isFalse);// Verify keyboard state
          await tester.pump(const Duration(milliseconds: 1000));
          await tester.tap(searchIcon);
          await tester.pumpAndSettle();
          final Finder testTxt = find.text('Testament');
          await tester.tap(testTxt);
          await tester.pumpAndSettle();
          final Finder favButton = find.byKey(const ValueKey('FavButton'));
          //await tester.tap(favButton.first);
          //await tester.tap(favButton.last);
          Iterator<Element> i =favButton.allCandidates.iterator;
          while(i.moveNext()){
                      for (int j = 1; j < 5; j++) {
                            await tester.tap(favButton.at(j));// Mark favorites
                      }
                      break;
          }
          await tester.pumpAndSettle();
          Finder backButton = find.byTooltip('Back');
          await tester.tap(backButton);
          await tester.pumpAndSettle();
          await tester.tap(backButton);
          await tester.pumpAndSettle();
          expect(find.text('Painkiller'), findsOneWidget);// Verify Album exists Text
          expect(find.text('Screaming for Vengeance'), findsOneWidget);// Verify Album exists Text
          expect(find.text('Angel Of Retribution'), findsOneWidget);// Verify Album exists Text
          expect(find.text('Defenders of the Faith'), findsOneWidget);// Verify Album exists Text

    });

  });
}