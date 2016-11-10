//
//  PEDayPickerController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEDayPickerController.h"
#import "PEDayTableViewCell.h"

typedef NS_ENUM(NSInteger, PEDaySection) {
    PEDaySectionSunday,
    PEDaySectionMonday,
    PEDaySectionTuesday,
    PEDaySectionWednesday,
    PEDaySectionThrusday,
    PEDaySectionFriday,
    PEDaySectionSaturday
};

typedef NS_ENUM(NSInteger, PEDayStatus) {
    isOff,
    isOn
};

@interface PEDayPickerController ()<UITableViewDelegate,UITableViewDataSource,PEDayTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dayTableView;

@property (strong, nonatomic) NSMutableArray *daysArray;
@property (nonatomic, strong) void(^completionHandler)(NSMutableArray *);

@end

@implementation PEDayPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.daysArray = [[NSMutableArray alloc]init];
    
    [self.dayTableView registerNib:[UINib nibWithNibName:@"PEDayTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PEDayTableViewCell"];
    
    for (NSDictionary *dict in self.workingDaysArray) {
        NSInteger day = [[[dict objectForKey:@"close"] objectForKey:@"day"] integerValue];
        switch (day) {
            case 0:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 1:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 2:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 3:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 4:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 5:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 6:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
                
            default:
                break;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PEDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PEDayTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    
    if (indexPath.row == PEDaySectionSunday) {
        cell.cellTextLabel.text = @"Sunday";
    }
    else if (indexPath.row == PEDaySectionMonday) {
        cell.cellTextLabel.text = @"Monday";
    }
    else if (indexPath.row == PEDaySectionTuesday){
        cell.cellTextLabel.text = @"Tuesday";
    }
    else if (indexPath.row == PEDaySectionWednesday){
        cell.cellTextLabel.text = @"Wednesday";
    }
    else if (indexPath.row == PEDaySectionThrusday){
        cell.cellTextLabel.text = @"Thursday";
    }
    else if (indexPath.row == PEDaySectionFriday){
        cell.cellTextLabel.text = @"Friday";
    }
    else {
        cell.cellTextLabel.text = @"Saturday";
    }
    return cell;
}

-(void)dayTableViewCell:(PEDayTableViewCell *)cell didChangeStatus:(BOOL)status withIndexPath:(NSIndexPath *)indexPath{
    if (status == isOn){
        [self.daysArray addObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    else{
        [self.daysArray removeObject:[NSNumber numberWithInteger:indexPath.row]];
    }
}

- (IBAction)donePickingDays:(id)sender {
    NSMutableArray *arrayOfDays = [NSMutableArray new];
    for (NSNumber *num in self.daysArray) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSArray *daySymbols = dateFormatter.standaloneWeekdaySymbols;
        
        NSInteger dayIndex = [num integerValue]; // 0 = Sunday, ... 6 = Saturday
        NSString *dayName = daySymbols[dayIndex];
        
        NSMutableDictionary *close = [NSMutableDictionary dictionaryWithObjectsAndKeys:num,@"day",dayName, @"dayName", nil];
        NSMutableDictionary *open = [NSMutableDictionary dictionaryWithObjectsAndKeys:num,@"day",dayName, @"dayName", nil];
        NSMutableDictionary *mainDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:close,@"close",open,@"open", nil];
        [arrayOfDays addObject:mainDict];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        _completionHandler(arrayOfDays);
    }];
}

- (IBAction)cancelPicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)withCompletionHandler:(void(^)(NSMutableArray *days))handler{
    _completionHandler = handler;
}

@end
