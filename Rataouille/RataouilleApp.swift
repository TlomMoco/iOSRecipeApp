
import SwiftUI

@main
struct RataouilleApp: App {
    
    @State private var isActive: Bool = false
    @AppStorage("enableDarkMode") private var isDarkMode = false
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if isActive {
                TabView{
                    RecipeView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .tabItem {
                            Label("My recipes", systemImage: "fork.knife.circle")
                        }
                    SearchView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass.circle")
                        }
                    
                    SettingsView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.circle")
                        }
                }
                .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                SplashView(isActive: $isActive)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }

        }
    }
    
    var splashScreenIsActive: Bool {
        return false
    }
    
    func firstLaunch() -> Bool {
        return false
    }
}
