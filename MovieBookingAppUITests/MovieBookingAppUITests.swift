//
//  MovieBookingAppUITests.swift
//  MovieBookingAppUITests
//
//  Created by Ye linn htet on 6/24/22.
//

import XCTest

class MovieBookingAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_login_withIncorrectPassword_shouldShowErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["get_started_button"].tap()
        
        let emailTxtField = app.scrollViews.otherElements.textFields["email_txtField"]
        emailTxtField.tap()
        emailTxtField.typeText("corae@gmail.com")
        
        let pwdTxtField = app.scrollViews.otherElements.secureTextFields["password_txtField"]
        pwdTxtField.tap()
        pwdTxtField.typeText("123")
        
        emailTxtField.tap()
        app.buttons["confirm_button"].tap()
        
        let errorView = app.otherElements["error_view"]
        XCTAssert(errorView.waitForExistence(timeout: 5))
        
    }
    
    func test_login_withNoInputData_shouldShowErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["get_started_button"].tap()
        
        app.buttons["confirm_button"].tap()
        
        let errorView = app.otherElements["error_view"]
        XCTAssertTrue(errorView.exists)
    }
    
    
    func test_login_withNoEmailInput_shouldShowErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["get_started_button"].tap()

        let emailTxtField = app.scrollViews.otherElements.textFields["email_txtField"]
        
        let pwdTxtField = app.scrollViews.otherElements.secureTextFields["password_txtField"]
        pwdTxtField.tap()
        pwdTxtField.typeText("123")
        
        emailTxtField.tap()
        app.buttons["confirm_button"].tap()
        
        let errorView = app.otherElements["error_view"]
        XCTAssertTrue(errorView.exists)
    }
    
    func test_login_withNoPasswordInput_shouldShowErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["get_started_button"].tap()
        
        let emailTxtField = app.scrollViews.otherElements.textFields["email_txtField"]
        emailTxtField.tap()
        emailTxtField.typeText("corae@gmail.com")
        
        let pwdTxtField = app.scrollViews.otherElements.secureTextFields["password_txtField"]
        pwdTxtField.tap()
        
        emailTxtField.tap()
        app.buttons["confirm_button"].tap()
        
        let errorView = app.otherElements["error_view"]
        XCTAssertTrue(errorView.exists)
    }
    
    
    func test_login_withInvalidEmail_shouldShowErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["get_started_button"].tap()
        
        let emailTxtField = app.scrollViews.otherElements.textFields["email_txtField"]
        emailTxtField.tap()
        emailTxtField.typeText("corae")
        
        let pwdTxtField = app.scrollViews.otherElements.secureTextFields["password_txtField"]
        pwdTxtField.tap()
        pwdTxtField.typeText("123456")
        
        emailTxtField.tap()
        app.buttons["confirm_button"].tap()
        
        let errorView = app.otherElements["error_view"]
        XCTAssertTrue(errorView.exists)
    }
    
    
    func test_login_withValidInputData_shouldRouteToHome() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["get_started_button"].tap()
        
        let emailTxtField = app.scrollViews.otherElements.textFields["email_txtField"]
        emailTxtField.tap()
        emailTxtField.typeText("corae@gmail.com")
        
        let pwdTxtField = app.scrollViews.otherElements.secureTextFields["password_txtField"]
        pwdTxtField.tap()
        pwdTxtField.typeText("123456")
        
        emailTxtField.tap()
        app.buttons["confirm_button"].tap()
        
        let searchBtn = app.buttons["search_button"]
        XCTAssert(searchBtn.waitForExistence(timeout: 5))
    }
    
}
