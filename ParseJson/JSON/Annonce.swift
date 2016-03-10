//
//  Annonce.swift
//  JSON
//
//  Created by Matthieu Hannequin on 08/03/2016.
//  Copyright © 2016 Matthieu. All rights reserved.
//
import UIKit

class Annonce: NSObject, NSCoding
{
    //Url de type /User/Documents/..../
    private static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    // /user/document/.../liste
    private static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("list")
    
    //On stock ici toutes les annonces
    static var list = [Annonce]()
    
    //Avec le "=" et les "()" on initialise les variables (pas besoin de constructeur pour les instancier)
    var marque = String()
    var etat = String()
    var prix = NSNumber()
    var telephone = String()
    var image = String()
    
    override init()
    {
        super.init()
    }
    
    class func parseJSON(data : NSData)
    {
        do
        {
            let root = try NSJSONSerialization.JSONObjectWithData(data, options : .AllowFragments)
            print(root)
            guard let list = root [Constants.KeyAnnonces] as? [AnyObject] else
            {
                return
            }
            
            Annonce.list.removeAll()
            
            for item in list
                //if let item = list.first
            {
                let annonce = Annonce()
                if let x1 = item[Constants.KeyMarque] as? String
                {
                    print("\(x1)")
                    annonce.marque = x1
                }
                if let etat = item[Constants.KeyEtat] as? String
                {
                    print("\(etat)")
                    annonce.etat = etat
                }
                if let telephone = item[Constants.KeyTel] as? String
                {
                    print("\(telephone)")
                    annonce.telephone = telephone
                }
                if let prix = item[Constants.KeyPrix] as? NSNumber
                {
                    print("\(prix)")
                    annonce.prix = prix
                }
                if let img = item[Constants.KeyImg] as? String
                {
                    print("\(img)")
                    annonce.image = img
                }
                Annonce.list.append(annonce)
                print("####################################")
            }
            for annonce in Annonce.list
            {
                print ("marque = \(annonce.marque)")
                print ("etat = \(annonce.etat)")
                print ("telephone = \(annonce.telephone)")
                print ("prix = \(annonce.prix)")
                print ("image = \(annonce.image)")
                print ("//////////////////////////////////")
            }
            
            saveData()
            
        }
        catch
        {
            assert(false)
            return
        }
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(marque, forKey: Constants.KeyMarque)
        aCoder.encodeObject(prix, forKey: Constants.KeyPrix)
        aCoder.encodeObject(etat, forKey: Constants.KeyEtat)
        aCoder.encodeObject(telephone, forKey: Constants.KeyTel)
        aCoder.encodeObject(image, forKey: Constants.KeyImg)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        if let price = aDecoder.decodeObjectForKey(Constants.KeyPrix) as? NSNumber
        {
            prix = price
        }
        if let mark = aDecoder.decodeObjectForKey(Constants.KeyMarque) as? String
        {
            marque = mark
        }
        if let state = aDecoder.decodeObjectForKey(Constants.KeyEtat) as? String
        {
            etat = state
        }
        if let cellPhone = aDecoder.decodeObjectForKey(Constants.KeyTel) as? String
        {
            telephone = cellPhone
        }
        if let img = aDecoder.decodeObjectForKey(Constants.KeyImg) as? String
        {
            image = img
        }
    }
    
    class func saveData() -> Bool
    {
        print("Save to \(ArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject( list, toFile: ArchiveURL.path!)
    }
    
    class func loadData()
    {
        print("Load \(ArchiveURL.path!)")
        if let tempList = NSKeyedUnarchiver.unarchiveObjectWithFile(ArchiveURL.path!) as? [Annonce]
        {
            Annonce.list = tempList
        }
        for item in list
        {
            print(item)
        }
    }
    

}
