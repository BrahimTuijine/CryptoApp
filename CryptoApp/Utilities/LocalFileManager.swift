//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by MacBook on 09/11/2024.
//

import Foundation
import SwiftUI


//protocol MyFileManager {
//    
//    var folderName: String { get set }
//    
//    func createFolderIfNeeded() -> Void
//    
//    func getLocalImage(imageName: String) -> UIImage?
//    
//    func saveLocalImage(image: UIImage, imageName: String) -> Void
//    
//    func getURLForFolder() -> URL?
//}

class LocalFileManager  {
    
    static let instance = LocalFileManager()
    
    private init() {}
    
    private var folderName: String = "cryptoApp"
    
    private func createFolderIfNeeded() {
        guard let url = getURLForFolder() else { return }
        
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: url.path()) {
            do {
                try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
        }
    }
    
    func getLocalImage(imageName: String) -> UIImage? {
        guard let url = getURLForFolder()?.appendingPathComponent(imageName),
              FileManager.default.fileExists(atPath: url.path())
        else { return nil }
        
        return UIImage(contentsOfFile: url.path())
    }
    
    func saveLocalImage(image: UIImage, imageName: String) {
        
        // create folder
        createFolderIfNeeded()
        
        // get path for image
        guard let image = image.pngData(),
        let url = getURLForFolder()?.appendingPathComponent(imageName)
        else { return }
        
        // save image to path
        do {
            try image.write(to: url)
        } catch {
            print("Error saving image, ImageName: \(imageName) -> \(error.localizedDescription)")
        }
    }
    
    private func getURLForFolder() -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        // add folder name for my app -> path/"cryptoApp"
        return url.appendingPathComponent(folderName)
    }
}
