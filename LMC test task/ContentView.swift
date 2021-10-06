//
//  ContentView.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 02.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var reviews = ViewModel()
    @StateObject var refreshable = RefreshableModel()
    @ObservedObject var viewRouter: ViewRouter
    @State private var date = Date()
    @State private var serch = ""
    @State private var showLoading = true
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                switch viewRouter.currentPage {
                case .tab1:
                    ReviewsNavigationView(reviews: reviews, refreshable: refreshable, showLoading: $showLoading)
                case .tab2:
                    CriticsNavigationView(reviews: reviews, refreshable: refreshable)
                }
                
                VStack {
                    ZStack {
                        Color.white
//CustomTabBar Buttons
                        HStack(spacing: 80) {
                            TabBarButton(symbol: "TabViewImage1",
                                         text: "Reviews")
                                .foregroundColor(viewRouter.currentPage == .tab1 ? Color("orange") : .gray)
                            
                                .onTapGesture {
                                    viewRouter.currentPage = .tab1
                                }
                            
                            TabBarButton(symbol: "TabViewImage2",
                                         text: "Critics")
                                .foregroundColor(viewRouter.currentPage == .tab2 ? Color("blue") : .gray)
                                .onTapGesture {
                                    viewRouter.currentPage = .tab2
                                }
                        }
                    }
                        .frame(height: 90)
                        .shadow(radius: 0)
                }.shadow(radius: 4)
            }.ignoresSafeArea(.all, edges: .bottom)
        }
        .onChange(of: reviews.result.isEmpty ) { _ in
            showLoading.toggle()
        }
    }
    
    //        TabView {
    //                ReviewsNavigationView(reviews: reviews, refreshable: refreshable)
    //                    .onAppear {
    //                        reviews.fetchReview()
    //                    }
    //                .tabItem {
    //                    VStack {
    //                        Image("TabViewImage1")
    //                        Text("Reviews")
    //                            .font(.title)
    //                            .foregroundColor(.red)
    //                    }
    //                }
    //
    //            VStack {
    //                CriticsNavigationView(reviews: reviews, refreshable: refreshable)
    //
    //            }.tabItem {
    //                VStack {
    //                    Image("TabViewImage2")
    //                    Text("Critics")
    //                }
    //            }
    //
    //        }.accentColor(Color("orange"))
    //    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
        
    }
}

struct TabBarButton: View {
    let symbol: String
    let text: String
    var body: some View {
        VStack(alignment: .center) {
            Image(symbol)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 42)
            Text(text)
                .font(.custom("Lato-Regular", size: 12))
                .offset(y: -10)
        }.frame(width: 60)
        
    }
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Tab = .tab1
    enum Tab {
        case tab1
        case tab2
    }
}
