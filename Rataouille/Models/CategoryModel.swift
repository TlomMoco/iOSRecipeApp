
import Foundation

struct CategoryModelContainer: Codable {
    let categories: [CategoryModel]
    
    enum CodingKeys: String, CodingKey{
        case categories = "meals"
    }
    
    init(categories: [CategoryModel]) {
        self.categories = categories
    }
}

struct CategoryModel: Codable {
    let strCategory: String
    
    enum CodingKeys: String, CodingKey {
        case strCategory
    }
}


