import Foundation
import UIKit

protocol MonthSelectorViewDelegate: AnyObject {
    func didSelectMonth(_ month: Date)
    func isMonthSelected(_ month: Date) -> Bool
}
