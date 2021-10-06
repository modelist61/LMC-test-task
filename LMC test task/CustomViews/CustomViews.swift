//
//  CustomViews.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 04.10.2021.
//

import SwiftUI

//Reviews Image from URL
struct URLImage: View {
    let urlString: String
    @State private var data: Data?
    
    var body: some View {
        Text("")
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .frame(width: 374, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        } else {
            //CAP image if no answer
            Image(systemName: "eye.slash")
                .frame(width: 374, height: 160)
                .background(Color("orangeWhite"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .onAppear {
                    fetchData()
                }
        }
    }
    //Fetch image from string URL
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

//Critics Image from URL
struct URLCriticsImage: View {
    let urlString: String
    @State private var data: Data?
    
    var body: some View {
        Text("")
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .frame(width: 180, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        } else {
            //CAP image if no answer
            ZStack {
                Color("blueWhite")
                    .frame(width: 180, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Image("TabViewImage2")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .background(Color("blueWhite"))
                    
                }
                .onAppear {
                    fetchData()
            }
        }
    }
    //Fetch image from string URL
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            URLImage(urlString: "")
        }
        ZStack {
            URLCriticsImage(urlString: "")
        }
    }
}


struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
//        GeometryReader { geometry in
            ZStack {
                self.content()
                    .disabled(self.isShowing)
//                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: 150, height: 100)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
//        }
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
