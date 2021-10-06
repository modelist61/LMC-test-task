//
//  CriticsNavigationView.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 04.10.2021.
//

import SwiftUI

struct CriticsNavigationView: View {
    
    @ObservedObject var reviews: ViewModel
    @ObservedObject var refreshable: RefreshableModel
    @State var tempForBindingSearc = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    //MARK: - TextField with custom lable
                    ZStack(alignment: .leading) {
                        //Paste lable above textField
                        //TODO: made show / hide state
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                                .font(.custom("Lato-Regular", size: 16))
                        }
                        .padding(.horizontal, 10)
                        .frame(width: 374, height: 45, alignment: .leading)
                        .foregroundColor(Color("blue"))
                        .background(Color("blueWhite"))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        TextField("", text: $tempForBindingSearc)
                            .padding(.horizontal, 10)
                            .frame(width: 374, height: 45)
                            .foregroundColor(Color("blue"))
                            .disableAutocorrection(true)
                    }
                }
                //MARK: - DatePicker Custom
                //Custom refreshable scrollView
                RefreshableScrollView(height: 70,
                                      refreshing: self.$refreshable.loading) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(reviews.result2, id: \.self) { review in
                            VStack {
                                //TODO: extract to subView
                                NavigationLink {
                                    VStack {
                                        HStack {
                                            URLCriticsImage(urlString: (review.multimedia?.resource.src ?? ""))
                                            Spacer()
                                            Text("\(review.display_name)")
                                                .font(.custom("Lato-Bold", size: 24))
                                        }.padding()
                                        ScrollView {
                                            
                                            Text("\(review.bio)")
                                                .font(.custom("Lato-Regular", size: 16))
                                        }
                                    }.padding()
                                } label: {
                                    URLCriticsImage(urlString: (review.multimedia?.resource.src ?? ""))
                                }
                                Text("\(review.display_name)")
                                    .font(.custom("Lato-Bold", size: 18))
                            }
                        }
                    }.padding(.top, 5)
                }
            }.padding(.horizontal, 16)
                .padding(.top, 15)
                .onChange(of: refreshable.loading) { _ in
                    reviews.fetchCritics()
                }
                .onAppear {
                    reviews.fetchCritics()
                }
                .toolbar {
                    HStack(alignment: .center) {
                        Text("Critics")
                            .font(.custom("Lato-Bold", size: 16))
                            .foregroundColor(.black)
                        
                    }.frame(width: UIScreen.main.bounds.width - 32)
                }.navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct CriticsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CriticsNavigationView(reviews: ViewModel(), refreshable: RefreshableModel())
    }
}
