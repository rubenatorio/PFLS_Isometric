//
//  GameLevelDelegate.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/12/13.
//
//

#import <Foundation/Foundation.h>

@protocol GameLevelDelegate <NSObject>

@required
-(void) levelDidfinish:(unsigned)levelID;
-(void) playerLost:(unsigned) levelID;

@end