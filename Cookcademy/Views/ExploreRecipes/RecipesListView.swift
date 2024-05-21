//
//  RecipesListView.swift
//  Cookcademy
//
//  Created by Austin Taylor on 5/12/24.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    @State private var isPresenting = false
    let category: MainInformation.Category
    
    let listBackgroundColor = AppColor.background
    let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle(navigationTitle)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        })
    }
}

extension RecipesListView {
  
  private var recipes: [Recipe] {
    recipeData.recipes(for: category)
  }
  
  private var navigationTitle: String {
    "\(category.rawValue) Recipes"
  }
}

struct RecipesListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      RecipesListView(category: .breakfast)
        .environmentObject(RecipeData())
    }
  }
}
