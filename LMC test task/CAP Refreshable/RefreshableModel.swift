//
//  RefreshableModel.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 04.10.2021.
//

import SwiftUI
import Combine

class RefreshableModel: ObservableObject {
    
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.load()
            }
        }
    }
    
//    init(reviews: ViewModel) {
//        self.reviews = reviews
//    }
    
    func load() {
        // Simulate async task
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            self.loading = false
//            self.reviews.fetch()
//            self.dog = dogs[self.idx]
        }
    }
}
