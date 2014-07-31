//
//  DataTableDelegate.m
//  YFApp
//
//  Created by hutianyi100019 on 13-12-6.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import "DataTableDelegate.h"
#import "pinyin.h"

@implementation zzADBookNode
@end

@implementation DataTableDelegate
-(void)initTableData:(NSArray *)allDataArray
{
    sectionArray = [[NSMutableArray alloc] init];
    self.allArray = allDataArray;
    for (int i = 0; i < 27; i++)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [sectionArray addObject:array];
        [array release];
    }
	for (zzADBookNode *node in allDataArray)
	{
        NSString *string = node.name;
		if([self searchResult:string searchText:@"曾"])
			sectionName = @"Z";
		else if([self searchResult:string searchText:@"解"])
			sectionName = @"X";
		else if([self searchResult:string searchText:@"仇"])
			sectionName = @"Q";
		else if([self searchResult:string searchText:@"朴"])
			sectionName = @"P";
		else if([self searchResult:string searchText:@"查"])
			sectionName = @"Z";
		else if([self searchResult:string searchText:@"能"])
			sectionName = @"N";
		else if([self searchResult:string searchText:@"乐"])
			sectionName = @"Y";
		else if([self searchResult:string searchText:@"单"])
			sectionName = @"S";
		else
			sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([string characterAtIndex:0])] uppercaseString];
		NSUInteger firstLetter = [ALPHA rangeOfString:[sectionName substringToIndex:1]].location;
		if (firstLetter != NSNotFound)
        {
            [[sectionArray objectAtIndex:firstLetter] addObject:node];
        }
	}
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.parentTableView)
    {
      return 27;
    }
    else
    {
       return 1;
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(tableView == self.parentTableView)
    {
        NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
        for (int i = 0; i < 27; i++)
            if ([[sectionArray objectAtIndex:i] count])
                [indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
        //[indices addObject:@"\ue057"]; // <-- using emoji
        return indices;
    }
    else
    {
        return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	if (title == UITableViewIndexSearch)
	{
		return -1;
	}
	return [ALPHA rangeOfString:title].location;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[sectionArray objectAtIndex:section] count] == 0)
    {
        return nil;
    }
    return [NSString stringWithFormat:@"%@", [[ALPHA substringFromIndex:section] substringToIndex:1]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.parentTableView)
    {
      return [[sectionArray objectAtIndex:section] count];
    }
    else
    {
        return self.searchArray.count;
    }
}

// Via Jack Lucky
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
	if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"ContactCell"] autorelease];
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    zzADBookNode *node=nil;
    if(tableView == self.parentTableView)
    {
	    node = [[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    else
    {
        node = [self.searchArray objectAtIndex:indexPath.row];
    }
	// Retrieve the crayon and its color
    cell.textLabel.text = [NSString stringWithFormat:@"       %@",node.name];
    
    UILabel *companyLabel = [[UILabel alloc]init];
    companyLabel.frame = CGRectMake(122, 5, 180, 34);
    companyLabel.font = [UIFont systemFontOfSize:9];
    companyLabel.textColor = [UIColor darkGrayColor];
    companyLabel.backgroundColor = [UIColor whiteColor];
    companyLabel.text =[NSString stringWithFormat:@"%@",node.company];
    [cell addSubview:companyLabel];
    
    UIImage *IMG =[UIImage imageNamed:@"tx.png"];
    zzImageView *photo = [[zzImageView alloc]initWithUrl:node.photo defImage:IMG];
    photo.frame = CGRectMake(10, 6, 30, 30);
    [cell addSubview:photo];
    
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.parentTableView)
    {
       zzADBookNode *node = [[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	   [self.delegate didSelectNode:node];
    }
    else
    {
        zzADBookNode *node = [self.searchArray objectAtIndex:indexPath.row];
        [self.delegate didSelectNode:node];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)text
{
    NSComparisonResult result = [contactName compare:text options:NSCaseInsensitiveSearch range:NSMakeRange(0, text.length)];
	if (result == NSOrderedSame)
		return YES;
	else
		return NO;
}




#pragma mark - Search Delegate
- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    NSAssert(YES, @"This method should be handled by a subclass!");
}
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.searchArray = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    self.searchArray = [[NSMutableArray alloc]init];
    for(int i=0;i<self.allArray.count;i++)
    {
        zzADBookNode *node = [self.allArray objectAtIndex:i];
        if([node.name rangeOfString:searchString].location != NSNotFound||
           [node.company rangeOfString:searchString].location != NSNotFound)
        {
           [self.searchArray addObject:node];
        }
    }
    return YES;
}
@end
