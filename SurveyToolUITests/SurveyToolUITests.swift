//
//  SurveyUITests.swift
//  SurveyUITests
//
//  Created by Patryk Drozd on 21/01/2025.
//

import XCTest

final class SurveyToolUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--reset-database")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }

    func testAddSurveyAndPersist() throws {
        // Given
        let addButton = app.buttons["Add New Survey"]

        // When
        addButton.tap()

        let surveyTextField = app.textFields["Enter your survey question"]
        XCTAssertTrue(surveyTextField.waitForExistence(timeout: 2), "Survey text field should appear")
        surveyTextField.tap()
        surveyTextField.typeText("Persistence Test Survey")

        app.buttons["Save Survey"].tap()

        // Then
        let surveyCell = app.staticTexts["Persistence Test Survey"]
        XCTAssertTrue(surveyCell.waitForExistence(timeout: 2), "Newly added survey should appear in the list")

        // Close and Relaunch App
        app.terminate()
        app.launchArguments.removeAll()
        app.launch()

        // Verify Persistence
        XCTAssertTrue(surveyCell.waitForExistence(timeout: 2), "Survey should persist after app relaunch")
    }
    
    func testAddResponseAndPersist() throws {
        // Given
        addTestSurvey(named: "Response Persistence Test")
        let surveyCell = app.staticTexts["Response Persistence Test"]
        surveyCell.tap()

        // When
        let yesButton = app.buttons["Yes"]
        yesButton.tap()

        // Verify Response is Saved
        let yesPercentage = app.staticTexts["Yes: 1 (100.0%) | No: 0 (0.0%)"]
        XCTAssertTrue(yesPercentage.waitForExistence(timeout: 2), "Yes response should be recorded")

        // Close and Relaunch App
        app.terminate()
        app.launchArguments.removeAll()
        app.launch()

        // Verify Persistence
        let yesPercentageAfterRelaunch = app.staticTexts["Yes: 1 (100.0%) | No: 0 (0.0%)"]
        XCTAssertTrue(yesPercentageAfterRelaunch.waitForExistence(timeout: 2), "Response should persist after app relaunch")
    }

    private func addTestSurvey(named name: String) {
        let addButton = app.buttons["Add New Survey"]
        addButton.tap()

        let surveyTextField = app.textFields["Enter your survey question"]
        XCTAssertTrue(surveyTextField.waitForExistence(timeout: 2), "Survey text field should appear")
        surveyTextField.tap()
        surveyTextField.typeText(name)

        app.buttons["Save Survey"].tap()
    }
}
