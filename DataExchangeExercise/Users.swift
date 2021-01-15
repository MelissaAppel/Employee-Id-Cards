

struct Users : Decodable {
    let id : Int
    let name : String
    let age : String
    
    let address : Address
    
    let salary : String
    let hiredate : String
    
}

struct Address : Decodable {
    let street : String
    let suite : String
    let city : String
    let zipcode : String
    
    let geo : Geo
}

struct Geo : Decodable {
    let latitude : String
    let longitude : String
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
