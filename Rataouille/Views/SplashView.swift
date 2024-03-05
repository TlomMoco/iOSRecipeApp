
import SwiftUI

struct SplashView: View {
    
    @State private var scale = 1.5
    @State private var offsetYAxis: CGFloat = 0.0
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack{
            VStack{
                Image("FoodBackground")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .frame(width: 650, height: 1200)
                    .offset(y: offsetYAxis)
            }

            VStack{
                Image("SplashScreenImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(20)
                    .background(
                        Circle()
                            .fill(Color.Primary)
                            .shadow(radius: 10)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                            )
                    )

                VStack{
                    Text("Ratatouille Food App")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .overlay(
                            Text("Ratatouille Food App")
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundColor(.Primary)
                                .padding(.top, 10)
                                .offset(x: 2.5, y: 2.5)
                        )

                }
                
            }

            .scaleEffect(scale)
            .onAppear{
                withAnimation(.easeIn(duration: 0.7)) {
                    self.scale = 1.0
                }
                withAnimation(Animation.linear(duration: 4)) {
                       self.offsetYAxis = 150
                   }
            }

        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isActive: .constant(false))
    }
}
