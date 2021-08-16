
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
        
        layer.cornerRadius = 30
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
    }
    
    //MARK: - Setup Table
    private func setupTable() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        isScrollEnabled = false
        
        separatorColor = #colorLiteral(red: 0.2196078431, green: 0.3098039216, blue: 0.4901960784, alpha: 0.5)
        separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
  
        tableFooterView = UIView()
        
        register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        delegate = self
        dataSource = self
    }
    
}

//MARK: - UITableViewDelegate
extension SettingsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height/CGFloat(SettingsModel.allCases.count)
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
