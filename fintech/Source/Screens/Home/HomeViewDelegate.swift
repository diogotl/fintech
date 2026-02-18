protocol HomeViewDelegate: AnyObject {
    func didTapPlusButton()
    func didTapSettingsButton()
    func didTapSignOutButton()
    func didSwipeToNextMonth()
    func didSwipeToPreviousMonth()
}
