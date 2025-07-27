import Foundation
import UIKit

protocol HomeViewFlowDelegate: AnyObject {
    func openNewTransactionBottomSheet()
    func goToCreateMonthlyBudget()
}
