//
//  MoneyBuzzTests.swift
//  MoneyBuzzTests
//
//  Created by Consid  on 2022-11-21.
//

import XCTest
import Firebase
import FirebaseAuth
@testable import MoneyBuzz
import Combine


final class MoneyBuzzTests: XCTestCase {
    
    
    var stockViewModel = StockViewModel()
    var stockSearchViewModel = StockSearchViewModel()
    var newsDataViewModel = NewsDataViewModel()
    var loginViewViewModel = LoginViewViewModel()
    var companyOverviewViewModel = CompanyOverviewViewModel()
    var unitTestingViewModel = UnitTestViewModel()
    var cancellables = Set<AnyCancellable>()
    
    
    override func setUpWithError() throws {
        stockViewModel = StockViewModel()
        loginViewViewModel = LoginViewViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    
    
    func test_LoginViewViewModel_loginValidation_shouldBeTrue() {
        // Given
        let email1 = "Test@gmail.com"
        let password1 = "Testgmail1234"
        let email2 = "Test1@outlook.com"
        let password2 = "Password1"
        let email3 = "JohnDoe@student.ju.se"
        let password3 = "iOSDev123"
        
        // When
        let shouldBeTrue1 = loginViewViewModel.loginBool(email: email1, password: password1)
        let shouldBeTrue2 = loginViewViewModel.loginBool(email: email2, password: password2)
        let shouldBeTrue3 = loginViewViewModel.loginBool(email: email3, password: password3)
        
        // Then
        XCTAssertTrue(shouldBeTrue1)
        XCTAssertTrue(shouldBeTrue2)
        XCTAssertTrue(shouldBeTrue3)
        XCTAssertGreaterThanOrEqual(email1.count, 8)
        XCTAssertGreaterThanOrEqual(email2.count, 8)
        XCTAssertGreaterThanOrEqual(email3.count, 8)
        XCTAssertGreaterThanOrEqual(password1.count, 8)
        XCTAssertGreaterThanOrEqual(password2.count, 8)
        XCTAssertGreaterThanOrEqual(password3.count, 8)
    }
    
    func test_LoginViewViewModel_loginValidation_shouldBeFalse() {
        // Given
        let email1 = "Testgmail.com"
        let password1 = "testgmail1234"
        let email2 = "Test1@"
        let password2 = "password1"
        let email3 = ".ju.se"
        let password3 = "iOSDev"
        
        // When
        let shouldBeFalse1 = loginViewViewModel.loginBool(email: email1, password: password1)
        let shouldBeFalse2 = loginViewViewModel.loginBool(email: email2, password: password2)
        let shouldBeFalse3 = loginViewViewModel.loginBool(email: email3, password: password3)
        
        // Then
        XCTAssertFalse(shouldBeFalse1)
        XCTAssertFalse(shouldBeFalse2)
        XCTAssertFalse(shouldBeFalse3)
    }
    
    func test_LoginViewViewModel_loginValidation_PerformanceTest() throws{
        self.measure {
            for _ in 0..<100 {
                let email = "Test@gmail.com"
                let randomLength: Int = Int.random(in: 4..<20)
                let password = unitTestingViewModel.randomPasswordGeneration(length: randomLength )
                 _ = loginViewViewModel.loginBool(email: email, password: password)
            }
        }
    }
    
    
    func test_LoginViewViewModel_registerValidation_shouldBeTrue() {
        // Given
        let email1 = "Test@gmail.com"
        let password1 = "Password1"
        let email2 = "BestDeveloper@yahoo.com"
        let password2 = "ImAGoodDeveloper99"
        let email3 = "TestTestTest@Telia.se"
        let password3 = "email3MoreTests"
        
        // When
        let shouldBeTrue1 = loginViewViewModel.registerBool(email: email1, password: password1)
        let shouldBeTrue2 = loginViewViewModel.registerBool(email: email2, password: password2)
        let shouldBeTrue3 = loginViewViewModel.registerBool(email: email3, password: password3)
        
        // Then
        XCTAssertTrue(shouldBeTrue1)
        XCTAssertTrue(shouldBeTrue2)
        XCTAssertTrue(shouldBeTrue3)
        XCTAssertGreaterThanOrEqual(email1.count, 8)
        XCTAssertGreaterThanOrEqual(email2.count, 8)
        XCTAssertGreaterThanOrEqual(email3.count, 8)
        XCTAssertGreaterThanOrEqual(password1.count, 8)
        XCTAssertGreaterThanOrEqual(password2.count, 8)
        XCTAssertGreaterThanOrEqual(password3.count, 8)
    }
    
    func test_LoginViewViewModel_registerValidation_shouldBeFalse() {
        // Given
        let email1 = "Testgmail.com"
        let password1 = "testgmail1234"
        let email2 = "Test1@"
        let password2 = "password1"
        let email3 = ".ju.se"
        let password3 = "iOSDev"
        
        // When
        let shouldBeFalse1 = loginViewViewModel.loginBool(email: email1, password: password1)
        let shouldBeFalse2 = loginViewViewModel.loginBool(email: email2, password: password2)
        let shouldBeFalse3 = loginViewViewModel.loginBool(email: email3, password: password3)
        
        // Then
        XCTAssertFalse(shouldBeFalse1)
        XCTAssertFalse(shouldBeFalse2)
        XCTAssertFalse(shouldBeFalse3)
    }
    
    func test_LoginViewViewModel_registerValidation_PerformanceTest() throws{
        self.measure {
            for _ in 0..<100 {
                let email = "Test@gmail.com"
                let randomLength: Int = Int.random(in: 4..<20)
                let password = unitTestingViewModel.randomPasswordGeneration(length: randomLength )
                 _ = loginViewViewModel.loginBool(email: email, password: password)
            }
        }
    }
    
    func test_StockDataViewModel_validateTicker_shoulBeTrue() {
        // Given
        let ticker1 = "IBM"
        let ticker2 = "TSLA"
        let ticker3 = "AAPL"
        
        // When
        let shouldBeTrue1 = stockViewModel.validateTickerUnitTest(ticker: ticker1)
        let shouldBeTrue2 = stockViewModel.validateTickerUnitTest(ticker: ticker2)
        let shouldBeTrue3 = stockViewModel.validateTickerUnitTest(ticker: ticker3)
        
        // Then
        XCTAssertTrue(shouldBeTrue1)
        XCTAssertTrue(shouldBeTrue2)
        XCTAssertTrue(shouldBeTrue3)
        XCTAssertFalse(!shouldBeTrue1)
        XCTAssertFalse(!shouldBeTrue2)
        XCTAssertFalse(!shouldBeTrue3)
    }
    
    func test_StockDataViewModel_validateTicker_shoulBeFalse() {
        // Given
        let ticker1 = ""
        let ticker2 = "TESLA"
        let ticker3 = "123H"
        
        // When
        let shouldBeFalse1 = stockViewModel.validateTickerUnitTest(ticker: ticker1)
        let shouldBeFalse2 = stockViewModel.validateTickerUnitTest(ticker: ticker2)
        let shouldBeFalse3 = stockViewModel.validateTickerUnitTest(ticker: ticker3)
        
        // Then
        XCTAssertFalse(shouldBeFalse1)
        XCTAssertFalse(shouldBeFalse2)
        XCTAssertFalse(shouldBeFalse3)
        XCTAssertTrue(!shouldBeFalse1)
        XCTAssertTrue(!shouldBeFalse2)
        XCTAssertTrue(!shouldBeFalse3)
        XCTAssertNotNil(ticker1)
        XCTAssertNotNil(ticker2)
        XCTAssertNotNil(ticker3)
    }
    
    func test_StockDataViewModel_stockTickerValidation_PerformanceTest() throws{
        self.measure {
            for _ in 0..<100 {
                let stockTicker = unitTestingViewModel.randomTickerGeneration(length: 4)
                _ = stockViewModel.validateTickerUnitTest(ticker: stockTicker)
            }
        }
    }
    
    func test_DataService_validateURL_shoulBeTrue() {
        let stockTicker = "AAPL"
        let APIKEY = "LO58U5WZML3IIJNW"
        let shouldBeTrue = unitTestingViewModel.verifyUrl(urlString: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(stockTicker)&interval=5min&apikey=\(APIKEY)")
        
        XCTAssertTrue(shouldBeTrue)
    }
    
    func test_StockSearchService_validateURL_shoulBeTrue() {
        let searchString = "NFLX"
        let APIKEY = "SEDPQH2JNID6PTUC"
        let shouldBeTrue = unitTestingViewModel.verifyUrl(urlString: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(searchString)&apikey=\(APIKEY)")
        
        XCTAssertTrue(shouldBeTrue)
    }
    
    func test_NewsDataService_validateURL_shoulBeTrue() {
        let APIKEY = "MSR9qoqe2JhOMFWnspspaZrpVcL8CjNOD8ObkaLp"
        let shouldBeTrue = unitTestingViewModel.verifyUrl(urlString: "https://api.marketaux.com/v1/news/all?exchanges=NYSE%2CNASDAQ&api_token=\(APIKEY)")
        
        XCTAssertTrue(shouldBeTrue)
    }
    
    func test_CompanyOverviewDataService_validateURL_shoulBeTrue() {
        let stockTicker = "TSLA"
        let APIKEY = "O4D2DY1BZ05C62IX"
        let shouldBeTrue = unitTestingViewModel.verifyUrl(urlString: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=\(stockTicker)&apikey=\(APIKEY)")

        XCTAssertTrue(shouldBeTrue)
    }
    
    func test_CurrencyDataService_validateURL_shoulBeTrue() {
        let currencyFrom = "EUR"
        let currencyTo = "USD"
        let APIKEY = "LO58U5WZML3IIJNW"
        let shouldBeTrue = unitTestingViewModel.verifyUrl(urlString: "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(currencyFrom)&to_currency=\(currencyTo)&apikey=\(APIKEY)")

        XCTAssertTrue(shouldBeTrue)
    }
    
    func test_StockDataViewModel_loadDatafromAPI_performanceTest() {
        self.measure {
            for _ in 1..<100 {
                let stockTicker = "AAPL"
                stockViewModel.loadFAANGStocksData(for: stockTicker)
            }
        }
    }
    
    func test_NewsDataViewModel_loadDatafromAPI_performanceTest() {
        self.measure {
            for _ in 1..<100 {
                newsDataViewModel.loadNewsData()
            }
        }
    }
    
    func test_StockSearchViewModel_loadDatafromAPI_performanceTest() {
        self.measure {
            for _ in 1..<100 {
                let stockTicker = "AAPL"
                stockSearchViewModel.loadSearchResults(for: stockTicker)
            }
        }
    }
    
    func test_CompanyOverviewViewModel_loadDatafromAPI_performanceTest() {
        self.measure {
            for _ in 1..<100 {
                let stockTicker = "AAPL"
                companyOverviewViewModel.loadCompanyData(for: stockTicker)
            }
        }
    }
    
}

