import UIKit

final class ViewController: UIViewController {
	private var buttons: [Button] { [firstButton, secondButton, thirdButton] }
	
	private let firstButton = Button(title: "First Button")
	private let secondButton = Button(title: "Second MediumButton")
	private let thirdButton = Button(title: "Third")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	private func setupUI() {
		view.backgroundColor = .white
		var previousBottomAnchor = view.safeAreaLayoutGuide.topAnchor
		
		buttons.forEach { button in
			view.addSubview(button)
			button.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				button.topAnchor.constraint(equalTo: previousBottomAnchor, constant: 10),
				button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
			])
			previousBottomAnchor = button.bottomAnchor
		}
		
		thirdButton.addAction(UIAction(handler: thirdButtonAction), for: .touchUpInside)
	}
	
	
	private func thirdButtonAction(action: UIAction) {
		let viewController = UIViewController()
		viewController.view.backgroundColor = .white
		
		present(viewController, animated: true) { [weak self] in
			self?.buttons.forEach { $0.updateStyle(for: .disabled) }
		}
	}
}
