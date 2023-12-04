
import Foundation

class HomeViewModel {

    func fetchCruiseList() -> [CruiseModel] {
        // Dummy data for demonstration purposes:
        return [
            CruiseModel(id: "1",name: "Bahamas Cruise", description: "Description for Bahamas Cruise", price: "79", type: .bahamas, ship: "Ship A", nights: "3", visitingPlaces: "Place A, Place B", ports: "Port A, Port B"),
            CruiseModel(id: "2",name: "Caribbean Cruise", description: "Description for Caribbean Cruise", price: "89", type: .caribbean, ship: "Ship B", nights: "5", visitingPlaces: "Place C, Place D", ports: "Port C, Port D"),
            CruiseModel(id: "3",name: "Cuba Cruise", description: "Description for Cuba Cruise", price: "99", type: .cuba, ship: "Ship C", nights: "7", visitingPlaces: "Place E, Place F", ports: "Port E, Port F"),
            CruiseModel(id: "4",name: "Sampler Cruise", description: "Description for Sampler Cruise", price: "109", type: .sampler, ship: "Ship D", nights: "2", visitingPlaces: "Place G, Place H", ports: "Port G, Port H"),
            CruiseModel(id: "5",name: "Star Cruise", description: "Description for Star Cruise", price: "119", type: .star, ship: "Ship E", nights: "6", visitingPlaces: "Place I, Place J", ports: "Port I, Port J")
        ]
    }

    
    func fetchCruises(forType type: String) -> [CruiseModel] {
          // Mockup filtering logic
        return fetchCruiseList().filter { $0.type.rawValue == type }
      }
}
