//
//  Shop.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/17/19.
//

import Foundation
/*
 {
   "shop": {
     "id": 452,
     "name": "Kotsovolos",
     "link": "http://www.kotsovolos.gr",
     "phone": "2102899999",
     "image_url": "https://b.scdn.gr/ds/shops/logos/452/mid_20160829183952_bfbba903.jpeg",
     "thumbshot_url": "https://d.scdn.gr/ds/shops/screenshots/452/20150731105054_75756119.png",
     "reviews_count": 492,
     "latest_reviews_count": 127,
     "review_score": 4.3,
     "payment_methods": {
       "credit_card": true,
       "paypal": false,
       "bank": true,
       "spot_cash": true,
       "installments": "Εώς 12 άτοκες δόσεις μέσω πιστωτικής κάρτας για αγορές άνω των 60 Ευρω.\r\nΕώς 48 δόσεις μέσω δανειοδότησης Κωτσόβολου."
     },
     "shipping": {
       "free": true,
       "free_from": 85,
       "free_from_info": "",
       "min_price": "3.99",
       "shipping_cost_enabled": true
     },
     "web_uri": "https://www.skroutz.gr/m/452/Kotsovolos",
     "extra_info": {
       "time_on_platform": "3+ χρόνια",
       "orders_per_week": "500+"
     },
     "top_positive_reasons": [
       "Καταρτισμένο προσωπικό",
       "Προσεγμένη συσκευασία προϊόντων",
       "Φιλική εξυπηρέτηση"
     ]
   }
 }
 */

public struct Shop:Decodable {
    
    

    public var id: Int
    public var name: String
    private var _link: String?
    public var phone: String
    private var _imageUrl: String?
    private var _thumbshotUrl: String?
    public var reviewsCount: Int
    public var latestReviewsCount: Int
    public var reviewScore: Double
    public var paymentMethods: PaymentMethods
    public var shipping:Shipping
    private var _webUri: String?
    public var extraInfo: ExtraInfo?
    public var topPositiveReasons: [String]?
    
//    emebedded structs
    public struct PaymentMethods: Decodable{
        public var creditCard: Bool
        public var paypal: Bool
        public var bank: Bool
        public var spotCash: Bool
        public var installments: String?
    }
    
    public struct Shipping:Decodable{
        public var free: Bool
        public var freeFrom: Int
        public var freeFromInfo: String?
        private var _minPrice: String?
        public var shippingCostEnabled: Bool
        
        
        enum CodingKeys: String, CodingKey {
            case free
            case freeFrom
            case freeFromInfo
            case _minPrice = "minPrice"
            case shippingCostEnabled
        }
        
        public var minPrice: Double?{
            if _minPrice != nil{
                return Double(_minPrice!)
            }else{
                return nil
            }
            
        }
        
        
        
    }
    public struct ExtraInfo: Decodable {
        var timeOnPlatform: String
        var ordersPerWeek: String
        
    }
    
//    getters for URLs
    
    public var link: URL?{
        get{
            if _link != nil{
            return URL(string: _link!)
            }else{
                return nil
            }
            

        }
    }

    public var webUri: URL?{
        get{
            if _webUri != nil{
                
                return URL(string: _webUri!)
                
            }else{
                return nil
            }
            

        }
    }
    
    public var thumbshotUrl: URL?{
        get{
            if _thumbshotUrl != nil{
                
                return URL(string: _thumbshotUrl!)
                
            }else{
                return nil
            }
            

        }
    }
    
    public var imageUrl: URL?{
        get{
            if _imageUrl != nil{
                
                return URL(string: _imageUrl!)
                
            }else{
                return nil
            }
            

        }
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case _link = "link"
        case phone
        case _imageUrl = "imageUrl"
        case _thumbshotUrl = "thumbshotUrl"
        case reviewsCount
        case latestReviewsCount
        case reviewScore
        case paymentMethods
        case shipping
        case _webUri = "webUri"
        case extraInfo
        case topPositiveReasons
    }
    
    
    

    
    
}

/*
 {
 "reviews": [
   {
     "id": 93026,
     "user_id": 208832,
     "review": "Έκανα την παραγγελία στις 26/1/17 - 14:45 , την ίδια μέρα το απόγευμα στέλνω mail ζητώντας να κρατηθεί το προϊόν αλλη μια μέρα αφού θα έλειπα εκτός Αθηνών. Λίγο αργότερα τηλεφωνώ ζητώντας το ίδιο πράγμα . Η ευγενέστατη υπάλληλος μου είπε πως αυτό δεν γινεται γιατι το σύστημα απο μόνο του μετά απο 72 ώρες ακυρώνει αυτόματα την παραγγελία. Εντάξει της λέω ,θα κάνω μια νέα παραγγελία την επόμενη μέρα για να παραλάβω το προϊόν στην πόλη της Χαλκίδας όπου και θα βρισκόμουν. Πηγαίνω λοιπόν στο κατάστημα για να το παραλάβω αλλά το προϊόν δεν υπήρχε , μου πρότειναν να πάρω το εκθεσιακό κομμάτι ,πράγμα το οποίο δεν δέχτηκα και μου είπαν να περιμένω 3 μέρες μέχρι να έρθει. Μετά απο όλη αυτή την περιπέτεια παρήγγειλα το προϊόν απο άλλο κατάστημα και ησύχασα. \r\nΝα σημειώσω οτι δέχτηκα τηλεφώνημα 4 μέρες μετά απο την εταιρία να με ρωτήσουν αν επικοινώνησε κανείς μαζί μου για το αίτημά που είχα κάνει.",
     "rating": 1.0,
     "shop_reply": null,
     "created_at": "2017-01-31T17:30:09+02:00",
     "negative": true,
     "reasons": [
       "Έλλειψη ενημέρωσης για την εξέλιξη της παραγγελίας",
       "Λανθασμένη διαθεσιμότητα",
       "Προβληματική επικοινωνία"
     ]
   },
 */
public struct ShopReview:Decodable{
    public var id: Int
    public var userId: Int
    public var review: String?
    public var rating: Double
    public var shopReply: String?
    public var createdAt: String //CHECK!!: maybe convert it to a date?
    public var negative: Bool
    public var reasons: [String]?
}
