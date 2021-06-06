//
//  BaseVM.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class BaseVM: NSObject {

    let isShowDialogLoading = LiveData(false)
    var isLoadingData = false

    let toastMessage = LiveData("")
}
