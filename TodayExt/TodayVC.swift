// AppGroupsSharing
    @IBOutlet weak var lastGlucoseInputLabel: UILabel!

        self.loadLastInput()
    
    func loadLastInput() {
        
        //set dateToday and have key for retrieving
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let glucoseDateStampKey = ("\(formatter.string(from: date))-InputGlucoseDateStampKey")

        //self.lastGlucoseInputLabel.text = glucoseDateStampKey
    }

// for VC

-(void)saveInputGlucoseForTodayExtension
{
    //set dateToday
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
    NSLog(@"localDateString        :%@", localDateString);
    NSLog(@"localTimeString       :%@", localTimeString);
    NSLog(@"utcDate       :%@", dateToday);
    NSLog(@"glucoseTimeStampKey       :%@", glucoseTimeStampKey);
    
    //save inputglucose
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.jp.co.arkray.e-SMBG"];
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
    [shared setObject:tempArray forKey:glucoseDateStampKey];
    [shared setObject:timeStampsArray forKey:glucoseTimeStampArrayKey];
    [shared synchronize];
}
