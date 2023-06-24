//
//  WelcomeView.swift
//  Totally Cats
//
//  Created by Jon Salkin on 6/23/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isAnimating = false
    
    var body: some View {
        TabView {
            welcomeTab()
                .tabItem {
                    Label("Catwalk", systemImage: "pawprint.fill")
                }
            
            CatView(catFactsManager: CatFactsManager())
                .tabItem {
                    Label("Cat Facts", systemImage: "info.bubble.fill")
                }
        }
        
    }
        func welcomeTab() -> some View {
            VStack {
                ZStack {
                    
                    LinearGradient(
                        colors: [.orange, .white],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    VStack {
                        Image("catHeader")
                            .resizable()
                            .scaledToFit()
                    }
                    .offset(y: -350)
                    
                    VStack {
                        Image("paw")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                        
                        Spacer()
                        
                        if isAnimating {
                            AnimatedImageView()
                        }
                    }
                    
                    EmptyView()
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 280.0, height: 255.0)
                                .foregroundColor(Color(UIColor.white))
                                .shadow(color: .pink, radius: 3, x: -2, y: 2)
                                .offset(y: 55)
                                .opacity(0.7)
                            
                            VStack {
                                Text("\n\nWelcome\nto\nTotally Cats\n")
                                    .font(Font.custom("Noteworthy", size: 55))
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                                    .bold()
                            }
                            
                        }
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 250.0, height: 130.0)
                                    .foregroundColor(Color(UIColor.white))
                                    .shadow(color: .pink, radius: 3, x: -2, y: 2)
                                    .offset(y: 5)
                                    .opacity(0.7)
                                
                                Text("Learn fun cat facts.\nListen to meows.\nIncrease your cat joy.")
                                    .font(Font.custom("Noteworthy", size: 25))
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 5)
                                    .bold()
                                    .frame(alignment: .center)
                            }
                        }
                    
                }
                .onAppear {
                    isAnimating = true
                }
            }
        }
    }
    
    struct AnimatedImageView: UIViewRepresentable {
        typealias UIViewType = UIImageView
        
        let allPaws: [UIImage] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29].compactMap { x in
            UIImage(named: "paw\(x)")
        }
        
        func makeUIView(context: Context) -> UIImageView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: 0, y: -400, width: 600, height: 1000)
            
//            imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
            imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
//            imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            
            imageView.animationImages = allPaws
            imageView.animationDuration = 9
            imageView.startAnimating()
            return imageView
        }
        
        func updateUIView(_ uiView: UIImageView, context: Context) {
            // No update necessary
        }
    }
    


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
