//
//  Item.swift
//  ShoppingList
//
//  Created by Amy Alsaydi on 7/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct Item: Hashable {
    let name: String
    let price: Double
    let category: Category
    let identifier = UUID()
    
    // implement the hasbable property for item
    // Hasher is the hash function in Swift
    // if we dont implement this function it makes all properties hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier) // make it hashable using the identifier property 
    }
    
    // create test data
    
    static func testData() -> [Item] {
     return [
      Item(name: "Polar Bluetooth Stride Sensor", price: 140.00, category: .running),
      Item(name: "DonJoy Performance POD Ankle Brace", price: 55.66, category: .running),
      Item(name: "Cracking the Coding Interview", price: 26.99, category: .education),
      Item(name: "The Pragmatic Programmer", price: 42.35, category: .education),
      Item(name: "Tri shoes", price: 120.00, category: .triathlon),
      Item(name: "Tri suit", price: 240.00, category: .triathlon),
      Item(name: "Towel hooks", price: 50.00, category: .household),
      Item(name: "Beginner Microscope STEM Kit", price: 39.99, category: .education),
      Item(name: "Fitbit Versa 2", price: 199.95, category: .technology),
      Item(name: "BISSELL Cleanview Swivel Pet", price: 99.99, category: .household),
      Item(name: "Ninja Professional", price: 89.99, category: .household),
      Item(name: "Debrox Swimmer's Ear", price: 7.99, category: .health),
      Item(name: "Tylenol Extra Strength", price: 9.47, category: .health)
     ]
    }
    
    
}
