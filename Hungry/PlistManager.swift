import Foundation

public class PlistManager {
    
    private var plistpath: String?
    
    public class var defaultManager: PlistManager {
        struct Static {
            static let instance: PlistManager = PlistManager()
        }
        return Static.instance
    }
    
    /**
    Loads the plist with the given name and return
    its content as a NSMutableDictionary object.
    
    :param: fileName plist file name.
    
    :returns: NSMutableDictionary object it the file has content. nil if it's empty.
    */
    private func loadPlist(fileName: String) -> NSMutableDictionary? {
        let documentsDirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, . UserDomainMask, true).first as String?
        plistpath = documentsDirPath!.stringByAppendingPathComponent(fileName + ".plist") as String
        
        if let path = plistpath
        {
            let fileManager = NSFileManager.defaultManager()
            if !fileManager.fileExistsAtPath(path)
            {
                let bundleplistPath = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist")!
                
                let _: NSError?
                do
                {
                    try fileManager.copyItemAtPath(bundleplistPath, toPath: path)
                    return NSMutableDictionary(contentsOfFile: path)

                } catch
                {
                    print("Error copy file to Documents:")
                }
            }
            else
            {
                print("File already exists!")
                return NSMutableDictionary(contentsOfFile: path)
            }
        }
        return nil
    }
    
    /**
    Read the plist with the given name and
    return its content as a NSDictionary.
    
    :param: fileName plist file name.
    
    :returns: NSDictionary object if the file has content. nil if it's empty.
    */
    public func readPlist(fileName: String) -> NSDictionary? {
        return loadPlist(fileName)?.mutableCopy() as? NSDictionary
    }
    
    /**
    Update a value for teh given key in the given plist.
    
    :param: fileName plist file name.
    :param: key      key for the value.
    :param: value    new value to be updated.
    
    :returns: true if the update is successful. false if it fails.
    */
    public func updatePlist(fileName: String, key: String, value: AnyObject) -> Bool {
        if let path = plistpath {
            if NSFileManager.defaultManager().isWritableFileAtPath(path) {
                let updateDict = loadPlist(fileName)
                if let dict = updateDict {
                    dict.setValue(value, forKeyPath: key)
                    if dict.writeToFile(path, atomically: false) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    /*
    public func writeToPlist(fileName: String) -> Bool {
        if let path = plistpath {
            if NSFileManager.defaultManager().isWritableFileAtPath(path) {
                let dict = loadPlist(fileName)
                dict?.setDictionary(<#T##otherDictionary: [NSObject : AnyObject]##[NSObject : AnyObject]#>)
                if dict!.writeToFile(path, atomically: false) {
                    return true
                }
            }
        }
    return false
}*/

    /**
    Retrieve the value for the given key.
    
    :param: fileName plist file name.
    :param: keyPath  key for teh value.
    
    :returns: Value as an AnyObject if exists. nil if not.
    */
    public func getValueForKey(fileName: String, keyPath: String) -> AnyObject? {
        let fileContent = readPlist(fileName)
        if let fileContent = fileContent {
            for (key, value) in fileContent {
                let k = key as! String
                if k == keyPath {
                    return value
                }
            }
        }
        return nil
    }
}