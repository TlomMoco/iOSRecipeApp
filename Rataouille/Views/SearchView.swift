
import SwiftUI
import CoreData


struct SearchView: View {
    
    enum SearchEndpoint {
        case mealName
        case mealIngredient
        case mealCategory
        case mealArea
    }
    
    @StateObject private var viewModel = ViewModel()
    @State private var selectedEndpoint: SearchEndpoint = .mealName
    @State private var searchText: String = ""
    @State private var showAlert: Bool = false
    @State private var suggestionIsSelected: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    SearchBar(searchText: $searchText, selectedEndpoint: $selectedEndpoint, viewModel: viewModel)
                    
                    Picker("Select endpoint", selection: $selectedEndpoint) {
                        Text("All Meals")
                            .tag(SearchEndpoint.mealName)
                        Text("Category")
                            .tag(SearchEndpoint.mealCategory)
                        Text("Ingredients")
                            .tag(SearchEndpoint.mealIngredient)
                        Text("Area")
                            .tag(SearchEndpoint.mealArea)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(10)
                }
                
                ZStack(alignment: .top){
                    List(viewModel.meals.meals) { meal in
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
                                Text(meal.strMeal)
                                    .font(.headline)
                            }
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                        .listRowSeparator(.visible, edges: .all)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color.Background)
                        .background(NavigationLink("", destination: RecipeDetailView(id: meal.id)))
                        .swipeActions {
                            Button{
                                
                                let selectedMeal = meal
                                let moc = PersistenceController.shared.container.viewContext
                                
                                let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
                                request.predicate = NSPredicate(format: "id == \(selectedMeal.id)")
                                
                                do{
                                    let existingMealInDb = try moc.fetch(request)
                                    if let existingMealInDb = existingMealInDb.first{
                                        showAlert = true
                                        viewModel.mealAddedToCoreData = false
                                        
                                    } else {
                                        
                                        let newMeal = MealEntity(context: moc)
                                        
                                        newMeal.id = selectedMeal.id
                                        newMeal.name = selectedMeal.strMeal
                                        newMeal.area = selectedMeal.strArea
                                        newMeal.category = selectedMeal.strCategory
                                        newMeal.instructions = selectedMeal.strInstructions
                                        newMeal.image = selectedMeal.imageURL?.absoluteString
                                        newMeal.ingredients = selectedMeal.ingredients as? NSObject
                                        newMeal.measurements = selectedMeal.measurements as? NSObject
                                        newMeal.isArchived = false
                                        
                                        viewModel.mealAddedToCoreData = true
                                        
                                        do{
                                            try moc.save()
                                            print("Meal saved to CoreData!")
                                            
                                        } catch {
                                            print("Could not save to CoreData: \(error)")
                                        }
                                    }
                                } catch {
                                    print("Error fetching from CoreData when adding meal to my recipes")
                                }
                                
                            } label: {
                                Image(systemName: viewModel.mealAddedToCoreData ? "checkmark.circle.fill" : "fork.knife.circle")
                                    .padding(20)
                            }
                            .tint(viewModel.mealAddedToCoreData ? Color.green : Color.Primary)
                        }
                    }
                    .listStyle(.plain)
                    
                    if [.mealCategory, .mealIngredient, .mealArea].contains(selectedEndpoint){
                        List {
                            ForEach(viewModel.searchAlternatives, id: \.self) { suggestion in
                                Text(suggestion)
                                    .onTapGesture {
                                        searchText = suggestion
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                            suggestionIsSelected = true
                                        }
                                    }

                            }
                        }
                        .background(Color(.tertiarySystemBackground))
                        .listStyle(.plain)
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                        .frame(height: 200)
                        .opacity((searchText.isEmpty || suggestionIsSelected) ? 0 : 0.8)
                        .onChange(of: searchText) { text in
                            suggestionIsSelected = false
                        }
                    }
                }
            }
            .background(Color.Tertiary)
            .onAppear {
                Task.init {
                    await viewModel.getCategories()
                    await viewModel.getMeals()
                    await viewModel.getIngredients()
                    await viewModel.getAreas()
                }
            }
            .alert("Meal already added to your recipes", isPresented: $showAlert) {
                Button("Ok"){
                    showAlert = false
                }
            }
        }
        
        .navigationBarTitle("Search")
        .environmentObject(viewModel)
    }
}


struct SearchView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView()
    }
}
