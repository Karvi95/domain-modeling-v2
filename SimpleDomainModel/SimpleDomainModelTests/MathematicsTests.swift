//
//  MathematicsTests.swift
//  SimpleDomainModel
//
//  Created by iGuest on 4/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class MathematicsTests: XCTestCase {
    func testAddingOperatorCorrectAmount() {
        let tenUSD = Money(amount: 10, currency: "USD")
        let fiveYEN = Money(amount: 5, currency: "YEN")
        
        let result = tenUSD + fiveYEN
        XCTAssert(result.amount == 1095)
    }
    
    func testAddingOperatorCorrectCurrency() {
        let tenUSD = Money(amount: 10, currency: "USD")
        let fiveYEN = Money(amount: 5, currency: "YEN")
        
        let result = tenUSD + fiveYEN
        XCTAssert(result.currency == "YEN")
    }
    
    func testMinusingOperatorCorrectAmount() {
        let onesixthreefiveYEN = Money(amount: 1635, currency: "YEN")
        let tenUSD = Money(amount: 10, currency: "USD")
        
        let result = onesixthreefiveYEN - tenUSD
        XCTAssert(result.amount == 5)
    }
    
    func testMinusingOperatorCorrectCurrency() {
        let onesixthreefiveYEN = Money(amount: 1635, currency: "YEN")
        let tenUSD = Money(amount: 10, currency: "USD")
        
        let result = onesixthreefiveYEN - tenUSD
        XCTAssert(result.currency == "USD")
    }
}
