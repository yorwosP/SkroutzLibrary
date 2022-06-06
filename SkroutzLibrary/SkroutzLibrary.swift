//
//  SkroutzLibrary.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/10/2019.
//

import Foundation

public class SkroutzLibrary {
    
    
    
    //  MARK: - private properties

    
    
    // API version (default 3.2)
    private (set) var version: String
    
    lazy private var headers = [
        "Authorization": "",
        "Accept": "application/vnd.skroutz+json; version=\(version)"
    ]
    
    // token used for authorized requests
    private var token:TokenData?{
        
        didSet{
            
            guard token != nil else {return}
            // once set:
            // 1. set the headers
            headers["Authorization"] = "Bearer " + token!.accessToken
            
            // 2. inform the delegate
            
            delegate?.authorizationDidSucceed()
            
        }
    }
    
    
    // MARK: - private properties
    
    private var clientID: String
    private var clientSecret: String

    
    // MARK: - public properties
    public weak var delegate: SkroutzLibraryDelegate?
    // to track if we are under the process of authorizing (supress new auth requests in that case)
    private (set) var isAuthorizing: Bool = false
    
    
    
    
    // MARK: - initializers
    /// initialize the skroutz client
    /// - Parameters:
    ///   - id: clientID
    ///   - secret: clientSecret
    ///   - version: API version (default 3.2)
    public init(id:String, secret:String, for version: Double = ApiDefaults.version) {
        clientID = id
        clientSecret = secret
        self.version = String(version)
        
        
        
        
    }
    
    // MARK: - Decoders
    
    private func decodeData<T:Decodable>(_ data:Data, withDecoderFor decoder:T.Type) -> T? {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let values = try? jsonDecoder.decode(T.self, from: data)
        return values
    }
    
    
    
    

    private func decodeErrorFromResponse(_ response:HTTPURLResponse, withData data: Data) -> ApiError{
        
        
        var apiError:ApiError
        if let responseCode = HttpResponseCode(rawValue:response.statusCode){
            
            struct Container:Decodable{
                var errors: [SkroutzError]
                
            }
            
            
            //Let's get only the first error (I don't think Skroutz API returns more than one
            if let error = self.decodeData(data, withDecoderFor: Container.self)?.errors.first{
                apiError = ApiError.networkError(errorCode: responseCode, skroutzError: error)
                
            }
            else{
                apiError = ApiError.parsingError
            }
            
        }else{
            apiError = ApiError.genericError(message: "Unexpected response from server (\(response.statusCode))")
            
        }
        
        return apiError
        
        
        
    }
    
    
    // MARK: - private url helper methods
    
    private func constructRequest(forUrl url: String,
                                  withParameters parameters: [String:String]? = nil,
                                  multipleParameters: [String: [Int]]? = nil,
                                  method:HttpMethod = .get,
                                  andHeaders headers:[String:String] = ["":""])
    -> URLRequest?{
        
        
        var urlComponents = URLComponents(string: url)
        var queryItems: [URLQueryItem]? = []
        
        
        if let queryParameters = parameters?.map({ URLQueryItem(name:$0.key, value: $0.value)}){
            queryItems = queryParameters
            
        }
        if let multipleQueryParameters = multipleParameters{
            for (key, values) in multipleQueryParameters{
                for value in values{
                    let queryItem = URLQueryItem(name:key, value:String(value))
                    queryItems?.append(queryItem)
                    
                }
                
            }
        }
        urlComponents?.queryItems = queryItems
        if let constructedUrl = urlComponents?.url {
            var request = URLRequest(url: constructedUrl)
            //            not sure if the following is needed (cache policy)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            return request
            
        }else{
            return nil
        }
        
        
        
    }
    
    
    private func retrieveData<T:Decodable>(from url:String,
                                           withParameters parameters: [String:String]? = nil,
                                           multipleParameters:[String:[Int]]? = nil,
                                           withMethod method:HttpMethod = .get,
                                           decodeWith decoder:T.Type,
                                           completion:@escaping(_: ApiError?, _: T?)
                                           -> Void){
        
        var apiError: ApiError? = nil
        
        
        // prepare url request
        
        var urlComponents = URLComponents(string: url)
        
        if let queryParameters = parameters?.map({ URLQueryItem(name:$0.key, value: $0.value)}){
            urlComponents?.queryItems = queryParameters
        }
        guard let request = constructRequest(forUrl: url, withParameters:parameters, multipleParameters:multipleParameters, andHeaders: self.headers) else{
            apiError = ApiError.genericError(message: "Cannot construct request for \(url) and \(parameters == nil ? String("no parameters") : String("parameters:\(parameters)"))")
            completion(apiError, nil)
            return
            
        }
        

        
        
        
        
        
        // perform the request
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            // some kind of generic error occured
            if let error = error{
                apiError = ApiError.genericError(message: error.localizedDescription)
                
                
            }else{
                
                if let httpResponse = response as? HTTPURLResponse{
                    //we have received some kind of response
                    // check if this response is in the "valid" range
                    if httpResponse.statusCode < 200 || httpResponse.statusCode > 299{

                        // Error response
                        if let receivedData = data{
                            apiError = self.decodeErrorFromResponse(httpResponse, withData: receivedData)
                            
                        }else{
                            apiError = ApiError.networkError(errorCode: HttpResponseCode(rawValue: httpResponse.statusCode)! ,skroutzError: nil, additionalMessage: "invalid data received from server")
                        }
                        
                        
                    }else{
                        // ok response. handle the data
                        if let retrievedData = data{
                            
                            
                            //decode the data
                            
                            if let root = self.decodeData(retrievedData, withDecoderFor: T.self){
                                completion(nil, root)
                                return
                                
                                
                            }else{
                                // could not decode the data
                                apiError = ApiError.parsingError
                            }
                        }
                        
                        
                    }
                    
                }
            }
            
            
            // Done checking for errors
            // pass it to the completion handler
            completion(apiError, nil)
            
        }
        
        task.resume()
        
        
        
        
        
        
    }
    
    
    
    
    
}


extension SkroutzLibrary{
    
    // MARK: - public API
    
    // MARK: Authorization
    
    public func authorize() {
        
        print("authorizing")
        
        // don't request token if:
        // a. if already in authorizing state
        guard isAuthorizing == false else { return }
        // b. there is an already valid token
        guard token == nil, ((token?.isValid) == nil) else {return}
        isAuthorizing = true
        
        
        let queryParameters = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "grant_type": "client_credentials",
            "scope":"public"
        ]
        
        retrieveData(from: ApiDefaults.authUrl, withParameters: queryParameters, decodeWith: TokenData.self) { error, token in
            // not more in authorizing state
            self.isAuthorizing = false
            if let _ = error{
              
                // invalidate the token (in case was previously set)
                self.token = nil
                self.delegate?.authorizationDidFail(with: error!)
                
            }
            if let receivedToken = token, error == nil{
                self.token = receivedToken
            }
            
            
        }
        
    }
    
    
    //MARK: Category methods
    
    /// List all categories (categories_index)
    /// - Parameters:
    ///   - perPage: how many results pers page (default = 25)
    ///   - page: which page to retrieve (default = 1)
    ///   - completion: callback
    
    public func getAllCategories(per perPage:Int = 25, page:Int = 1,  completion:@escaping(_: ApiError?, _:[Category]?) -> Void){
        let url = ApiDefaults.baseUrl+"/categories"
        let parameters = ["per": String(perPage), "page": String(page)]

        struct Container: Decodable{
            var categories:[Category]
        }
        retrieveData(from: url, withParameters: parameters, decodeWith: Container.self) { (error, container) in
            completion(error, container?.categories)
        }
    }
    
    
    /// Retrieve a single category (categories_show)
    /// - Parameters:
    ///   - id: category ID
    ///   - completion: callback
    
    public func getCategory(id:Int, completion:@escaping(_: ApiError?, _:Category?) -> Void){
        let url = ApiDefaults.baseUrl + "/categories/\(id)"
        struct Container: Decodable{
            var category:Category
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.category)
        }
    }
    
    /// Retrieve the parent of a category (category_parent)
    /// - Parameters:
    ///   - id: category ID
    ///   - completion: callback
    
    public func getParentCategoryFor(id:Int, completion:@escaping(_: ApiError?, _:Category?) -> Void){
        let url = ApiDefaults.baseUrl + "/categories/\(id)/parent"
        struct Container: Decodable{
            var category:Category
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.category)
        }
    }
    
    /// Retrieve the root category (categories_root)
    /// - Parameter completion: callback
    
    public func getRootCategory(completion:@escaping(_: ApiError?, _:Category?) -> Void){
        let url = ApiDefaults.baseUrl + "/categories/root"
        struct Container: Decodable{
            var category:Category
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.category)
        }
    }
    
    /// List the children categories of a category  (children_api_category)
    /// - Parameters:
    ///   - id: Category ID
    ///   - completion: callback
    
    public func getChildrenCategoriesForCategory(id: Int, completion:@escaping(_: ApiError?, _:[Category]?) -> Void){
        let url = ApiDefaults.baseUrl+"/categories/\(id)/children"
        
        
        
        struct Container: Decodable{
            var categories:[Category]
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.categories)
        }
    }
    
    
    //    TODO: Implement grouping as well
    /// List a category's specifications  (category_specifications)
    /// - Parameters:
    ///   - id: category ID
    ///   - completion: callback (exposes error or specifications)
    public func getSpecificationsForCategory(id: Int, completion:@escaping(_: ApiError?, _:[Specification]?) -> Void){
        let url = ApiDefaults.baseUrl+"/categories/\(id)/specifications"
        
        
        
        struct Container: Decodable{
            var specifications:[Specification]
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.specifications)
        }
    }
    
    /// List a category's manufacturers (category_manufacturers)
    /// - Parameters:
    ///   - id: category ID
    ///   - completion: callback (exposes error or manufacturers)
    
    // TODO: -  implement ordering
    public func getManufacturersForCategory(id: Int, completion:@escaping(_: ApiError?, _:[Manufacturer]?) -> Void){
        let url = ApiDefaults.baseUrl+"/categories/\(id)/manufacturers"
        
        
        
        struct Container: Decodable{
            var manufacturers:[Manufacturer]
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.manufacturers)
        }
    }
    
    
    //    MARK: - SKU methods
    
    /// List SKUs of specific category
    /// - Parameters:
    ///   - id: Category ID
    ///   - showAvailableFilters: show (on/off) of filters available for this category
    ///   - per: how many results per page
    ///   - page: which page to retrieve
    ///   - showAppliedFilters: show (on/off) whic filters where applied
    ///   - showOrderMethods: show which methods are available for ordering
    ///   - ascending: results ascending or descending
    ///   - completion: completion handler (exposes error, skus, available filters, applied filters  and order methods
    
    public func getSkusForCategory(id: Int,
                                   perPage per:Int = 25,
                                   page:Int = 1,
                                   showAvailableFilters:Bool = false,
                                   showAppliedFilters: Bool = false,
                                   showOrderMethods: Bool = false,
                                   ascending: Bool = true,
                                   completion:@escaping(
                                    _: ApiError?,
                                    _:[Sku]?,
                                    _:AvailableFilter?,
                                    _:AppliedFilter?,
                                    _:[String:String]? //orderMethods
                                   ) -> Void){
                                       
                                       var parameters = ["per" : String(per), "page": String(page)]
                                       
                                       //        add the meta parameters if needed
                                       var meta : [String] = []
                                       
                                       if showAvailableFilters {meta.append("show_available_filters")}
                                       if showAppliedFilters {meta.append("show_applied_filters")}
                                       if showOrderMethods {meta.append("show_order_methods")}
                                       if meta.count > 0 {parameters["include_meta"] = meta.joined(separator:",")}
                                       
                                       //        add other optional parameters
                                       parameters["order_dir"] = ascending ? "asc" : "desc"
                                       
                                       
                                       let url = ApiDefaults.baseUrl + "/categories/\(id)/skus"
                                       
                                       
                                       
                                       
                                       struct Container: Decodable{
                                           var skus:[Sku]
                                           var meta:SkuMeta?
                                           
                                           
                                           
                                       }
                                       
                                       retrieveData(from: url, withParameters: parameters, decodeWith: Container.self) { (error, container) in
                                           let skus = container?.skus
                                           
                                           let appliedFilters = showAppliedFilters ? container?.meta?.appliedFilters : nil
                                           let availableFilters = showAvailableFilters ? container?.meta?.availableFilters : nil
                                           let orderMethods = showOrderMethods ? container?.meta?.orderByMethods : nil
                                           
                                           completion(error, skus, availableFilters, appliedFilters, orderMethods)
                                           
                                           
                                           
                                           
                                       }
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                   }
    
    
    /// List SKUs of specific category  with filters
    /// - Parameters:
    ///   - id: category id
    ///   - filters: array of filter ids
    ///   - filterType: filter type (shop, manufacturer, or filter IDs)
    ///   - perPage: how many results per page
    ///   - page: which page to retrieve
    ///   - ascending: ascending or descending order
    ///   - orderBy: order by which order options
    ///   - completion: completion handler (exposes error or results)
    public func getSkusForCategory(id: Int,
                                   withFilters filters:[Int],
                                   filterType: FilterChoicesForSku,
                                   per perPage: Int = 25,
                                   page: Int = 1,
                                   ascending: Bool = true,
                                   orderBy: String? = nil,
                                   completion:@escaping(_: ApiError?, _:[Sku]?) -> Void){
        
        
        var parameters = ["per" : String(perPage), "page": String(page), "order_dir" : ascending ? "asc" : "desc"]
        //        add order_by if exists
        if let order = orderBy { parameters["order_by"] = order}
        
        let multipleParameters = [filterType.rawValue : filters]
        let url = ApiDefaults.baseUrl + "/categories/\(id)/skus"
        
        
        struct Container: Decodable{
            var skus:[Sku]
            
            var meta:SkuMeta?
            
            
            
        }
        
        retrieveData(from: url,
                     withParameters: parameters,
                     multipleParameters: multipleParameters,
                     decodeWith: Container.self) { (error, container) in
            let skus = container?.skus
            
            
            
            completion(error, skus)
        }
        
        
        
        
    }
    
    //    TODO: implement a query function as well
    
    
    
    
    
    /// Retrieve a single SKU
    /// - Parameters:
    ///   - id: SKU id
    ///   - completion: callback (exposes error or sku)
    public func getSku(id: Int, completion:@escaping(_: ApiError?, _: Sku?) -> Void){
        let url = ApiDefaults.baseUrl + "/skus/\(id)"
        struct Container: Decodable{
            var sku:Sku
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.sku)
        }
    }
    
    /// Retrieve similar SKUs
    /// - Parameters:
    ///   - id: SKU id
    ///   - completion: callback (exposes error or sku)
    public func getSimilarSkusToSku(id:Int, completion:@escaping(_: ApiError?, _:[Sku]?) -> Void){
        let url = ApiDefaults.baseUrl+"/skus/\(id)/similar"
        
        
        
        struct Container: Decodable{
            var skus: [Sku]
            var meta:Meta
        }
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            completion(error, container?.skus)
        }
    }
    
    
    /// Retrieve a SKU's reviews (skus_reviews)
    /// - Parameters:
    ///   - id: sku id
    ///   - perPage: how many results per page
    ///   - page: which page to display
    ///   - completion: completion handler (exposes error or array of Review(s))
    public func getReviewsForSku(id:Int,
                                 per perPage: Int = 25,
                                 page:Int = 1,
                                 completion:@escaping(_: ApiError?, _:[Review]?) -> Void){
        
        
        let url = ApiDefaults.baseUrl+"/skus/\(id)/reviews"
        
        let parameters = ["per": String(perPage), "page": String(page)]
        
        
        
        
        
        struct Container: Decodable{
            var reviews: [Review]
            var meta:Meta
        }
        retrieveData(from: url, withParameters: parameters, decodeWith: Container.self) { (error, container) in
            completion(error, container?.reviews)
        }
    }
    
    /// Retrieve a SKU's reviews (skus_reviews) - include rating
    /// - Parameters:
    ///   - id: sku id
    ///   - perPage: how many results per page
    ///   - page: which page to display
    ///   - completion: completion handler (exposes error or array of Review(s))
    public func getReviewsWithBreakdownForSku(id:Int,
                                              per perPage: Int = 25,
                                              page:Int = 1,
                                              completion:@escaping(_: ApiError?, _:[Review]?, _:[RatingBreakdownMeta]?) -> Void){
        
        
        let url = ApiDefaults.baseUrl+"/skus/\(id)/reviews"
        
        let parameters = ["per": String(perPage), "page": String(page), "include_meta":"sku_rating_breakdown"]
        
        
        
        
        
        struct Container: Decodable{
            var reviews: [Review]
            var meta:combinedMeta
            struct combinedMeta:Decodable {
                var skuRatingBreakDown:[RatingBreakdownMeta]?
                var pagination:Meta.Pagination
            }
        }
        retrieveData(from: url, withParameters: parameters, decodeWith: Container.self) { (error, container) in
            completion(error, container?.reviews, container?.meta.skuRatingBreakDown)
        }
    }
    
    
    
    //    func getReviewFormForSKu(id:){}
    //    func getReviewFormAndSelectedAnswersForSKu(id:){}
    
    
    /// Retrieve a SKU's price history (skus_price_history)
    /// - Parameters:
    ///   - id: SKU id
    ///   - completion: callback handler (exposes error or history). Access history.average and lowest items
    public func getPriceHistoryForSku(id:Int, completion:@escaping(_: ApiError?, _:History?) -> Void){
        
        let url = ApiDefaults.baseUrl + "/skus/\(id)/price_history"
        
        struct Container: Decodable{
            var history: History?
        }
        
        
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            
            completion(error, container?.history)
            
        }
        
        
        
    }
    
    
    /// Retrieve an SKU's specifications (sku_specifications)
    /// - Parameters:
    ///   - id: SKU id
    ///   - completion: completion handler (exposes error or specifications)
    public func getSpecificationsForSku(id:Int, completion:@escaping(_: ApiError?, _:[Specification]?) -> Void){
        
        let url = ApiDefaults.baseUrl + "/skus/\(id)/specifications"
        
        struct Container: Decodable{
            var specifications: [Specification]?
        }
        
        
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            
            completion(error, container?.specifications)
            
        }
        
    }
    
    
    //MARK:  - Book methods
    
    
    /// Retrieve a single Book by ID (books_show)
    /// - Parameters:
    ///   - id: Book ID
    ///   - completion: completion handler (exposes error or Book)
    public func getBook(id: Int, completion:@escaping(_: ApiError?, _:Book?) -> Void){
        
        let url = ApiDefaults.baseUrl + "/books/\(id)"
        
        struct Container: Decodable{
            var book: Book?
        }
        
        
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            
            completion(error, container?.book)
            
        }
        
    }
    
    
    /// Retrieve Book details by ID (books_details)
    /// - Parameters:
    ///   - id: Book ID
    ///   - completion: completion handler (exposes error or Book details)
    public func getBookDetails(id: Int, completion:@escaping(_: ApiError?, _:BookDetails?) -> Void){
        let url = ApiDefaults.baseUrl + "/books/\(id)/details"
        
        struct Container: Decodable{
            var bookDetails: BookDetails?
        }
        
        
        retrieveData(from: url, decodeWith: Container.self) { (error, container) in
            
            completion(error, container?.bookDetails)
            
        }
    }
    
    
    // MARK: - search methods
    
    
    
    
    /// Query for a term
    /// - Parameters:
    ///   - text: query text
    ///   - completion: completion handler. Wiil return:
    ///         - error,
    ///         - categories matching the term,
    ///         - Alternative struct (alternative term, hint for alternative search)
    ///         - Strong hints for match (can be one of SKU, Manufacturer, Category or Shop)
    
    public func searchFor(_ text:String, completion:@escaping( _:ApiError?, _:[Category]?, _:[SearchMeta.Alternative]?, _:SearchMeta.StrongMatch?) -> Void){
        let parameters = ["q":text]
        let url = ApiDefaults.baseUrl + "/search"
        
        struct Container: Decodable{
            var categories:[Category]?
            var meta:SearchMeta?
            
        }
        
        
        retrieveData(from: url, withParameters: parameters, decodeWith: Container.self) { error, container in
            
            completion(error, container?.categories, container?.meta?.alternatives, container?.meta?.strongMatches)
        }
        
        
        
    }
    

    
    /// Search with autocomplete suggestions
    /// - Parameters:
    ///   - text: query text
    ///   - completion: completion handler. Will return  error or an Autocomplete struct
    ///
    public func searchWithAutocompleteFor(_ text:String, completion:@escaping( _:ApiError?,  _:[Autocomplete]?) -> Void){
        let parameters = ["q":text]
        let url = ApiDefaults.baseUrl+"/autocomplete"

        
        struct Container:Decodable{
            var autocomplete:[Autocomplete]
            
        }
        
        retrieveData(from: url, withParameters: parameters, decodeWith: Container.self) { error, container in
            completion(error, container?.autocomplete)
        }
        
        
    }
    
    
}
