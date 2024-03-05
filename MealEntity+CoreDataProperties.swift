
import Foundation
import CoreData


extension MealEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntity> {
        return NSFetchRequest<MealEntity>(entityName: "MealEntity")
    }

    @NSManaged public var area: String?
    @NSManaged public var category: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var ingredients: NSObject?
    @NSManaged public var instructions: String?
    @NSManaged public var measurements: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var isArchived: Bool
    @NSManaged public var date: Date?

}

extension MealEntity : Identifiable {
    var imageURL: URL? {
        guard let urlString = self.image, let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}
