//
//  ViewCoordinator.swift
//  Rataouille
//
//  Created by Trym Træen on 16/11/2023.
//

import SwiftUI

struct ViewCoordinator: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            RecipeView()
        } else {
            SplashView(isActive: $isActive)
        }
    }
}

struct ViewCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        ViewCoordinator()
    }
}
