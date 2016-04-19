//
//  CustomStringConvertibleTests.swift
//  SimpleDomainModel
//
//  Created by iGuest on 4/17/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class CustomStringConvertibleTests: XCTestCase {
    func MoneyDescriptionTest() {
        let twelveUSD = Money(amount: 12, currency: "USD")
        XCTAssert(twelveUSD.description == "GBP12.0")
    }
    
    func JobDescriptionTest() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Guest Lecturer, $1000")
    }
    
    func PersonDescriptionTest() {
        let arvind = Person(firstName: "Arvind", lastName: "Krish", age: 31)
        arvind.job = Job(title: "Rich", type: Job.JobType.Salary(10000000000))
        XCTAssert(arvind.description == "[Person: firstName:Arvind lastName:Krish age:21 job:Rich spouse:nil]")
    }
    
    func FamilyDescriptionTest() {
        let arvind = Person(firstName: "Arvind", lastName: "Krish", age: 31)
        arvind.job = Job(title: "Rich", type: Job.JobType.Salary(10000000000))
        
        let test = Person(firstName: "aFirstName", lastName: "aLastName", age: 31)
        
        let family = Family(spouse1: arvind, spouse2: test)
        
        let child = Person(firstName: "child'sFirstName", lastName: "child'sLastName", age: 18)
        child.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        
        family.haveChild(child)
        XCTAssert(family.description == "This family is comprised of: Arvind Krish, aFirstName aLastName, child'sFirstName child'sLastName. They make $10000011000.")
    }
}
