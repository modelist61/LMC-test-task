//
//  ViewModel.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 03.10.2021.
//

import SwiftUI


class ViewModel: ObservableObject {
    
    @Published var result: [Result] = []
    @Published var result2: [Result2] = []
    
    func fetchReview() {
        guard let url = URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=Rdne73gGKdI8uVfPwVt7GSbiQwAz3Pw2")
        else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let reviews = try JSONDecoder().decode(Reviews.self, from: data)
                DispatchQueue.main.async {
                    self?.result = reviews.results
                }
            }
            catch {
                print("fetchReview \(error)")
            }
        }
        task.resume()
    }
    
    func fetchCritics() {
        guard let url = URL(string: "https://api.nytimes.com/svc/movies/v2/critics/all.json?api-key=Rdne73gGKdI8uVfPwVt7GSbiQwAz3Pw2")
        else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {  return }
            do {
                let critics = try JSONDecoder().decode(Critics.self, from: data)
                DispatchQueue.main.async {
                    self?.result2 = critics.results
                }
            }
            catch {
                print("fetchCritics \(error)")
            }
        }
        task.resume()
    }
    
    //get currenta date
    func getDate() -> String {
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy/MM/d"
        let stringDate = timeFormatter.string(from: time)
        return stringDate
    }
    
    //ReFormated date from JSON
    func fromatJsonDate(input: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/d   HH:mm"
        let date: Date? = dateFormatterGet.date(from: input)
        let stringDate = dateFormatter.string(from: date ?? Date())
        return stringDate
    }
    
}

