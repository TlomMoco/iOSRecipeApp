
import Foundation

struct MealModelContainer: Decodable {
    let meals: [MealModel]
}

struct MealModel: Decodable, Identifiable {
    
    enum MealModelError: Error {
        case invalidIngredientKey
        case invalidMeasurementKey
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strCategory
        case strArea
        case strInstructions
        case strMealImage = "strMealThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"

        case measurement1 = "strMeasure1"
        case measurement2 = "strMeasure2"
        case measurement3 = "strMeasure3"
        case measurement4 = "strMeasure4"
        case measurement5 = "strMeasure5"
        case measurement6 = "strMeasure6"
        case measurement7 = "strMeasure7"
        case measurement8 = "strMeasure8"
        case measurement9 = "strMeasure9"
        case measurement10 = "strMeasure10"
        case measurement11 = "strMeasure11"
        case measurement12 = "strMeasure12"
        case measurement13 = "strMeasure13"
        case measurement14 = "strMeasure14"
        case measurement15 = "strMeasure15"
        case measurement16 = "strMeasure16"
        case measurement17 = "strMeasure17"
        case measurement18 = "strMeasure18"
        case measurement19 = "strMeasure19"
        case measurement20 = "strMeasure20"
    }
    
    let id: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealImage: String?
    var ingredients: [String]?
    var measurements: [String]?
    
    var imageURL: URL? {
        return URL(string: self.strMealImage!)
    }
    

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.strMeal = try values.decode(String.self, forKey: .strMeal)
        self.strCategory = try values.decodeIfPresent(String.self, forKey: .strCategory)
        self.strArea = try values.decodeIfPresent(String.self, forKey: .strArea)
        self.strInstructions = try values.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strMealImage = try values.decodeIfPresent(String.self, forKey: .strMealImage)
        
        self.ingredients = []
        self.measurements = []
        
        
        try (1...20).forEach{ i in
            let ingredientKeyRawValue = "strIngredient\(i)"
            let measurementKeyRawValue = "strMeasure\(i)"
            
            guard let ingredientKey = CodingKeys(rawValue: ingredientKeyRawValue) else {
                throw MealModelError.invalidIngredientKey
            }
            
            guard let measurementKey = CodingKeys(rawValue: measurementKeyRawValue) else {
                throw MealModelError.invalidMeasurementKey
            }
            
            do {
                let ingredient = try values.decodeIfPresent(String.self, forKey: ingredientKey) ?? ""
                let measurement = try values.decodeIfPresent(String.self, forKey: measurementKey) ?? ""
                
                guard !ingredient.isEmpty && !measurement.isEmpty else { return }
                
                self.ingredients?.append(ingredient)
                self.measurements?.append(measurement)
                
            } catch {
                print("Error decoding ingredient or measurement: \(error)")
            }
        }
        
    }
}
