//
//  ViewController.swift
//  ContextMenu
//
//  Created by Vladimir Sekerko on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let lists = ["Instagram", "Telegram", "Vk.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        requestContexMenu()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
    }
    
    private func requestContexMenu() {
        let contextMenu = UIContextMenuInteraction(delegate: self)
        logoImageView.isUserInteractionEnabled = true
        logoImageView.addInteraction(contextMenu)
    }
}

extension ViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let like = UIAction(title: "Like",
                                image: UIImage(systemName: "hand.thumbsup")) { _ in
                print("Like")
            }
            
            let subscribe = UIAction(title: "Subscribe",
                                     image: UIImage(systemName: "play.rectangle")) { _ in
                print("Subscribe")
            }
            
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash.slash"),
                                  attributes: .destructive) { _ in
                print("Delete")
            }
            
            let listAction = self.lists.map {
                UIAction(title: "Call to \($0)") { _ in
                    print("Call")
                }
            }
            
            let contactsMenu = UIMenu(title: "Contacts",
                                      options: .displayInline,
                                      children: listAction)
            
            return UIMenu(title: "Context Menu", children: [like, subscribe, contactsMenu, delete])
        }
    }
}

extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
