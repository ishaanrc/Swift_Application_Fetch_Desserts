//
//  Meal.swift
//  FetchCodingChallenge
//
//  Created by Ishaan Rc on 1/24/24.
//

import Foundation

struct Meal: Codable, Identifiable, Equatable {

    var id: String { idMeal }
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
    static let example = Meal(idMeal: "53049", strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.idMeal == rhs.idMeal
    }
}
