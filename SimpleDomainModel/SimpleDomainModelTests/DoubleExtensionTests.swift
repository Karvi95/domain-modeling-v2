//
//  DoubleExtensionTests.swift
//  SimpleDomainModel
//
//  Created by iGuest on 4/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class DoubleExtensionTests: XCTestCase {
    func testEURDefining() {
        let twoEUR = 2.0.EUR
        
        XCTAssert(twoEUR.amount == 2)
        XCTAssert(twoEUR.currency == "EUR")
    }
    
    func testEURAddingSame() {
        let twoEUR = 2.0.EUR
        let fiveEUR = 5.0.EUR
        
        let result = twoEUR + fiveEUR
        
        XCTAssert(result.amount == 7)
        XCTAssert(twoEUR.currency == "EUR")
    }
    
    func testEURMinusingDiff() {
        let twelveEUR = 12.0.EUR
        let twoGBP = 2.0.GBP
        
        let result = twelveEUR - twoGBP
        
        XCTAssert(result.amount == 2)
        XCTAssert(result.currency == "GBP")
    }
}
