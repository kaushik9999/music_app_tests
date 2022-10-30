import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Music App:', ()
  {
    final searchIcon = find.byValueKey('searchIcon');
    final searchTextFiled = find.byValueKey('searchInput');
    final homePageText = find.byValueKey("HomePageText");
    final appTitle = find.byValueKey("AppTitle");
    final artistCard = find.text('Testament');
    final albumName = find.byValueKey('AlbumName');
    final btnClose = find.byValueKey("FavButton");
    final favIcon = find.descendant(
      of: find.byValueKey('AlbumCard'),
      matching: find.byType('FavoriteButton'),
      firstMatchOnly: true,
    );


    // Below is a custom Method for Verifying the presence of an element
    Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver,
        {Duration timeout = const Duration(seconds: 1)}) async {
      Stopwatch s = Stopwatch();
      s.start();
      await driver.waitFor(finder, timeout: timeout);
      s.stop();
      if (s.elapsedMilliseconds >= timeout.inMilliseconds) {
        return false;
      } else {
        return true;
      }
    }

    // Driver declaration
    late FlutterDriver driver;

    //Group Start
    group('Music App', () {

      // Connect to the Flutter driver before running any tests. Set Up Method
      setUpAll(() async {
        driver = await FlutterDriver.connect();
        await driver.waitUntilFirstFrameRasterized();
      });

      // Close the connection to the driver after the tests have completed. - Tear Down Method
      tearDownAll(() async {
        driver.close();
      });

      test('Verify App Title ', () async {
        String text = await driver.getText(appTitle); //get App Title text
        expect(text, "Music App"); //Assertion - Verify App Title

      });

      test('Verify No Fav Albums found on HomePage', () async {
        String text = await driver.getText(
            homePageText); //tap on the searchIcon
        expect(text, "No Albums added yet"); //Assertion No Albums Yet Added text

      });

      test('Verify search icon presence and text entered', () async {
        await driver.tap(searchIcon); //tap on the searchIcon
        await driver.tap(searchTextFiled); //Tap on search text box for focus
        await driver.tap(searchTextFiled);// Tap on the search Icon
        await driver.enterText('test');// Enter text
        expect(await driver.getText(searchTextFiled), "test"); // Assertion Verify the text being entered

      });

      test("Verify artists card found after search and tap on it", () async {
        await driver.tap(searchIcon);
        await driver.waitFor(artistCard);
        await driver.tap(artistCard);
        expect(await driver.getText(find.descendant(
          of: find.byValueKey('AlbumCard'),
          matching: find.byValueKey('AlbumName'),
          firstMatchOnly: true,
        )), "British Steel"); // Verify first Album being found
      });

      test('Verify Fav album selection - Tap the first one as Fav', () async {
        await driver.tap(favIcon);
      });
      test('Verify selected Fav album being added to the Home Page', () async {
        await driver.tap(find.byTooltip('Back'));
        await driver.tap(find.byTooltip('Back'));
        expect(await driver.getText(albumName), "British Steel");// Verify the selected album exists on the Home Page
        bool exists = await isPresent(favIcon, driver);
        if (exists) {
          expect(true, isTrue);
        }
        else {
          expect(false, isTrue); // Verify Fav Icon on the Home Page
        }
      });
      test('Verify deselected Fav album disappears from HomePage', () async {
        await driver.tap(favIcon);
        await Future.delayed(const Duration(seconds: 10));
        bool exists1 = await isPresent(homePageText, driver);
        if (exists1) {
          expect(true, isTrue);
        }
        else {
          expect(false, isTrue);
        }
      });
    });
  });
}