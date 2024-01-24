//
//  ContentView.swift
//  FetchCodingChallenge
//
//  Created by Ishaan Rc on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.sortedMeals, id: \.idMeal) { meal in
                HStack {
                    AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.trailing, 8)

                    Button(action: {
                        viewModel.selectedMeal = meal
                    }) {
                        Text(meal.strMeal)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 75)
            .task {
                await viewModel.loadMealData()
            }
            .sheet(item: $viewModel.selectedMeal) { meal in
                DetailView(meal: meal)
                    .presentationDetents([.medium, .large])
            }
            .navigationTitle("Dessert Recipes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
