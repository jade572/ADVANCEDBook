//
//  NetworkManager.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/9/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private let baseURL = "https://dapi.kakao.com/v3/search/book?query="
    private let apiKey = "KakaoAK 473d8a839fbefd4a944818e7fee6034a"  // 올바른 API 키 사용

    func fetchBooks(query: String, completion: @escaping (Result<[BookModel], Error>) -> Void) {
        guard let url = URL(string: baseURL + query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let result = try JSONDecoder().decode(BookSearchResult.self, from: data)
                completion(.success(result.documents))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct BookSearchResult: Decodable {
    let documents: [BookModel]
}

struct BookModel: Decodable {
    let title: String
    let authors: [String]
    let price: Int
    let thumbnail: String?
    let description: String?
}

