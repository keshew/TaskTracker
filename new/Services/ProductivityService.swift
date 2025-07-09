import Foundation

struct Quote: Codable {
    let text: String
    let author: String
}

class ProductivityService {
    private static let lastUpdateKey = "lastQuoteUpdateDate"
    private static let currentQuoteKey = "currentQuote"
    
    static func fetchRandomQuote() async -> Quote {
        if shouldUpdateQuote() {
            // Get new random quote
            let randomQuote = QuoteData.quotes.randomElement()!
            
            // Save quote and update date
            if let encoded = try? JSONEncoder().encode(randomQuote) {
                UserDefaults.standard.set(encoded, forKey: currentQuoteKey)
            }
            UserDefaults.standard.set(Date(), forKey: lastUpdateKey)
            
            return randomQuote
        } else {
            // Return existing quote if available, otherwise get new one
            if let savedData = UserDefaults.standard.data(forKey: currentQuoteKey),
               let quote = try? JSONDecoder().decode(Quote.self, from: savedData) {
                return quote
            } else {
                // Fallback if something went wrong with storage
                return QuoteData.quotes.randomElement()!
            }
        }
    }
    
    private static func shouldUpdateQuote() -> Bool {
        guard let lastUpdate = UserDefaults.standard.object(forKey: lastUpdateKey) as? Date else {
            return true
        }
        
        return !Calendar.current.isDateInToday(lastUpdate)
    }
} 