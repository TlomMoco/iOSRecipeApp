
import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var selectedEndpoint: SearchView.SearchEndpoint
    var viewModel: ViewModel
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .padding(10)
                .background(Color(.systemGray3))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onChange(of: searchText) { newValue in
                    
                    Task {
                        switch selectedEndpoint {
                        case .mealCategory:
                            await viewModel.filterByCategories(newValue)

                        case .mealArea:
                            await viewModel.filterByAreas(newValue)
                            
                        case .mealIngredient:
                            await viewModel.filterByIngredients(newValue)

                        default:
                            await viewModel.filterByName(newValue)
                        }
                        
                        viewModel.updateSearchAlternatives(selectedEndpoint: selectedEndpoint, searchText: newValue)
                    }
                }

        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        SearchBar(searchText: .constant("Search..."), selectedEndpoint: .constant(.mealArea), viewModel: viewModel)
    }
}
