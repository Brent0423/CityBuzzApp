import SwiftUI
import MapKit

struct Event: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let date: String
    let location: Location
    let category: String
    let description: String?
    
    init(id: UUID = UUID(), name: String, date: String, location: Location, category: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.date = date
        self.location = location
        self.category = category
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
        case location
        case category
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        
        // Decode location manually since Location doesn't conform to Decodable
        let locationContainer = try container.nestedContainer(keyedBy: Location.CodingKeys.self, forKey: .location)
        let name = try locationContainer.decode(String.self, forKey: .name)
        let area = try locationContainer.decode(String.self, forKey: .area)
        let city = try locationContainer.decode(String.self, forKey: .city)
        let address = try locationContainer.decode(String.self, forKey: .fullAddress)
        let latitude = try locationContainer.decode(Double.self, forKey: .latitude)
        let longitude = try locationContainer.decode(Double.self, forKey: .longitude)
        location = Location(name: name, area: area, city: city, fullAddress: address, latitude: latitude, longitude: longitude)
        
        category = try container.decode(String.self, forKey: .category)
        description = try container.decodeIfPresent(String.self, forKey: .description)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        
        // Encode location manually since Location doesn't conform to Encodable
        var locationContainer = container.nestedContainer(keyedBy: Location.CodingKeys.self, forKey: .location)
        try locationContainer.encode(location.name, forKey: .name)
        try locationContainer.encode(location.area, forKey: .area)
        try locationContainer.encode(location.fullAddress, forKey: .fullAddress)
        try locationContainer.encode(location.coordinate.latitude, forKey: .latitude)
        try locationContainer.encode(location.coordinate.longitude, forKey: .longitude)
        
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(description, forKey: .description)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}