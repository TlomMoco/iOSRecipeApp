
import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var categoryDescription: String?
    @NSManaged public var image: String?

}

extension Category : Identifiable {

}
