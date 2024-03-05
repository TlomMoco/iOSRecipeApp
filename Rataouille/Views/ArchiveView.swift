
import SwiftUI
import CoreData

struct ArchiveView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()

    @FetchRequest(entity: MealEntity.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \MealEntity.name, ascending: true)
    ], predicate: NSPredicate(format: "isArchived == true"))
    
    private var meals: FetchedResults<MealEntity>
    
    @State private var selectedMeal: MealEntity?
    
    func deleteMealToArchive (_ meal: MealEntity) {
        withAnimation{
            meal.isArchived = false
            try? viewContext.save()
        }
    }
    
    func deleteMealFromCoreData (_ meal: MealEntity){
        withAnimation {
            viewContext.delete(meal)
            try? viewContext.save()
        }
    }
    
    var body: some View {
        VStack{
            Text("Archive")
                .font(.title .bold())
            
            VStack(alignment: .leading){
                Text("Recipes")
                    .fontDesign(.serif)
                    .foregroundColor(.gray)
                    .padding()
                
                List {
                    ForEach(meals, id: \.self){ meal in
                        HStack{
                            
                            VStack(alignment: .leading){
                                Text(meal.name ?? "No name")
                                    .font(.headline .bold())
                                Text("Category: \(meal.category ?? "No category")")
                                Text("Archived: \(meal.date?.description ?? "N/A")")
                                    .foregroundColor(Color.red)
                            }
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                        .listRowSeparator(.visible, edges: .all)
                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                        .padding()
                        .swipeActions {
                            Button{
                                deleteMealFromCoreData(meal)
                            } label: {
                                Image(systemName: "trash.fill")
                                    .padding(20)
                            }
                            .tint(Color.red)
                            Button{
                                deleteMealToArchive(meal)
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .padding(20)
                            }
                            .tint(Color.gray)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
    }
}
