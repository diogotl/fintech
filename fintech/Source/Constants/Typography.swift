import Foundation
import UIKit

public struct Typography {
    // Title Fonts
    static let titleLG = UIFont(name: "Lato-ExtraBold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .heavy)
    static let titleMD = UIFont(name: "Lato-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
    static let titleSM = UIFont(name: "Lato-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold) // Uppercase
    static let titleXS = UIFont(name: "Lato-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .bold) // Uppercase
    static let title2XS = UIFont(name: "Lato-Bold", size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .bold) // Uppercase

    // Text Fonts
    static let textSMRegular = UIFont(name: "Lato-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
    static let textSMBold = UIFont(name: "Lato-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    static let textXS = UIFont(name: "Lato-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)

    // Input Font
    static let input = UIFont(name: "Lato-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
    static let inputLineHeight: CGFloat = 24

    // Button Fonts
    static let buttonMD = UIFont(name: "Lato-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
    static let buttonMDLineHeight: CGFloat = 24
    
    static let buttonSM = UIFont(name: "Lato-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    static let buttonSMLineHeight: CGFloat = 20
}
