//
//  FetchCodingChallengeSlowTests.swift
//  FetchCodingChallengeTests
//
//  Created by Ishaan Rc on 1/23/24.
//

import XCTest
@testable import FetchCodingChallenge

final class FetchCodingChallengeSlowTests: XCTestCase {

    var sut: URLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testLoadMealDataApiCallGetsHTTPStatusCode200() throws {
        let urlString =
        "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        let url = URL(string: urlString)!

        let promise = expectation(description: "Status code: 200")

        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }

    func testLoadMealDetailDataApiCallGetsHTTPStatusCode200() throws {
        let urlString =
            "https://themealdb.com/api/json/v1/1/lookup.php?i=53049"
        let url = URL(string: urlString)!
        
        let promise = expectation(description: "Status code: 200")

        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
}
