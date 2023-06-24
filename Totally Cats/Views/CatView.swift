//
//  CatView.swift
//  Totally Cats
//
//  Created by Jon Salkin on 6/22/23.
//

import SwiftUI
import AVFoundation

struct CatView: View {
    @ObservedObject var catManager = CatImageManager()
    @State var cats: [CatImage]?
    @ObservedObject var catFactsManager: CatFactsManager
    @ObservedObject var meowViewModel = MeowsManager()
    
    init(catFactsManager: CatFactsManager) {
        self.catFactsManager = catFactsManager
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            LinearGradient(
                colors: [.orange, .white],
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
//            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            
            GeometryReader { geometry in
                HStack {
                    Image("catViewHeader")
                        .resizable()
                        .scaledToFit()
//                        .edgesIgnoringSafeArea(.top)
                        .offset(y: -400)
                } // catViewHeader HStack END
                
                Grid {
                    GridRow {
                        if let catUrl = cats?.first?.url {
                            AsyncImage(url: URL(string: catUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 400, height: 400, alignment: .top)
                                    .border(.gray)
                                    .shadow(color: .orange, radius: 5, x: -2, y: 1)
                                    .clipped()
                                    .offset(y: 100)
                                    .onTapGesture {
                                        Task {
                                            do {
                                                cats = try await catManager.getCatImage()
                                                try await catFactsManager.getCatFacts()
                                            } catch {
                                                print("Error getting cat data: \(error)")
                                            }
                                        }
                                    }
                            } placeholder: {
                                LoadingView()
                            }
                        } else {
                            LoadingView()
                                .task {
                                    do {
                                        cats = try await catManager.getCatImage()
                                        try await catFactsManager.getCatFacts()
                                    } catch {
                                        print("Error getting cat data: \(error)")
                                    }
                                }
                        }
                    }
                    .offset(y: -120)
                    // Cat Image GridRow END
                    
                    GridRow {
                        ForEach(catFactsManager.catFacts, id: \.self) { fact in
                            Text(fact.fact)
                                .font(Font.custom("Noteworthy", size: 20))
                                .multilineTextAlignment(.center)
                                .bold()
                                .offset(y: 10)
                                .frame(width: 400, height: 150, alignment: .top)
                                .onTapGesture {
                                    Task {
                                        do {
                                            cats = try await catManager.getCatImage()
                                            try await catFactsManager.getCatFacts()
                                        } catch {
                                            print("Error getting cat data: \(error)")
                                        }
                                    }
                                }
                        }
                    } // API CatFacts GridRow END
                    .onAppear {
                        Task {
                            do {
                                try await catFactsManager.getCatFacts()
                            } catch {
                                print("Error getting cat facts: \(error)")
                            }
                        }
                    } // onAppear for API CatFacts GridRow END.CONTINUED
                    
                    GridRow {
                        Button(action: {
                            refreshCatFacts()
                            meowViewModel.playMeow()
                            
                        }) {
                            Text("Meow")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.system(size: 30))
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.regular)
                        .offset(y: 70)
                    } // Button GridRow END
                    
                    //                } // VStack w/ 3 HStacks (Image, Facts, Button) END
                    
                } // ZStack Contains: LinearGradient and VStack w/ 3 VStacks END
            } // Geometry END
//            .frame(width: geometry.size.width, height: geometry.size.height)
//            .padding(.top, geometry.safeAreaInsets.top)
            
        } // Navigation View END
        
    } // body: some View END
    
    func refreshCatFacts() {
        Task {
            do {
                cats = try await catManager.getCatImage()
                try await catFactsManager.getCatFacts()
            } catch {
                print("Error refreshing cat facts: \(error)")
            }
        }
    } // func refreshCatFacts END
    
} // Bottom CatView View END



struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView(catFactsManager: CatFactsManager())
    }
}
