//
//  MapModuleView.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 23..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "MapModuleView.h"

@implementation MapModuleView
@synthesize searhBar, resultView, kkuCanididateArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
        
        searhBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        searhBar.delegate = self;
        [self addSubview:searhBar];
        
        resultView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 480-88)];
        resultView.delegate = self;
        resultView.dataSource = self;
        
        
        
        
        UISwipeGestureRecognizer *rigthSwipegesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didRightSwipe:)];
        rigthSwipegesture.direction = UISwipeGestureRecognizerDirectionRight;
        [resultView addGestureRecognizer:rigthSwipegesture];
        [rigthSwipegesture release];
        
        [self addSubview:resultView];
        
        kkuCanididateArray = [[NSMutableArray alloc]init];
        
    }
    return self;
}

-(void)didRightSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.frame = CGRectMake(320, 44, 320, 480-44);
    
    [UIView commitAnimations];
    [self endEditing:YES];
    
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"MAPMODULE_CLOSE" object:self userInfo:nil];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [kkuCanididateArray removeAllObjects];
    
    NSString *url = @"http://test.inthe-movie.com/api/local";
	
	// HTTP Request 인스턴스 생성
	HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
	
	// POST로 전송할 데이터 설정
	NSMutableDictionary *bodyObject = [[NSMutableDictionary alloc]init];
    
    [bodyObject setValue:searchBar.text forKey:@"local"];
    
    
    
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
 
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject];
	
    
}




- (void)didReceiveFinished:(NSString *)result
{
    
    NSMutableArray *jsonArray = [[NSMutableArray alloc]init];
    
    NSArray *temp = [result componentsSeparatedByString:@"},"];
    
    for(int i =0; i<temp.count; i++)
    {
        
        NSString *tmp = [[result componentsSeparatedByString:@"},"] objectAtIndex:i];
        
        NSLog(@"tmp : %@", tmp);
        
        
        if(i==0)
        {
            tmp = [tmp substringFromIndex:1];
            
        }
        else if(i==(temp.count -1))
        {
            tmp = [tmp substringToIndex:tmp.length-2];
        }
        
        [jsonArray addObject: [tmp stringByAppendingFormat:@"%@", @"}"]];
        
    }
    
  
    
    NSMutableArray *detailAddressArray = [[NSMutableArray alloc]init];
      NSLog(@"go datil");
    
    for(int i =0; i<temp.count; i++)
    {
        
        NSMutableDictionary *nameKey = [[jsonArray objectAtIndex:i] objectFromJSONString];
        
        
        [detailAddressArray addObject:[NSString stringWithFormat:@"http://test.inthe-movie.com/api/detail/%@", [nameKey valueForKey:@"key"]]];
        
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                        [NSURL URLWithString:[detailAddressArray objectAtIndex:i]]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        [request setHTTPMethod:@"GET"];
        // [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString* aStr = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        
        //NSLog(@" ASTR : %@", aStr);
        NSDictionary *detail  = [aStr objectFromJSONString];
        
        
        
        
        KKCanididateDetail *kkCandi = [[KKCanididateDetail alloc]init];
        
        
        kkCandi.political_party = [detail valueForKey:@"political_party"];
        kkCandi.name =       [detail valueForKey:@"name"];
        kkCandi.area = [detail valueForKey:@"area"];
        kkCandi.opposite =   [detail valueForKey:@"opposite"];
        kkCandi.agree =   [detail valueForKey:@"agree"];
        kkCandi.leave =   [detail valueForKey:@"leave"];
        kkCandi.homepage =   [detail valueForKey:@"homepage"];
        
   
 
        kkCandi.business =   [detail valueForKey:@"business"];
        kkCandi.abstention=   [detail valueForKey:@"abstention"];
        kkCandi.not_vote=   [detail valueForKey:@"not_vote"];
        kkCandi.attendance=   [detail valueForKey:@"attendance"];
        kkCandi.photo=   [detail valueForKey:@"photo"];
        kkCandi.absence = [detail valueForKey:@"absence"];
        
        
        if(kkCandi.name.length >=2)
        { 
            [kkuCanididateArray addObject:kkCandi];
        }
        else
        {
            [kkCandi release];
        }
        
    }
    
    
    NSLog(@"OK kkuCanididateArray:%d", kkuCanididateArray.count);
    
    [resultView reloadData];
    [self endEditing:YES];
    
}

#pragma mark tableview codes

//섹션과 row로 cell의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 40;
    return cellHeight;
}



//셀선택
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    currentSelectedCandidate = [kkuCanididateArray objectAtIndex:indexPath.row];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.frame = CGRectMake(320, 44, 320, 480-44);
    
    [UIView commitAnimations];
    [self endEditing:YES];
    
    
    
     
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:indexPath forKey:@"index"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"MAPMODULE_CLOSE" object:self userInfo:userInfo];
     
    
    
}

//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    KKCanididateDetail *kkCandidateDetail = [kkuCanididateArray objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = kkCandidateDetail.name;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return kkuCanididateArray.count;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
