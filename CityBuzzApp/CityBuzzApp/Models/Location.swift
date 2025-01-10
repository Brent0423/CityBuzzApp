import MapKit

struct Location: Codable {
    let name: String
    let area: String
    let city: String
    let fullAddress: String
    var coordinate: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case name
        case area
        case city
        case fullAddress
        case latitude
        case longitude
    }
    
    init(name: String, area: String, city: String, fullAddress: String, latitude: Double = 0, longitude: Double = 0) {
        self.name = name
        self.area = area
        self.city = city
        self.fullAddress = fullAddress
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        area = try container.decode(String.self, forKey: .area)
        city = try container.decode(String.self, forKey: .city)
        fullAddress = try container.decode(String.self, forKey: .fullAddress)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(area, forKey: .area)
        try container.encode(city, forKey: .city)
        try container.encode(fullAddress, forKey: .fullAddress)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
} 