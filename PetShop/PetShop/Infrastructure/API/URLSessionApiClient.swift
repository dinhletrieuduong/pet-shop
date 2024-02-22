//
//  URLSessionApiClient.swift
//  PetShop
//
//  Created by Dylan on 22/02/2024.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case OPTIONS = "OPTIONS"
    case GET     = "GET"
    case HEAD    = "HEAD"
    case POST    = "POST"
    case PUT     = "PUT"
    case PATCH   = "PATCH"
    case DELETE  = "DELETE"
    case TRACE   = "TRACE"
    case CONNECT = "CONNECT"
}

struct APIRequest {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]?
    let queryParams: [String: Any]?
    let body: Data?
}

enum AppError: Error {
    case httpFailure
    case invalidURL
    case noHttpBody
    case decodingError
}

protocol NetworkClient {
    func dataTask<T: Codable>(_ api: APIRequest,
                              onCompletion: @escaping (_ result: Result<T, Error>) -> Void)
}

final class URLSessionApiClient: NetworkClient {
    
    private let configuration: URLSessionConfiguration
    private let session: URLSession
    
    init() {
        self.configuration = URLSessionConfiguration.default
        self.configuration.timeoutIntervalForRequest = 30.0
        self.configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        // Create URLSession
        self.session = URLSession(configuration: self.configuration)
    }
    
    private func prepareURL(_ api: APIRequest) -> URL? {
        var urlComponents = URLComponents(string: api.url.absoluteString)
        let queryItems = api.queryParams?.map({ (key, value) in
            return URLQueryItem(name: key, value: String(describing: value) )
        })
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    func dataTask<T: Codable>(_ api: APIRequest, onCompletion: @escaping (_ result: Result<T, Error>) -> Void) {
        
        guard let url = prepareURL(api) else {
            return onCompletion(.failure(AppError.invalidURL))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.allHTTPHeaderFields = api.headers
        urlRequest.httpBody = api.body
        
        self.session.dataTask(with: urlRequest) { data, response, error in
            
            // onFailure
            if let err = error {
                onCompletion(.failure(err))
                return
            }
            
            // Validation
            guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 0) else {
                onCompletion(.failure(AppError.httpFailure))
                return
            }
            
            // onSuccess
            if let data = data {
                // Transform Data to Codable Type
                if let userModel = try? JSONDecoder().decode(T.self, from: data) {
                    onCompletion(.success(userModel))
                } else {
                    onCompletion(.failure(AppError.decodingError))
                }
            } else {
                onCompletion(.failure(AppError.noHttpBody))
            }
        }.resume()
    }
}

final class AlamofireApiClient: NetworkClient {
    
    private let session = AF.session
    
    private func prepareURL(_ api: APIRequest) -> URL? {
        var urlComponents = URLComponents(string: api.url.absoluteString)
        let queryItems = api.queryParams?.map({ (key, value) in
            return URLQueryItem(name: key, value: String(describing: value) )
        })
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    func dataTask<T>(_ api: APIRequest, onCompletion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        guard let url = prepareURL(api) else {
            return onCompletion(.failure(AppError.invalidURL))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.allHTTPHeaderFields = api.headers
        urlRequest.httpBody = api.body
                
        AF.request(urlRequest).validate().response { response in
            
            // onFailure
            if let err = response.error {
                onCompletion(.failure(err))
                return
            }
            
            // onSuccess
            if let data = response.data {
                // Transform Data to Codable Type
                if let userModel = try? JSONDecoder().decode(T.self, from: data) {
                    onCompletion(.success(userModel))
                } else {
                    onCompletion(.failure(AppError.decodingError))
                }
            } else {
                onCompletion(.failure(AppError.noHttpBody))
            }
        }
    }
    
}

// Examples
//struct UserModel: Codable {
//    let id: Int
//    let name: String
//    let username: String
//    let email: String
//    let address: UserAddress
//}
//
//struct UserAddress: Codable {
//    let street: String
//    let suite: String
//    let city: String
//    let zipcode: String
//}
//struct PostModel: Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
//
//let userAPI = URL(string: "https://jsonplaceholder.typicode.com/users/1")!
//let apiRequest = APIRequest(url: userAPI, method: .GET, headers: nil, queryParams: nil, body: nil)
//client.dataTask(apiRequest) { (_ result: Result<UserModel, Error>) in
//    switch result {
//    case .failure(let error):
//        print(error)
//    case .success(let data):
//        print("Data: \(data)")
//    }
//}
//
//let newPost = PostModel(userId: 1234, id: 1234, title: "My Title", body: "This is Body")
//let newPostData = try? JSONEncoder().encode(newPost)
//
//let postsAPI = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//let apiRequest = APIRequest(url: postsAPI, method: .POST, headers: ["Content-Type":"application/json"], queryParams: nil, body: newPostData)
//client.dataTask(apiRequest) { (_ result: Result<PostModel, Error>) in
//    switch result {
//    case .failure(let error):
//        print(error)
//    case .success(let data):
//        print("Data: \(data)")
//    }
//}


struct ApiRequest<ResponseType: Codable> {

    func webserviceUrl() -> String {
        #if DEBUG
        return "https:www.dev.medium.com/"
        #else
        return "https:www.medium.com/"
        #endif
    }

    func apiPath() -> String {
        return "api/"
    }

    func apiVersion() -> String {
        return "v1.0/"
    }

    func apiResource() -> String {
        return ""
    }

    func endPoint() -> String {
        return ""
    }

    func bodyParams() -> NSDictionary? {
        return [:]
    }

    func requestType() -> HTTPMethod {
        return .post
    }

    func contentType() -> String {
        return "application/json"
    }
}

struct Story: Codable {
    let storyId: Int?
    let clapsCount: Int?
    let title: String?
    let published: Bool?
}

struct GetStoriesByUsernameRequest: ApiRequest<[Story]> {

    let username: String
    let limit: Int?
    let pageNumber: Int?

    override func apiResource() -> String {
        return "stories/"
    }

    override func endPoint() -> String {
        return username
    }

    override func bodyParams() -> NSDictionary? {
        return ["limit": limit!,
                "pageNumber": pageNumber!]
    }

    override func requestType() -> HTTPMethod {
        return .get
    }

}
struct ApiResponse {
    var success: Bool   // whether the API call passed or failed
    var message: String? // message returned from the API
    var data: AnyObject? // actual data returned from the API

    init(success: Bool, message: String? = nil, data: AnyObject? = nil) {
        self.success = success
        self.message = message
        self.data = data
    }
}


typealias ResponseHandler = (ApiResponse) -> Void

class NetworkApiClient {
    
    func callApi<ResponseType>(request: ApiRequest<ResponseType>, responseHandler: @escaping ResponseHandler) {
        
        let urlRequest = urlRequestWith(apiRequest: request)
        Alamofire.request(urlRequest).responseData { (response) in
            switch(response.result) {
            case .success:
                let apiResponse = self.successResponse(request: request, response: response)
                responseHandler(apiResponse)
            case .failure:
                self.failureResponse(response: response)
            }
        }
    }
    
    func urlRequestWith<ResponseType>(apiRequest: ApiRequest<ResponseType>) -> URLRequest {
        let  completeUrl = apiRequest.webserviceUrl() + apiRequest.apiPath() +
        apiRequest.apiVersion() + apiRequest.apiResource() + apiRequest.endPoint()
        
        var urlRequest = URLRequest(url: URL(string: completeUrl)!)
        urlRequest.httpMethod = apiRequest.requestType().rawValue
        urlRequest.setValue(apiRequest.contentType(), forHTTPHeaderField:  "Content-Type")
        urlRequest.httpBody = try?JSONSerialization.data(withJSONObject:  apiRequest.bodyParams()!, options: [])
        return urlRequest
    }
    
    // here we are going to parse the data
    func successResponse<ResponseType: Codable>(request: ApiRequest<ResponseType>,
                                     response: DataResponse<Data>) -> ApiResponse{
        do {
            // Step 1
            let responseJson = try JSON(data: response.data!)
            // Step 2
            let dataJson = responseJson["data"].object
            let data = try JSONSerialization.data(withJSONObject: dataJson,
                                                  options: [])
            // Step 3
            let decodedValue = try JSONDecoder().decode(ResponseType.self, from: data)

            return ApiResponse(success: true, data: decodedValue as AnyObject)
            
        } catch {
            return ApiResponse(success: false)
        }
    }

}

typealias CompletionHandler =  (Bool, AnyObject?) -> Void

class StoryService {

    func fetchStoriesByUsername(username: String, limit: Int?, pageNumber: Int, completion: @escaping CompletionHandler) {
        let request = GetStoriesByUsernameRequest()
        request.username = username
        request.limit = limit
        request.pageNumber = pageNumber
        NetworkApiClient().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            } else {
                completion(false, apiResponse.message as AnyObject?)
            }
        }
    }

}
