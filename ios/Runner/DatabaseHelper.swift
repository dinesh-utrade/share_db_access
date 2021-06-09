//
//  DatabaseHelper.swift
//  Runner
//
//  Created by utrade on 09/06/21.
//

import Foundation
import SQLite

class DatabaseHelper{
        
    func openDb(){
        var sharedDb : Connection
        do {
            let sharedDirPath = getSharedContainerDirectoryPath().appending("/demo.db")
            sharedDb = try Connection(sharedDirPath)
//            let table = Table("emp")
//            let id = Expression<String>("id")
//            let name = Expression<String>("name")
//            let dept = Expression<String>("dept")
            
          //  let query = table.select(table[id],table[name],table[dept])
            
            do {
//                for result in try sharedDb.prepare(query) {
//                    let id = result[id]
//                    let name = result[name]
//                    var dept = result[dept]
//                }
                insertData(db:sharedDb)
            }catch let error{
              print("err-> \(error)")
            }
        }
        catch let err{
            print("Opening db \(err)")
        }
    }
    
    func insertData(db:Connection){
        let table = Table("emp")
        let idCol = Expression<String?>("id")
        let nameCol = Expression<String?>("name")
        let deptCol = Expression<String?>("dept")
        do{
          
            let insert =  table.insert(idCol <- "111",nameCol<-"Deva",deptCol<-"IT Dept")
            let rowid = try db.run(insert)
            print("data inserted successfully");
        }
        catch let err{
            print("error: \(err)")
        }
    }
    
    func getDocumentsDirectory() -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.path
    }

    func getSharedContainerDirectoryPath() -> String{
        let url =
            FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: "group.com.hashcove.thecove")

        let dirPath = url?.path ?? ""

        return dirPath
    }
}
