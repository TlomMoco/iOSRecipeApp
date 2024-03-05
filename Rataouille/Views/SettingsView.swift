
import SwiftUI

struct SettingsView: View {
    
    @AppStorage("enableDarkMode") private var darkMode = false
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Settings")
                    .font(.title.bold())
                    .foregroundColor(.white)

                List {
                    Section {
                        NavigationLink(destination: EditAreaView()) {
                            Label("Edit areas", systemImage: "globe")
                        }
                        NavigationLink(destination: EditCategoryView()) {
                            Label("Edit categories", systemImage: "filemenu.and.selection")
                        }
                        NavigationLink(destination: EditIngredientView()) {
                            Label("Edit ingredients", systemImage: "fork.knife.circle")
                        }
                    }

                    Section {
                        Toggle(isOn: $darkMode) {
                            HStack{
                                Image(systemName: "moon.circle")
                                Text("Enable dark mode")
                            }
                        }
                    }

                    NavigationLink(destination: ArchiveView()) {
                        Label("Manage archive", systemImage: "archivebox.circle")
                    }
                }
            }
            .background(Color.Primary)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
