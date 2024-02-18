//

import UIKit

class ViewController: UIViewController {

    private lazy var squareView: UIView = {
        let side = 100
        let square = UIView(frame: CGRect(origin: .zero, size: CGSize(width: side, height: side)))
        square.backgroundColor = .systemBlue
        square.layer.cornerRadius = 12.0
        return square
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(squareView)
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.center = view.center
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveYourBody)))
    }

    @objc
    private func moveYourBody(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        let angle = countRotationAngle(point: touchPoint)
        let duration = 0.5

        UIView.animate(
            withDuration: duration * 0.8,
            animations: { [weak self] in
                self?.squareView.transform = CGAffineTransform(rotationAngle: angle)
            }
        )
        UIView.animate(
            withDuration: duration * 0.2,
            animations: { [weak self] in
                self?.squareView.transform = CGAffineTransform(rotationAngle: 0.0)
            }
        )

        UIView.animate(
            springDuration: duration, bounce: 0.5, initialSpringVelocity: 0.5, delay: 0.0, options: .curveEaseInOut,
            animations: {
                squareView.center = touchPoint
            }
        )
    }

    private func countRotationAngle(point: CGPoint) -> CGFloat {
        let dx = squareView.center.x - point.x
        let dy = squareView.center.y - point.y

        guard dx != 0, dy != 0 else {
            return 0.0
        }

        return absmin(atan(dx/dy), atan(dy/dx))
    }

    private func absmin(_ x: CGFloat, _ y: CGFloat) -> CGFloat {
        abs(x) < abs(y) ? x : y
    }
}

