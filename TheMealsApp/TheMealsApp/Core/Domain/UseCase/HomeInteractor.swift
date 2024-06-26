//
//  HomeInteractor.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import Combine

protocol HomeUseCase {

//  func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)

    func getCategories() -> AnyPublisher<[CategoryModel], Error>
}

class HomeInteractor: HomeUseCase {
    
    

  private let repository: MealRepositoryProtocol

  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }

    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return repository.getCategories()
    }
//  func getCategories(
//    completion: @escaping (Result<[CategoryModel], Error>) -> Void
//  ) {
//    repository.getCategories { result in
//      completion(result)
//    }
//  }

}
