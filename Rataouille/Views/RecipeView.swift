
import SwiftUI
import CoreData

struct RecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
    
    @FetchRequest(entity: MealEntity.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \MealEntity.name, ascending: true)
    ], predicate: NSPredicate(format: "isArchived == false"))
    
    private var meals: FetchedResults<MealEntity>
    
    
    func toggleFavourive (_ meal: MealEntity) {
        withAnimation {
            meal.isFavourite.toggle()
            try? viewContext.save()
        }
    }
    
    func saveMealToArchive (_ meal: MealEntity) {
        withAnimation{
            meal.isArchived = true
            meal.date = Date()
            try? viewContext.save()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                VStack{
                    ZStack{
                        Image("MainPageBackgroundImage")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                        
                        
                        Image("MainPageImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .offset(y: -80)
                    }
                }
                .frame(width: 260, height: 260)
                
                
                
                
                VStack{
                    if meals.isEmpty{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Image(systemName: "square.stack.3d.up.slash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                Text("No recipes saved")
                                    .font(Font.title3 .bold())
                                    .padding()
                            }
                            Spacer()
                        }
                        Spacer()
                    } else {
                        
                        List {
                            ForEach(meals, id: \.self){ meal in
                                HStack{
                                    AsyncImage(url: meal.imageURL, content: { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                            .shadow(radius: 5)
                                            .padding()
                                        
                                    }, placeholder: {
                                        VStack{
                                            Text("No image")
                                        }
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 5)
                                        .padding()
                                    })
                                    
                                    VStack(alignment: .leading){
                                        Text(meal.name ?? "No name")
                                            .font(.headline)
                                    }
                                    Spacer()
                                    if (meal.isFavourite){
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color.yellow)
                                    } else {
                                        EmptyView()
                                    }
                                    Label("", systemImage: "chevron.right")
                                }
                                .listRowSeparator(.visible, edges: .all)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .background(Color.Background)
                                .background(NavigationLink("", destination: RecipeDetailView(id: meal.id!)))
                                .swipeActions {
                                    Button{
                                        saveMealToArchive(meal)
                                        print(meal.isArchived)
                                    } label: {
                                        Image(systemName: "archivebox.fill")
                                            .padding(20)
                                    }
                                    .tint(Color.Primary)
                                }
                                .swipeActions(edge: .leading) {
                                    Button{
                                        toggleFavourive(meal)
                                    } label: {
                                        Image(systemName: "star.fill")
                                            .padding(20)
                                    }
                                    .tint(Color.yellow)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .background(Color(.Background))
        }
    }
}



struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
