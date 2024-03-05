
import SwiftUI

struct RecipeDetailView: View {
    let id: String
    @StateObject private var viewModel = ViewModel()
    

    
    var body: some View {

        ScrollView{
            ForEach(viewModel.meals.meals) { meal in
                VStack{
                    VStack{
                        AsyncImage(url: meal.imageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                            
                        } placeholder: {
                            VStack{
                                Text("No image.")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                        VStack{
                            Text(meal.strMeal)
                                .font(.system(.largeTitle, design: .serif))
                                .fontWeight(.bold)
                                .padding(.top, 10)
                                .foregroundColor(Color.Primary)
                                .multilineTextAlignment(.center)
                            
                            AreaImage(countryCode: viewModel.areaToFlag(meal.strArea ?? "No area"))
                                .frame(width: 48, height: 48)
                                .shadow(color: Color.Primary, radius: 15)
                            
                            Text(meal.strArea ?? "no area")
                                .padding(.vertical, 7)
                                .foregroundColor(Color.Tertiary)
                        }
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                    .clipped()
                    .shadow(radius: 10)
                    
                    
                    Label("", systemImage: "chevron.down")
                        .padding()
                        .foregroundColor(Color.Primary)
                    
                    
                    Text("Ingredients")
                        .font(.system(.title, design: .serif))
                        .fontWeight(.bold)
                        .foregroundColor(Color.Primary)
                        .padding(.bottom, 10)

                    
                    HStack{
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(meal.ingredients ?? [], id: \.self) { ingredient in
                                Text(ingredient)
                                Divider()
                            }
                        }
                        VStack(alignment: .trailing, spacing: 5){
                            ForEach(meal.measurements ?? [], id: \.self){ measurement in
                                Text(measurement)
                                Divider()

                            }
                        }
                    }
                    .padding()

                    
                    Text("Instructions:")
                        .font(.system(.title, design: .serif))
                        .fontWeight(.bold)
                        .foregroundColor(Color.Primary)
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading){

                        VStack{
                            Text(meal.strInstructions ?? "no instructions")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(Color.Primary)
                        .cornerRadius(16)

                    }.padding(10)
                }
                .background(Color.Background)

            }
        }
        .background(.white)
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.top)
        .onAppear{
            Task{
                await viewModel.filterById(id)
            }
        }
        
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(id: "52772")
    }
}
