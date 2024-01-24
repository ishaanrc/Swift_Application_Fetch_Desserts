//
//  ContentView-ViewModel.swift
//  FetchCodingChallenge
//
//  Created by Ishaan Rc on 1/23/24.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var meals = [Meal]()
        @Published private(set) var sortedMeals = [Meal]()
        @Published var selectedMeal: Meal?
        func loadMealData() async {
            guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                      //Randomize and sort again
                if let decodedMealResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                    meals = decodedMealResponse.meals
                    let randomizedMeals = meals.shuffled()
                    sortedMeals = randomizedMeals.sorted(by: { $0.strMeal < $1.strMeal })
                }
            } catch {
                print("Invalid data")
            }
        }
    }
}
