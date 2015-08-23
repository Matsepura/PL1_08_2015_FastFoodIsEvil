//
//  PL1MyGameScene.m
//  FastFoodIsEvil
//
//  Created by Semen on 23.08.15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL1MyGameScene.h"

typedef NS_ENUM(NSInteger, PL1MyGameSceneState) {
    PL1MyGameSceneInitial,
    PL1MyGameSceneReadyToThrow
};


@interface PL1MyGameScene ()

@property (nonatomic) BOOL didInitContent;
@property (nonatomic) PL1MyGameSceneState state;

@end

@implementation PL1MyGameScene

#pragma mark - Setup

-(void)didMoveToView:(SKView *)view
{
    if (self.didInitContent == NO) {
        [self didInitContent];
    }
}

-(void)initContent
{
    
    SKPhysicsBody *border = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody = border;

}

#pragma mark - UpdateState

-(void)updateState
{
    switch (self.state) {
        case PL1MyGameSceneInitial:{
            [self putNodeToBallPosition:[self nextObjectToThrow]];
            
        
        }break;
        case PL1MyGameSceneReadyToThrow:
            
            break;
        default:
            NSParameterAssert(NO);
            break;
    }
}

#pragma mark - Game Mechanics

-(void)putNodeToBallPosition:(SKNode *)aNode
{
    [aNode runAction:[SKAction moveTo:CGPointMake(40, 150) duration:1] completion:^{
        self.state = PL1MyGameSceneReadyToThrow;
    }];
}

-(SKNode *)nextObjectToThrow
{
    SKNode *meatBall = [self childNodeWithName:@"meatball"];
    NSAssert(meatBall, @"Not found meatball");
    return meatBall;
    
}



@end
