import Foundation
import UIKit

class MonthSelectorView: UIView {
    weak var delegate: MonthSelectorViewDelegate?
    let calendar = Calendar.current
    let year = 2024
    var months: [Date] = []
    
    private var selectedMonthIndex: Int = 0

    func setupMonths() {

        for month in 1...12 {
            if let date = calendar.date(from: DateComponents(year: year, month: month, day: 1)) {
                months.append(date)
            }
        }
    }

    private let collectionView: UICollectionView

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupMonths()
        collectionView.backgroundColor = Colors.gray200
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MonthCell.self, forCellWithReuseIdentifier: "MonthCell")
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func setMonths(_ months: [Date]) {
        self.months = months
        collectionView.reloadData()
    }
}

extension MonthSelectorView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCell", for: indexPath)
            as! MonthCell
        let month = months[indexPath.item]
        let isSelected = indexPath.item == selectedMonthIndex
        cell.configure(with: month, selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int
    {
        return months.count
    }
}


extension MonthSelectorView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMonthIndex = indexPath.item
        let selectedMonth = months[selectedMonthIndex]
        print(selectedMonth)
        delegate?.didSelectMonth(selectedMonth)
        collectionView.reloadData()
    }
}
