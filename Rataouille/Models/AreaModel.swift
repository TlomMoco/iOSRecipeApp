
import Foundation

struct AreaModelContainer: Codable {
    let areas:[AreaModel]
    
    enum CodingKeys: String, CodingKey {
        case areas = "meals"
    }
    
    init(areas: [AreaModel]) {
        self.areas = areas
    }
}

struct AreaModel: Codable {
    let strArea: String
    
    enum CodingKeys: String, CodingKey {
        case strArea
    }
}
