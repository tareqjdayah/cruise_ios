

import Foundation

struct CruiseModel: Codable {
    let id :String
    let name: String
    let description: String
    let price: String
    let type: CruiseType
    
    let ship: String
    let nights: String
    let visitingPlaces: String
    let ports: String
}

enum CruiseType: String, Codable {
    case bahamas = "Bahamas"
    case caribbean = "Caribbean"
    case cuba = "Cuba"
    case sampler = "Sampler"
    case star = "Star"
}
