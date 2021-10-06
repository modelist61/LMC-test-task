//
//  ReviewsNavigationView.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 04.10.2021.
//

import SwiftUI

struct ReviewsNavigationView: View {
    
    @Environment(\.openURL) var openURL
    @ObservedObject var reviews: ViewModel
    @ObservedObject var refreshable: RefreshableModel
    @State private var tempForBiningDate = Date()
    @State var tempForBindingSearc = ""
    @Binding var showLoading: Bool
    @State var hideCapText = false
    
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
                        }.opacity(hideCapText ? 0.0 : 1.0)
                            .padding(.horizontal, 10)
                            .frame(width: 239, height: 45, alignment: .leading)
                            .foregroundColor(Color("orange"))
                            .background(Color("orangeWhite"))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        TextField("", text: $tempForBindingSearc)
                            .padding(.horizontal, 10)
                            .frame(width: 239, height: 45)
                            .foregroundColor(Color("orange"))
                            .disableAutocorrection(true)
                            .onTapGesture {
                                hideCapText.toggle()
                            }
                    }
                    //MARK: - DatePicker Custom
                    ZStack {
                        //CAP SwiftUI lable above DatePicker
                        HStack {
                            Image(systemName: "calendar")
                            Text("\(reviews.getDate())")
                                .font(.custom("Lato-Regular", size: 12))
                        }
                        .frame(width: 125, height: 45)
                        .foregroundColor(Color("orange"))
                        .foregroundColor(.clear)
                        .background(Color("orangeWhite"))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            
                        }
                        DatePicker(
                            "",
                            selection: $tempForBiningDate,
                            displayedComponents: .date
                        )
                        //CAP SwiftUI mask DatePicker
                            .mask(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke()
                                    .frame(width: 125, height: 45)
                            )
                            .datePickerStyle(.compact)
                            .labelsHidden()
                    }
                }
                //Activity indicator (in CustomViews)
                LoadingView(isShowing: $showLoading) {
                    
                    //Custom refreshable scrollView
                    RefreshableScrollView(height: 70,
                                          refreshing: self.$refreshable.loading) {
                        ForEach(reviews.result, id: \.self) { review in
                            VStack {
                                URLImage(urlString: review.multimedia?.src ?? "")
                                //Show parsing screen
                                VStack(alignment: .leading) {
                                    Text("\(review.headline)")
                                        .font(.custom("Lato-Bold", size: 24))
                                    Text("\(review.summary_short)")
                                        .font(.custom("Lato-Regular", size: 16))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                        .padding(.vertical)
                                }
                                HStack {
                                    Image("TabViewImage2")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .colorMultiply(Color("orange"))
                                    //Review By Critic
                                    Text("\(review.byline)")
                                        .font(.custom("Lato-Regular", size: 16))
                                        .foregroundColor(Color("orange"))
                                    Spacer()
                                    //Date review
                                    Text("\(reviews.fromatJsonDate(input: review.date_updated))")
                                        .font(.custom("Lato-Regular", size: 12))
                                        .foregroundColor(.gray)
                                }
                                //Button on parsing view
                                Text("Read Review")
                                    .font(.custom("Lato-Bold", size: 16))
                                    .frame(width: 374, height: 45, alignment: .center)
                                    .overlay(RoundedRectangle(cornerRadius: 15)
                                                .stroke(style: StrokeStyle(lineWidth: 1)))
                                    .foregroundColor(Color("orange"))
                                    .onTapGesture {
                                        guard let url = URL(string: review.link.url) else { return }
                                        openURL(url)
                                    }
                            }.frame(width: 374, alignment: .leading)
                                .padding(.bottom, 27)
                        }
                    }
                }//loadingView endid
            }.padding(.top, 15)
            //pull to Refresh
                .onChange(of: refreshable.loading) { _ in
                    reviews.fetchReview()
                }
                .toolbar {
                    HStack(alignment: .center) {
                        Text("Reviews")
                            .font(.custom("Lato-Bold", size: 18))
                            .foregroundColor(.black)
                        
                    }.frame(width: UIScreen.main.bounds.width - 32)
                }.navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            reviews.fetchReview()
        }
    }
}

struct ReviewsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsNavigationView(reviews: ViewModel(), refreshable: RefreshableModel(), showLoading: .constant(true))
    }
}
