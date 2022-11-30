# Info: 

I created 2 test suites one with the Flutter Driver and the other with intergation_test.


The Flutter driver one is under folder test_driver.
The integration_test one is under integration_test folder.

# What the test is doing 

# Test steps Flutter Driver Tests
1. Launch the app, verfiy the title and Home page text.
2. Search for Text 'test'
3. Pick an Artist and Verify
4. Mark one of the album as favorites.
5. Verify this almum is being added to the homepage by going back.
6. UnMark the same album as Favorite. 
7. Verify the Unmarked Favorite album disappears from the HomePage.

# Test steps Flutter Widget Integration Test

1. Launch the App.
2. Search for artist.
3. Pick an artist.
4. Mark multiple albums as Favorites.
5. Go back to Home page and Verify the Favorites are added.

# EXECUTION DETAILS 

1. Clone the repo.
2. Do **'Flutter Pub Get'**.
3.**'flutter driver --target=test_driver/app.dart'** run Flutter Driver tests.
4.**'flutter test integration_test/music_app_integration_tests.dart'** run the widget integration tests.

