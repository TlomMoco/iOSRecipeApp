
import Foundation

struct IngredientModelContainer: Codable {
    let ingredients: [IngredientModel]
    
    enum CodingKeys: String, CodingKey {
        case ingredients = "meals"
    }
    
    init(ingredients: [IngredientModel]) {
        self.ingredients = ingredients
    }
}

struct IngredientModel: Codable {
    let strIngredient: String
    
    enum CodingKeys: String, CodingKey {
        case strIngredient
    }
}

