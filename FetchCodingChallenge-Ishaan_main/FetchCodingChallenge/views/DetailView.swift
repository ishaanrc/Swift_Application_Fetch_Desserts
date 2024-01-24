//
//  DetailView.swift
//  FetchCodingChallenge
//
//  Created by Ishaan Rc on 1/23/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var meal: Meal

    @State private var ingredients = [String?]()
    @State private var measurements = [String?]()
    @State private var ingredientsList = [String]()
    @State private var mealDetail = MealDetail.example

    var body: some View {
        NavigationView {
            Form {
                Section("Finished Product") {
                    AsyncImage(url: URL(string: meal.strMealThumb), scale: 3.5) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView().progressViewStyle(.circular)
                    }
                }
                Section("Instructions") {
                    Text(mealDetail.strInstructions!.isEmpty ? "Loading..." : mealDetail.strInstructions!)
                }
                Section("Ingredients List") {
                    if ingredientsList.isEmpty {
                        Text("Loading...")
                    }
                    else {
                        List(ingredientsList, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle(meal.strMeal)
            .toolbar() {
                Button("Done") {
                    dismiss()
                }
            }
        }
        .task {
            await loadMealDetailData(id: meal.idMeal)
        }
    }

    init(meal: Meal) {
        self.meal = meal
    }
    
    func createIngredientsList() {
        for i in 0...19 {
            if !(ingredients[i] ?? "").isEmpty && !(measurements[i] ?? "").isEmpty {
                ingredientsList.append("\(ingredients[i]!): \(measurements[i]!)")
            }
        }
    }
    
    func loadIngredients() {
        ingredients.append(
            contentsOf:
                [
                    mealDetail.strIngredient1,
                    mealDetail.strIngredient2,
                    mealDetail.strIngredient3,
                    mealDetail.strIngredient4,
                    mealDetail.strIngredient5,
                    mealDetail.strIngredient6,
                    mealDetail.strIngredient7,
                    mealDetail.strIngredient8,
                    mealDetail.strIngredient9,
                    mealDetail.strIngredient10,
                    mealDetail.strIngredient11,
                    mealDetail.strIngredient12,
                    mealDetail.strIngredient13,
                    mealDetail.strIngredient14,
                    mealDetail.strIngredient15,
                    mealDetail.strIngredient16,
                    mealDetail.strIngredient17,
                    mealDetail.strIngredient18,
                    mealDetail.strIngredient19,
                    mealDetail.strIngredient20
                ])
    }
    
    func loadMeasurements() {
        measurements.append(
            contentsOf:
                [
                    mealDetail.strMeasure1,
                    mealDetail.strMeasure2,
                    mealDetail.strMeasure3,
                    mealDetail.strMeasure4,
                    mealDetail.strMeasure5,
                    mealDetail.strMeasure6,
                    mealDetail.strMeasure7,
                    mealDetail.strMeasure8,
                    mealDetail.strMeasure9,
                    mealDetail.strMeasure10,
                    mealDetail.strMeasure11,
                    mealDetail.strMeasure12,
                    mealDetail.strMeasure13,
                    mealDetail.strMeasure14,
                    mealDetail.strMeasure15,
                    mealDetail.strMeasure16,
                    mealDetail.strMeasure17,
                    mealDetail.strMeasure18,
                    mealDetail.strMeasure19,
                    mealDetail.strMeasure20
                ])
    }
            
    func loadMealDetailData(id: String) async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedMealDetailResponse = try? JSONDecoder().decode(MealDetailResponse.self, from: data) {
                mealDetail = decodedMealDetailResponse.meals[0]
                loadIngredients()
                loadMeasurements()
                createIngredientsList()
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(meal: Meal.example)
    }
}
