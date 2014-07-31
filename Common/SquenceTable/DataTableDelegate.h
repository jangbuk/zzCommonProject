//
//  DataTableDelegate.h
//  YFApp
//
//  Created by hutianyi100019 on 13-12-6.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zzADBookNode : NSObject

@property (retain,nonatomic) NSString *name;
@property (retain,nonatomic) NSString *photo;
@property (retain,nonatomic) NSString *company;
@property (assign,nonatomic) int sex;
@property (readwrite,nonatomic) int index;

@end

@protocol dataTableDelegate <NSObject>

@optional
- (void)didSelectNode:(zzADBookNode*)node;

@end



@interface DataTableDelegate : NSObject<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
	NSMutableArray *sectionArray;
	NSString *sectionName;
    NSInteger sectionNum;
}

@property (strong,nonatomic) NSMutableArray *searchArray;
@property (retain,nonatomic) NSMutableArray *allArray;

@property (retain,nonatomic) UITableView *parentTableView;

@property (nonatomic, assign, readonly) BOOL showSectionIndexes;
@property (retain, nonatomic)id<dataTableDelegate> delegate;
-(void)initTableData:(NSArray *)allDataArray;
@end
