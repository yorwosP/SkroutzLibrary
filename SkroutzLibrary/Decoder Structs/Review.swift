//
//  Review.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/29/19.
//

import Foundation

/*
 {
   "reviews": [
     {
       "id": 155965,
       "user_id": 352028,
       "review": "Το μονο κακο με το καινουριο IOS 10 ειναι οτι τελειωνει ΠΑΡΑ ΠΟΛΥ ΓΡΗΓΟΡΑ Η ΜΠΑΤΑΡΙΑ (εγω με χρηση browse,music,youtube,facebook κτλ ... χρειαζομαι 2 φορες την ημερα φορτιση ). Κατα τ αλλα παρα πολυ καλο κινητο ! με ποιοτητα κλησης και φωτογραφιας . Αξιζει τα λεφτα του :)",
       "rating": 5,
       "created_at": "2017-02-08T21:37:46+02:00",
       "demoted": false,
       "votes_count": 4,
       "helpful_votes_count": 1,
       "voted": false,
       "flagged": false,
       "helpful": false,
       "sentiments": {
         "positive": [
           "Ποιότητα κλήσης",
           "Φωτογραφίες",
           "Καταγραφή Video",
           "GPS",
           "Ταχύτητα",
           "Σχέση ποιότητας τιμής",
           "Ανάλυση οθόνης"
         ],
         "mediocre": [
           "Μουσική"
         ]
       }
     },
     {
   ],
 */



public struct Review: Decodable{
    public var id, userId: Int
    public var reviewText: String?
    public var rating: Int?
    public var createdAt: String?
    public var demoted: Bool?
    public var votesCount, helpfulVotesCount: Int?
    public var voted, flagged, helpful: Bool?
   
    public var sentiments: [String:[String]]?
    public var variation: Variation?
    
    
    public enum Sentiment: String, Decodable{
        case bad = "bad"
        case good = "good"
        case mediocre = "mediocre"
    }
    
    public struct Variation: Decodable {
        var skuID: Int?
        var label, variationLabel: String?
    }
    
    enum CodingKeys: String, CodingKey{
        case id, userId
        case reviewText = "review"
        case rating, createdAt, demoted
        case votesCount, helpfulVotesCount
        case voted, flagged, helpful
        case sentiments
        case variation
        
    }

    

}




