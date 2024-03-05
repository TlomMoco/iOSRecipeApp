
import SwiftUI
import Nuke

struct AreaImage: View {
    let countryCode: String
    
    
    var body: some View {
        AsyncImage(url: URL(string: "https://flagsapi.com/\(countryCode)/flat/48.png")){ image in
            switch image{
                case .empty:
                    VStack{
                        Text("Loading...")
                    }
                
                case .success(let image):
                    image
                    .resizable()
                    .scaledToFit()
                
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                
                default:
                    EmptyView()
            }
        }
    }
}

struct AreaImage_Previews: PreviewProvider {
    static var previews: some View {
        AreaImage(countryCode: "IT")
    }
}
