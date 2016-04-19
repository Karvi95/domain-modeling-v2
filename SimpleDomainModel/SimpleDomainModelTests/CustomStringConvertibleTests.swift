//
//  CustomStringConvertibleTests.swift
//  SimpleDomainModel
//
//  Created by iGuest on 4/17/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class CustomStringConvertibleTests: XCTestCase {
    func testMoneyDescription() {
        let twelveUSD = Money(amount: 12, currency: "USD")
        XCTAssert(twelveUSD.description == "USD12.0")
    }
    
    func testFirstJobDescription1() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Guest Lecturer makes $1000")
    }
    
    func testSecondJobDescription() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.description == "Janitor's rate is 15.0")
    }
    
    func testPersonDescription() {
        let arvind = Person(firstName: "Arvind", lastName: "Krish", age: 31)
        arvind.job = Job(title: "Rich", type: Job.JobType.Salary(10000000000))
        XCTAssert(arvind.description == "[Person: firstName:Arvind lastName:Krish age:31 job:Rich spouse:None]")
    }

    func testFamilyDescription() {
        let arvind = Person(firstName: "Arvind", lastName: "Krish", age: 31)
        arvind.job = Job(title: "Rich", type: Job.JobType.Salary(10000000000))
        
        let test = Person(firstName: "aFirstName", lastName: "aLastName", age: 31)
        
        let family = Family(spouse1: arvind, spouse2: test)
        
        let child = Person(firstName: "child'sFirstName", lastName: "child'sLastName", age: 18)
        child.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        
        family.haveChild(child)
        XCTAssert(family.description == "This family is comprised of: Arvind Krish, aFirstName aLastName, child'sFirstName child'sLastName. They make: $10000011000.")
    }
}
