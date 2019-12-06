import Foundation

func load<T: Decodable>(fileName: String, type: String) -> T? {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: type),
        let data = try? Data(contentsOf: url) else {
            return nil
    }

    return try? JSONDecoder().decode(T.self, from: data)
}
