import XCTest

final class NowPlayingMoviesUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func test_nowPlayingCardsAreVisible() throws {
        let movieCard = app.staticTexts["MovieCard_How to Train Your Dragon"]
        XCTAssertTrue(movieCard.waitForExistence(timeout: 5))
    }

    func test_nowPlayingCardsAreVisible_thenNavigable() throws {
        let movieCard = app.staticTexts["MovieCard_How to Train Your Dragon"]
        XCTAssertTrue(movieCard.waitForExistence(timeout: 5))
        movieCard.tap()
        let movieDetailTitle = app.staticTexts["MovieDetail_How to Train Your Dragon"]
        XCTAssertTrue(movieDetailTitle.exists)
    }
}
