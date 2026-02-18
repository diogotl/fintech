import Foundation
import UIKit

class MonthSelectorView: UIView {
    weak var delegate: MonthSelectorViewDelegate?
    private let calendar = Calendar.current
    private var months: [Date] = []

    private var selectedMonthIndex: Int = 0
    private var isScrollingProgrammatically = false

    private let collectionView: UICollectionView

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = Colors.gray200
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            MonthCell.self, forCellWithReuseIdentifier: MonthCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Public API

    func configure(with months: [Date], selectedMonth: Date) {
        self.months = months
        if let index = months.firstIndex(where: {
            calendar.isDate($0, equalTo: selectedMonth, toGranularity: .month)
        }) {
            selectedMonthIndex = index
        }

        collectionView.reloadData()

        // Scroll para o mês selecionado após layout
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.scrollToSelectedMonth(animated: false)
        }
    }

    func selectMonth(_ date: Date, animated: Bool = true) {
        guard
            let index = months.firstIndex(where: {
                calendar.isDate($0, equalTo: date, toGranularity: .month)
            })
        else { return }

        selectedMonthIndex = index
        collectionView.reloadData()
        scrollToSelectedMonth(animated: animated)
    }

    // MARK: - Private Methods

    private func scrollToSelectedMonth(animated: Bool) {
        guard selectedMonthIndex < months.count else { return }
        isScrollingProgrammatically = true
        let indexPath = IndexPath(item: selectedMonthIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)

        // Reset flag após animação
        DispatchQueue.main.asyncAfter(deadline: .now() + (animated ? 0.3 : 0.1)) { [weak self] in
            self?.isScrollingProgrammatically = false
        }
    }

    private func centerVisibleCell() {
        guard !isScrollingProgrammatically else { return }

        let centerPoint = CGPoint(
            x: collectionView.contentOffset.x + collectionView.bounds.width / 2,
            y: collectionView.bounds.height / 2
        )

        if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
            if selectedMonthIndex != indexPath.item {
                selectedMonthIndex = indexPath.item
                let selectedMonth = months[selectedMonthIndex]
                delegate?.didSelectMonth(selectedMonth)
                collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MonthSelectorView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int
    {
        return months.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: MonthCell.reuseIdentifier,
                for: indexPath
            ) as! MonthCell
        let month = months[indexPath.item]
        let isSelected = indexPath.item == selectedMonthIndex
        cell.configure(with: month, selected: isSelected)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MonthSelectorView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedMonthIndex != indexPath.item else { return }

        selectedMonthIndex = indexPath.item
        let selectedMonth = months[selectedMonthIndex]
        delegate?.didSelectMonth(selectedMonth)
        collectionView.reloadData()
        scrollToSelectedMonth(animated: true)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let month = months[indexPath.item]
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_PT")
        formatter.dateFormat = "MMM"
        let text = formatter.string(from: month).capitalized
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let padding: CGFloat = 24
        let textWidth = (text as NSString).size(withAttributes: [.font: font]).width
        return CGSize(width: ceil(textWidth + padding), height: collectionView.bounds.height)
    }
}

// MARK: - UICollectionViewDelegate (Scroll Handling)

extension MonthSelectorView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerVisibleCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerVisibleCell()
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // Garante que após scroll programático também centraliza
        if !isScrollingProgrammatically {
            centerVisibleCell()
        }
    }
}
