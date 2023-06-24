//
//  Totally_CatsApp.swift
//  Totally Cats
//
//  Created by Jon Salkin on 6/22/23.
//

import SwiftUI

@main
struct Totally_CatsApp: App {
    
    init() {
        customizeTabBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
    
    func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        UITabBar.appearance().backgroundColor = UIColor.gray
        UITabBar.appearance().isTranslucent = true
        
        appearance.inlineLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        
        appearance.inlineLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        UITabBar.appearance().standardAppearance = appearance
        
    }
}
