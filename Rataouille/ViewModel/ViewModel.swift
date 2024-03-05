

import SwiftUI

class ViewModel: ObservableObject {
    @Published var meals: MealModelContainer = MealModelContainer(meals: [])
    @Published var categories: CategoryModelContainer = CategoryModelContainer(categories: [])
    @Published var ingredients: IngredientModelContainer = IngredientModelContainer(ingredients: [])
    @Published var areas: AreaModelContainer = AreaModelContainer(areas: [])
    
    @Published var mealAddedToCoreData: Bool = false
    @Published var searchAlternatives: [String] = []
    
    var allCategories: [String] = []
    var allIngredients: [String] = []
    var allAreas: [String] = []
    
    let apiClient = APIClient.live
    
    func updateSearchAlternatives(selectedEndpoint: SearchView.SearchEndpoint, searchText: String) {
        switch selectedEndpoint{
            case .mealCategory:
                searchAlternatives = allCategories.filter{ $0.lowercased().contains(searchText.lowercased()) }
                    
            case .mealArea:
                searchAlternatives = allAreas.filter{ $0.lowercased().contains(searchText.lowercased()) }
                    
            case .mealIngredient:
                searchAlternatives = allIngredients.filter{ $0.lowercased().contains(searchText.lowercased()) }
            
            default:
                searchAlternatives = []
        }
    }
    
    func getMeals() async {
        do{
            let apiMeals = try await apiClient.getMeals()
            DispatchQueue.main.async {
                self.meals = apiMeals
            }
        }catch {
            
            print("something went wrong with fetching meals: \(error)")
        }
    }
    
    func getCategories() async {
        do {
            let apiCategories = try await apiClient.getCategories()
            
            Task {
                let mappedCategories = apiCategories.categories.map { $0.strCategory }
                
                await MainActor.run {
                    self.categories = apiCategories
                    self.allCategories = mappedCategories
                }
            }
        } catch {
            print("Something went wrong with fetching category list")
        }
    }
    
    func getIngredients() async {
        do{
            let apiIngredients = try await apiClient.getIngredients()
            
            Task{
                let mappedIngredients = apiIngredients.ingredients.map{ $0.strIngredient }
                
                await MainActor.run{
                    self.ingredients = apiIngredients
                    self.allIngredients = mappedIngredients
                }
            }

        } catch {
            print("Something went wrong with fetching ingredient list")
        }
    }
    
    func getAreas() async {
        do{
            let apiAreas = try await apiClient.getAreas()

            Task{
                let mappedAreas = apiAreas.areas.map{ $0.strArea }
                
                await MainActor.run{
                    self.areas = apiAreas
                    self.allAreas = mappedAreas
                }
            }
            
        } catch {
            print("Something went wrong with fetching areas list")
        }
    }
    
    func filterByName(_ mealName: String) async {
        do {
            let filteredMeals = try await apiClient.filterByName(mealName)
            DispatchQueue.main.async {
                self.meals = filteredMeals
            }
        } catch {
            print("Name not found")
        }
    }
    
    
    func filterByCategories(_ mealCategory: String) async {
        do {
            let filteredMeals = try await apiClient.filterByCategories(mealCategory)
            if !filteredMeals.meals.isEmpty{
                DispatchQueue.main.async {
                    self.meals = filteredMeals
                }
            } else {
                print("No meals found for the specified area.")
            }

        } catch {
            print("Must have full area name")
        }
    }

        func filterByIngredients(_ ingredient: String) async {
            do {
                let filteredMeals = try await apiClient.filterByIngredients(ingredient)
                if !filteredMeals.meals.isEmpty{
                    DispatchQueue.main.async {
                        self.meals = filteredMeals
                    }
                }
                else {
                    print("No meals found for the specified ingredient.")
                }
            } catch {
                print("Must have full ingredient name")
            }
        }

        func filterByAreas(_ area: String) async {
            do {
                let filteredMeals = try await apiClient.filterByAreas(area)
                if !filteredMeals.meals.isEmpty {
                    DispatchQueue.main.async {
                        self.meals = filteredMeals
                    }
                } else {
                    print("No meals found for the specified area.")
                }
            } catch {
                print("Must have full area name")
            }
        }
    
    func filterById(_ id: String) async {
        do {
            let filteredMeals = try await apiClient.filterById(id)
            print("\(filteredMeals)")
            if !filteredMeals.meals.isEmpty {
                DispatchQueue.main.async {
                    self.meals = filteredMeals
                }
            } else {
                print("No meals found for the specified id.")
            }
        } catch {
            print("Something went wrong with filtering id: \(error)")
        }
    }
    
    func areaToFlag(_ mealArea: String) -> String {
        let areaNameToCountryCode: [String : String] = [
            "American": "US",
            "British": "GB",
            "Canadian": "CA",
            "Chinese": "CN",
            "Croatian": "HR",
            "Dutch": "NL",
            "Egyptian": "EG",
            "Filipino": "PH",
            "French": "FR",
            "Greek": "GR",
            "Indian": "IN",
            "Irish": "IE",
            "Italian": "IT",
            "Jamaican": "JM",
            "Japanese": "JP",
            "Kenyan": "KE",
            "Malaysian": "MY",
            "Mexican": "MX",
            "Moroccan": "MA",
            "Polish": "PL",
            "Portuguese": "PT",
            "Russian": "RU",
            "Spanish": "ES",
            "Thai": "TH",
            "Tunisian": "TN",
            "Turkish": "TR",
            "Unknown": "Unknown",
            "Vietnamese": "VN"
        ]
        return areaNameToCountryCode[mealArea] ?? "Unknown area"
    }
}
