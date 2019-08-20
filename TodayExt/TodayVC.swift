// AppGroupsSharing
    @IBOutlet weak var lastGlucoseInputLabel: UILabel!

        self.loadLastInput()
    
    func loadLastInput() {
        
        // get date today
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        // generate key for retrieving
        let glucoseDateStampKey = ("\(formatter.string(from: date))-InputGlucoseDateStampKey")
        let glucoseTimeStampArrayKey = ("\(formatter.string(from: date))-InputGlucoseDateStampArrayKey")
        
        // set DataSharing for data retrieval from Main App
        if let sharedDefaults: UserDefaults = UserDefaults(suiteName:"group.jp.co.arkray.e-SMBG") {
            let timeStampsArray = sharedDefaults.object(forKey: glucoseTimeStampArrayKey) as! [String]
            let tempArray = sharedDefaults.object(forKey: glucoseDateStampKey)
            
            // for checking
            print("ForTodayExtension- timeStampsArray@Ext: \(String(describing: timeStampsArray))")
            print("ForTodayExtension- timeStampsArray@Ext: \(String(describing: timeStampsArray))")
            
        }
        
    }

// for VC

-(void)saveInputGlucoseForTodayExtension
{
    //g et dateToday
    NSDate *dateToday = [[NSDate alloc]init];
    
    // get current date today as String
    NSDateFormatter* localDate = [[NSDateFormatter alloc] init] ;
    [localDate setTimeZone:[NSTimeZone systemTimeZone]];
    [localDate setDateFormat:@"MM/dd/yyyy"];
    NSString* localDateString = [localDate stringFromDate:dateToday];
    
    // get current time today as String
    NSDateFormatter* localTime = [[NSDateFormatter alloc] init];
    [localTime setTimeZone:[NSTimeZone systemTimeZone]];
    [localTime setDateFormat:@"hh:mm a"];
    NSString* localTimeString = [localTime stringFromDate:dateToday];
    
    // set key for saving
    NSString* glucoseTimeStampKey = [localTimeString stringByAppendingString:@"-InputGlucoseTimeStampKey"];
    NSString* glucoseDateStampKey = [localDateString stringByAppendingString:@"-InputGlucoseDateStampKey"];
    NSString* glucoseTimeStampArrayKey = [localDateString stringByAppendingString:@"-InputGlucoseDateStampArrayKey"];
    
    // for checking
    NSLog(@"ForTodayExtension- localDateString: %@", localDateString);
    NSLog(@"ForTodayExtension- localTimeString: %@", localTimeString);
    NSLog(@"ForTodayExtension- utcDate: %@", dateToday);
    NSLog(@"ForTodayExtension- glucoseTimeStampKey: %@", glucoseTimeStampKey);
    
    // set DataSharing for App Extension
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.jp.co.arkray.e-SMBG"];
    //[shared setObject:glucoseTimeStampKey forKey:glucoseDateStampKey];
    
    // initialize empty arrays and dictionary
    NSMutableArray *timeStampsArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
    
    // save new user input with time stamp in dictionary
    [tempDic setObject:userGlucoseInput forKey:glucoseTimeStampKey];
    // save used time stamp in a seperate array
    [timeStampsArray addObject:glucoseTimeStampKey];
    // save new dictionary input to array of input recorded for today
    [tempArray addObject:tempDic];
    
    // save values for Data Sharing with extension
    [sharedDefaults setObject:tempArray forKey:glucoseDateStampKey];
    [sharedDefaults setObject:timeStampsArray forKey:glucoseTimeStampArrayKey];
    [sharedDefaults synchronize];
    
}
