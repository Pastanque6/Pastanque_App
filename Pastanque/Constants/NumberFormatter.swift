import Foundation

extension NumberFormatter {
    static let flexibleDecimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    static func formatNumber(_ number: Double) -> String {
        let isInteger = floor(number) == number

        flexibleDecimalFormatter.minimumFractionDigits = isInteger ? 0 : 2
        
        return flexibleDecimalFormatter.string(from: NSNumber(value: number)) ?? "0"
    }
}
