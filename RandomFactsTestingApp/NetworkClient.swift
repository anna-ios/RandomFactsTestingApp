//
//  NetworkClient.swift
//  RandomFactsTestingApp
//
//  Created by Zelinskaya Anna on 01.04.2021.
//

import Foundation

class NetworkClient {
	
	private lazy var urlSession: URLSession? = {
		return URLSession(configuration: .default)
	}()
	
	private var sessionTask: URLSessionDataTask? = nil
	
	func sendRequest<T:Codable>(path: String, completion: @escaping(Result<T,Error>)->Void) {
		guard let url = URL(string: "\(path)") else {
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		
		DispatchQueue.global(qos: .utility).async {
			self.sessionTask = self.urlSession?.dataTask(with: request, completionHandler: { (data, response, error) in
				if let error = error {
					DispatchQueue.main.async {
						completion(.failure(error))
					}
				}
				if let someData = data {
					do {
						let result = try JSONDecoder().decode(T.self, from: someData)
						DispatchQueue.main.async {
							completion(.success(result))
						}
					}
					catch {
						DispatchQueue.main.async {
							completion(.failure(error))
						}
					}
				}
			})
			
			self.sessionTask?.resume()
		}
	}
	
}
