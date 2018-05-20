import UIKit
import PlaygroundSupport

final class ViewController: UIViewController {

    private lazy var progressView: PieProgressView = {
        let progressView = PieProgressView()
        progressView.margin = 6
        progressView.strokeThickness = 2
        progressView.tintColor = .lightGray
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)

        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 100),
            progressView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressView.progress = 1
    }

}

PlaygroundPage.current.liveView = ViewController()
