
import Foundation

protocol Injectable {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
}
