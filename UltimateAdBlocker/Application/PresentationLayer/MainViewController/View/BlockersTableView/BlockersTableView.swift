//
//  BlockersTableView.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 02.03.2021.
//

import UIKit

protocol BlockersTableViewDelegate {
    func didSelectBlocker()
}

class BlockersTableView: UITableView {

    //MARK: - Properties
    private let data = BlockerModel.defaultBlockers
    
    var blockerDelegate: BlockersTableViewDelegate?
    
    //MARK: - Constructor
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
  
    
    //MARK: - Setup Table
    private func setupTable() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        isScrollEnabled = false
        
        separatorStyle = .none
  
        tableFooterView = UIView()
        
        register(BlockerTableViewCell.self, forCellReuseIdentifier: BlockerTableViewCell.identifier)
        
        delegate = self
        dataSource = self
        
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
    }
    
}


extension BlockersTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height/CGFloat(data.count)
    }
    
}


extension BlockersTableView: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlockerTableViewCell.identifier, for: indexPath) as? BlockerTableViewCell else { return UITableViewCell() }
        
        let rowData = data[indexPath.row]
        cell.data = rowData
        cell.delegate = self
        return cell
    }
    
}

extension BlockersTableView: BlockTableViewCellDelegate {
    func didChangeSwitch() {
        self.blockerDelegate?.didSelectBlocker()
    }
}
