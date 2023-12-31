import UIKit

extension UICollectionView {
    convenience init(itemWidth: Int, itemHeight: Int, delegate: UICollectionViewDelegate? = nil, dataSource: UICollectionViewDataSource? = nil ) {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flow.scrollDirection = .horizontal
        flow.sectionInset.right = 15
        flow.sectionInset.left = 15
        self.init(frame: .zero, collectionViewLayout: flow)
        self.showsHorizontalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = delegate
        self.dataSource = dataSource
    }
}
