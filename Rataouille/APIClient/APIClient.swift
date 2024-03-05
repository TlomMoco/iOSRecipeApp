

import Foundation

struct APIClient {
    
    var getCategories: (() async throws -> CategoryModelContainer)
    var getMeals: (() async throws -> MealModelContainer)
    var getIngredients: (() async throws -> IngredientModelContainer)
    var getAreas: (() async throws -> AreaModelContainer)

    var filterByName: ((_ mealName: String) async throws -> MealModelContainer)
    var filterByCategories: ((_ mealCategory: String) async throws -> MealModelContainer)
    var filterByAreas: ((_ mealArea: String) async throws -> MealModelContainer)
    var filterByIngredients: ((_ mealIngredient: String) async throws -> MealModelContainer)
    var filterById: ((_ mealId: String) async throws -> MealModelContainer)
}

extension APIClient {
    
    static let live = APIClient(getCategories: {
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?c=list")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let categoriesResponse = try JSONDecoder().decode(CategoryModelContainer.self, from: data)
        
        let moc = PersistenceController.shared.container.viewContext
            
//        Looping through categories to put them in Category enitity
//        categoriesResponse.categories.forEach({ category in
//            let entity = Category(context: moc)
//            entity.name = category.strCategory
//        })
        
        return categoriesResponse
        
        
    }, getMeals: {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
                
        let mealsResponse = try JSONDecoder().decode(MealModelContainer.self, from: data)
        
        let moc = PersistenceController.shared.container.viewContext
        
        return mealsResponse
        
    }, getIngredients: {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?i=list")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let ingredientsResponse = try JSONDecoder().decode(IngredientModelContainer.self, from: data)
        
        let moc = PersistenceController.shared.container.viewContext
        
        return ingredientsResponse
        
    }, getAreas: {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?a=list")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let areasResponse = try JSONDecoder().decode(AreaModelContainer.self, from: data)
        
        let moc = PersistenceController.shared.container.viewContext
        
        return areasResponse
                
    }, filterByName: { name in
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(encodedName)")!

        let (data, response) = try await URLSession.shared.data(from: url)

        let mealsResponse = try JSONDecoder().decode(MealModelContainer.self, from: data)

        return mealsResponse
        
    }, filterByCategories: { category in
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(encodedCategory)")!

        let (data, response) = try await URLSession.shared.data(from: url)
        
        let mealsResponse = try JSONDecoder().decode(MealModelContainer.self, from: data)

        return mealsResponse
        
    }, filterByAreas: { area in
        let encodedArea = area.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(encodedArea)")!

        let (data, response) = try await URLSession.shared.data(from: url)

        let mealResponse = try JSONDecoder().decode(MealModelContainer.self, from: data)
        
        return mealResponse
        
    }, filterByIngredients: { ingredient in
        let encodedIngredient = ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(encodedIngredient)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)

        let mealResponse = try JSONDecoder().decode(MealModelContainer.self, from: data)
        
        return mealResponse
        
    }, filterById: { id in
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)

        let mealResponse = try JSONDecoder().decode(MealModelContainer.self, from: data)
        
        return mealResponse
        
    })
}
