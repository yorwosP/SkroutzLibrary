<H1>SkroutzLibrary (defunct)</H1>

This aimed to be a Swift library to access the Skroutz API (https://developer.skroutz.gr/api/).
Access to the API was closed before the library was finished. Only 25-30% of the endpoints were implemented. 
You can still play a bit with the library by using mock API (which is used by default at this version)

Project builds to a static library


## Usage ##

Using the library against the the actual API would consist of following steps:

<u>Create an instance</u>:

`skroutzClient = SkroutzLibrary(id: clientID, secret: clientSecret)`

clientID and secret were provided by API administration team. 
In the current release you can use random strings

<u>Assign a delegate to inform about successful (or unsuccessful) authentication</u>

`skroutzClient?.delegate = self`

not needed in current implementation (mock API doesn't provide or require authorization)

<u>Request authorization</u>

`skroutzClient.authorize().`

not needed in current implementation (mock API doesn't provide or require authorization)

<u>Once authorization is succesful, call the get method(s) needed </u>

For example, to get details for a specific category id you call getCategory(id:completion:)

All *get* methods take a closure as a completion handler. Closure arguments are: 

- the corresponding struct (or array of structs) that contains API results for the query (if succesful or nil if not)
- An ApiError enum with the type of error occured and the corresponding message (if an error occured or nil if not). Types of errors are:  
    * networkError: an error returned from Skroutz API (e.g 404 - Not Found)
    * parsingError: Could not parse the response (unexpected json format returned)
    * genericError: An error code not defined in Skroutz API was returned

E.g 
```
        skroutzClient.getManufacturersForCategory(id: 7, completion: { error, manufacturers in
            if let error = error{
                switch error {
                 case let .networkError(errorCode, skroutzError, message):
                       // handle networkError
                    case let .genericError(message):
                        // handle genericError
                    case .parsingError:
                       //handle parsingError
                }
            
            }else{
                // do something with the results
            }            
        })
```




    





