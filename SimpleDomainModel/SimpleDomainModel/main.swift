//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello World!")

public func testMe() -> String {
return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
    }
}


////////////////////////////////////
// CustomStringConvertible Protocol
//
protocol CustomStringConvertible {
    var description : String { get }
}


////////////////////////////////////
// Mathematics Protocol & Methods
//
protocol Mathematics {
    func + (left: Money, right: Money) -> Money
    func - (left: Money, right: Money) -> Money
}

func + (left: Money, right: Money) -> Money {
    if (left.currency != right.currency) {
        let converted = left.convert(right.currency)
        return Money(amount: (converted.amount + right.amount), currency: right.currency)
    } else {
        return Money(amount: (left.amount + right.amount), currency: right.currency)
    }
}

func - (left: Money, right: Money) -> Money {
    if (left.currency != right.currency) {
        let converted = left.convert(right.currency)
        return Money(amount: (converted.amount - right.amount), currency: right.currency)
    } else {
        return Money(amount: (left.amount - right.amount), currency: right.currency)
    }
}


////////////////////////////////////
// Double Extension
//
extension Double {
    var USD: Money {
        return Money(amount: Int(round(self)), currency: "USD")
    }
    var GBP: Money {
        return Money(amount: Int(round(self)), currency: "GBP")
    }
    var EUR: Money {
        return Money(amount: Int(round(self)), currency: "EUR")
    }
    var YEN: Money {
        return Money(amount: Int(round(self)), currency: "YEN")
    }
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
    
    public var amount : Int
    public var currency : String
    
    init(amount : Int, currency : String) {
        self.amount = amount
        self.currency = currency
    }
    
    public func convert(to: String) -> Money {
        if (self.currency == "USD" && to == "GBP") {
            return Money(amount: (self.amount / 2), currency: to)
        }
        else if (self.currency == "USD" && to == "EUR") {
            return Money(amount: ((3 * self.amount) / 2), currency: to)
        }
        else if (self.currency == "USD" && to == "CAN") {
            return Money(amount: (5 * (self.amount) / 4), currency: to)
        }
        else if (self.currency == "GBP" && to == "USD") {
            return Money(amount: (2 * self.amount), currency: to)
        }
        else if (self.currency == "GBP" && to == "EUR") {
            return Money(amount: (3 * self.amount), currency: to)
        }
        else if (self.currency == "GBP" && to == "CAN") {
            return Money(amount: (5 * (self.amount) / 2), currency: to)
        }
        else if (self.currency == "EUR" && to == "USD") {
            return Money(amount: ((2 * self.amount) / 3), currency: to)
        }
        else if (self.currency == "EUR" && to == "GBP") {
            return Money(amount: (self.amount / 3), currency: to)
        }
        else if (self.currency == "EUR" && to == "CAN") {
            return Money(amount: (5 * (self.amount) / 6), currency: to)
        }
        else if (self.currency == "CAN" && to == "USD") {
            return Money(amount: (4 * (self.amount) / 5), currency: to)
        }
        else if (self.currency == "CAN" && to == "GBP") {
            return Money(amount: (2 * (self.amount) / 5), currency: to)
        }
        else if (self.currency == "CAN" && to == "EUR") {
            return Money(amount: (6 * (self.amount) / 5), currency: to)
        }
        else if (self.currency == "USD" && to == "YEN") {
            return Money(amount: (109 * (self.amount)), currency: to)
        }
        else if (self.currency == "YEN" && to == "USD") {
            return Money(amount: ((self.amount) / 109), currency: to)
        }
        else {
            return Money(amount: (self.amount), currency: to)
        }
    }
  
    public func add(to: Money) -> Money {
        if (self.currency != to.currency) {
            let converted = self.convert(to.currency)
            return Money(amount: (converted.amount + to.amount), currency: to.currency)
        } else {
            return Money(amount: (self.amount + to.amount), currency: to.currency)
        }
    }
    public func subtract(from: Money) -> Money {
        if (self.currency != from.currency) {
            let converted = self.convert(from.currency)
            return Money(amount: (from.amount - converted.amount), currency: from.currency)
        } else {
            return Money(amount: (from.amount - self.amount), currency: from.currency)
        }
    }
    
    // CustomDescription
    public var description : String {
        get{
            return "\(self.currency)\(self.amount).0"
        }
    }
}

////////////////////////////////////
// Job
//
public class Job : CustomStringConvertible{
    public var title : String
    public var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
  
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
  
    public func calculateIncome(hours: Int) -> Int {
        switch self.type {
        case .Salary(let aSalary):
            return (aSalary)
        case .Hourly(let rate):
            return Int(Double(hours) * rate)
        }
    }
  
    public func raise(amt : Double) {
        switch self.type {
        case .Salary(let aSalary):
            self.type = Job.JobType.Salary(aSalary + Int(amt))
        case .Hourly(let rate):
            self.type = Job.JobType.Hourly(rate + amt)
        }
    }

    // CustomDescription
    public var description : String {
        get {
            switch self.type {
            case .Salary(let aSalary):
                return "\(self.title) makes $\(aSalary)"
            case .Hourly(let rate):
                return  "\(self.title)'s rate is \(rate)"
            }
        }
    }
}

////////////////////////////////////
// Person
//
public class Person : CustomStringConvertible {
  
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    
    private var myJob : Job?
    private var mySpouse : Person?

    public var job : Job? {
        get {
            return self.myJob
        }
        set(value) {
            if (self.age >= 16) {
                self.myJob = value
            } else {
                self.myJob = nil
            }
        }
    }
    
    public var spouse : Person? {
        get {
            return self.mySpouse
        }
        set(value) {
            if (self.age >= 18) {
                self.mySpouse = value
            } else {
                self.mySpouse = nil
            }
        }
    }
  
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    public func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]"
    }

    // CustomDescription
    var description : String {
        get {
            var myJob = "unemployed"
            if self.job != nil {
                myJob = self.job!.title
            }
            
            var mySpouse = "None"
            if self.spouse != nil {
                mySpouse = self.spouse!.firstName + self.spouse!.lastName
            }
            
            return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(myJob) spouse:\(mySpouse)]"
        }
    }
}

////////////////////////////////////
// Family
//
public class Family : CustomStringConvertible {
    private var members : [Person] = []
  
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
  
    public func haveChild(child: Person) -> Bool {
        var possible = false
        for i in 0..<members.count {
            if (members[i].age > 21) {
                possible = true
            }
        }
        if (possible) {
            members.append(child)
        }
        
        return possible
    }
  
    public func householdIncome() -> Int {
        var sum = 0
        for i in 0..<members.count {
            if (members[i].job != nil) {
                sum += members[i].job!.calculateIncome(2000)
            }
        }
        
        return sum
    }
    
    // CustomDescription
    var description : String {
        get {
            var descriptBase = "This family is comprised of: "
            descriptBase += members[0].firstName + " " + members[0].lastName
            for i in 1..<members.count {
                descriptBase += ", " + members[i].firstName + " " + members[i].lastName
            }
            descriptBase += ". They make: $\(self.householdIncome())."
            return descriptBase
        }
    }
}