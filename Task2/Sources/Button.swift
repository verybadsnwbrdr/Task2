import UIKit

final class Button: UIButton {
	
	init(title: String) {
		super.init(frame: .zero)
		configuration = .plain()
		configuration?.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
		
		let attributeContainer = AttributeContainer([.foregroundColor: UIColor.white])
		let attributedTitle = AttributedString(title, attributes: attributeContainer)
		configuration?.attributedTitle = attributedTitle
		
		configuration?.image = UIImage(systemName: "globe")
		configuration?.imagePadding = 8
		configuration?.imagePlacement = .trailing
		configuration?.imageColorTransformer = imageColorTransformer()
		
		configurationUpdateHandler = _configurationUpdateHandler
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateStyle(for state: UIButton.State) {
		configuration?.background.backgroundColor = state == .disabled ? .systemGray2 : .systemBlue
		configuration?.attributedTitle?.foregroundColor = state == .disabled ? .systemGray3 : .white
	}
	
	private func _configurationUpdateHandler(_ button: UIButton) {
		UIView.animate(
			withDuration: 0.2,
			delay: 0,
			options: [.allowUserInteraction, .beginFromCurrentState]
		) { [self] in
			updateStyle(for: state)
			switch state {
			case .normal:
				transform = CGAffineTransform(scaleX: 1, y: 1)
			case .highlighted:
				transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
			default:
				break
			}
		}
	}
	
	private func imageColorTransformer() -> UIConfigurationColorTransformer {
		UIConfigurationColorTransformer { _ in self.state == .disabled ? .systemGray3 : .white }
	}
}
