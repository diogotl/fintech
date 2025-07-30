import Foundation
import UIKit

class BudgetCell: UICollectionViewCell {
    
    static let reuseIdentifier = "BudgetCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Month"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()

    
    private func setupUI() {
        addSubview(icon)
        addSubview(monthLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            monthLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            monthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}
