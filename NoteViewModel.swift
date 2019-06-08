import Foundation
class NoteViewModel
{
    var index           : Int16;
    var title           : String;
    var markDate        : String;
    var remind          : Bool;
    var ifNeedGift      : Bool;
    var giftRemindTime  : String;
    var addTime         : String;
    init(index:Int16,title:String,markDate:String,remind:Bool,ifNeedGift:Bool,giftRemindTime:String,addTime:String) {
        self.index = index;
        self.title = title;
        self.markDate = markDate;
        self.remind = remind;
        self.ifNeedGift = ifNeedGift;
        self.giftRemindTime = giftRemindTime;
        self.addTime = addTime;
    }
}
