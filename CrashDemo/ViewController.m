//
//  ViewController.m
//  CrashDemo
//
//  Created by changhongliang on 2017/12/20.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)connectionTest:(id)sender {
    NSMutableArray *statusCodeArray = [NSMutableArray new];
    
    for (int i = 200; i < 207; i++) {
        [statusCodeArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (NSString *statCode in statusCodeArray) {
        NSString *urlString = [NSString stringWithFormat:@"http://httpstat.us/%@", statCode];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self ];
        [connection start];
        
    }


}



@end
