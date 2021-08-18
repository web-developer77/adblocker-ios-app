
import UIKit

class SettingsTableView: UITableView {
    
    //MARK: - Properties
    var didSelectRow: ((SettingsModel) -> ())?
    
    
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
        
        register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        delegate = self
        dataSource = self
    }
    
}

//MARK: - UITableViewDelegate
extension SettingsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let option = SettingsModel(rawValue: indexPath.row) else { return }
        print("sd")
        self.didSelectRow?(option)
        
    }
    
}

//MARK: - UITableViewDataSource
extension SettingsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        
        let option = SettingsModel(rawValue: indexPath.row)
        cell.data = option
        
        return cell
    }
}
