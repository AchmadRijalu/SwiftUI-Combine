//
//  RemoteDataSource.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {

    //MARK: - Before using
//  func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void)
    
    func getCategories() -> AnyPublisher<[CategoryResponse], Error>
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getCategories() -> AnyPublisher<[CategoryResponse], Error> {
        return Future<[CategoryResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.categories.url) {
                AF.request(url).validate().responseDecodable(of: CategoriesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.categories))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    

    //MARK: - Before using
//  func getCategories(
//    result: @escaping (Result<[CategoryResponse], URLError>) -> Void
//  ) {
//    guard let url = URL(string: Endpoints.Gets.categories.url) else { return }
//
//    AF.request(url)
//      .validate()
//      .responseDecodable(of: CategoriesResponse.self) { response in
//        switch response.result {
//        case .success(let value): result(.success(value.categories))
//        case .failure: result(.failure(.invalidResponse))
//        }
//      }
//  }
    

}
