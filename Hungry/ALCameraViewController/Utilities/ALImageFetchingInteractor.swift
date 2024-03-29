//
//  ALImageFetchingInteractor.swift
//  ALImagePickerViewController
//
//  Created by Alex Littlejohn on 2015/06/09.
//  Copyright (c) 2015 zero. All rights reserved.
//

import UIKit
import Photos

public typealias ALImageFetchingInteractorSuccess = (assets: [PHAsset]) -> ()
public typealias ALImageFetchingInteractorFailure = (error: NSError) -> ()

extension PHFetchResult: SequenceType {
    public func generate() -> NSFastGenerator {
        return NSFastGenerator(self)
    }
}

public class ALImageFetchingInteractor {

    private var success: ALImageFetchingInteractorSuccess?
    private var failure: ALImageFetchingInteractorFailure?
    
    private var authRequested = false
    private let errorDomain = "com.BeBiGo.Hungry"
    
    public func onSuccess(success: ALImageFetchingInteractorSuccess) -> Self {
        self.success = success
        return self
    }
    
    public func onFailure(failure: ALImageFetchingInteractorFailure) -> Self {
        self.failure = failure
        return self
    }
    
    public func fetch() -> Self {
        handleAuthorization(PHPhotoLibrary.authorizationStatus())
        return self
    }
    
    private func onAuthorized() {
        let options = PHFetchOptions()
        let assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: options)
        
        var imageAssets = [PHAsset]()
        
        for asset in assets {
            imageAssets.append(asset as! PHAsset)
        }
        
        success?(assets: imageAssets)
    }
    
    private func onDeniedOrRestricted() {
        let errorString = NSLocalizedString("error.access-denied", tableName: StringsTableName, comment: "error.access-denied")
        let errorInfo = [NSLocalizedDescriptionKey: errorString]
        let error = NSError(domain: errorDomain, code: 0, userInfo: errorInfo)
        failure?(error: error)
    }
    
    private func handleAuthorization(status: PHAuthorizationStatus) -> Void {
        switch status {
        case .NotDetermined:
            if !authRequested {
                PHPhotoLibrary.requestAuthorization(handleAuthorization)
                authRequested = true
            } else {
                onDeniedOrRestricted()
            }
            break
        case .Authorized:
            onAuthorized()
            break
        case .Denied, .Restricted:
            onDeniedOrRestricted()
            break
        }
    }
}
