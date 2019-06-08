import UIKit
import CoreData
var infos : [DiaryUserInfoMo] = []
var info : DiaryUserInfoMo!
class DataExtensions {
    static func fetcAllData()  {
        let context = kAppDelegate.persistentContainer.viewContext
        do {
            infos = try context.fetch(DiaryUserInfoMo.fetchRequest())
        } catch  {
            print(error)
        }
    }
}
