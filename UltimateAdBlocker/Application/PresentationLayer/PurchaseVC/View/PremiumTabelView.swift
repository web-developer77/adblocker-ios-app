//
//  PremiumTabelView.swift
//  UltimateAdBlocker
//
//  Created by Aira on 17.08.2021.
//

import UIKit

class PremiumTabelView: UITableView {

    //MARK: - Constructor
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Setup Table
    private func setupTable() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = false
        
        separatorStyle = .none
  
        tableFooterView = UIView()
        
        register(PremiumInfoTableViewCell.self, forCellReuseIdentifier: PremiumInfoTableViewCell.identifier)
        
        delegate = self
        dataSource = self
    }
    
}

//MARK: - UITableViewDelegate
extension PremiumTabelView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("\(tableView.frame.height)")
        print("\(tableView.frame.height / CGFloat(PremiumInfoModel.allCases.count))")
        return tableView.frame.height / CGFloat(PremiumInfoModel.allCases.count)
    }
    
}

//MARK: - UITableViewDataSource
extension PremiumTabelView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PremiumInfoModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PremiumInfoTableViewCell.identifier, for: indexPath) as! PremiumInfoTableViewCell
        
        let option = PremiumInfoModel(rawValue: indexPath.row)
        cell.data = option
        
        return cell
    }
}
