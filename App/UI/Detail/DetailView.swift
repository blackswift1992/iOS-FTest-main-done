//
//  DetailView.swift
//  App
//
//

import UIKit

class DetailView: UIView {
    private var items: [String]? {
        didSet {
            createUILabels()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addItems(_ items: [String]) {
        self.items = items
    }
    
    private func createUILabels() {
        guard let items = items else { return }
        
        var labelFrame = CGRect(x: 20, y: 20, width: self.frame.width - 40, height: 50)

        for i in 0..<items.count {
            let label = UILabel(frame: labelFrame)
            label.text = "\(items[i])"
            label.textAlignment = .center
            label.backgroundColor = .white
            label.layer.cornerRadius = 25.0
            label.clipsToBounds = true

            self.addSubview(label)

            labelFrame.origin.y += labelFrame.size.height + 20
        }
    }
}
