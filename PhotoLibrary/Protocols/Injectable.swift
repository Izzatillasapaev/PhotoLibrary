//
//  Injectable.swift
//  AKV
//
//  Created by Nurtugan Nuraly on 12/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
}
