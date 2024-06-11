//
//  HomePresenter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var categories: [CategoryModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    //MARK: - Before using Combine
    //  func getCategories() {
    //    loadingState = true
    //    homeUseCase.getCategories { result in
    //      switch result {
    //      case .success(let categories):
    //        DispatchQueue.main.async {
    //          self.loadingState = false
    //          self.categories = categories
    //        }
    //      case .failure(let error):
    //        DispatchQueue.main.async {
    //          self.loadingState = false
    //          self.errorMessage = error.localizedDescription
    //        }
    //      }
    //    }
    //  }
    
    func getCategories() {
        loadingState = true
        print("test")
        homeUseCase.getCategories().receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
                print(self.errorMessage)
            case .finished:
                self.loadingState = false
            }
        } , receiveValue:{ categories in
            self.categories = categories
        } ).store(in: &cancellables)
        
    }
    
    func linkBuilder<Content: View>(
        for category: CategoryModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: category)) { content() }
    }
    
}
