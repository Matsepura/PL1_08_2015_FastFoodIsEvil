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
    PL1MyGameSceneReadyToThrow,
    PL1MyGameSceneStateDragging
};


@interface PL1MyGameScene ()

@property (nonatomic) BOOL didInitContent;
@property (nonatomic) PL1MyGameSceneState state;
@property (nonatomic, weak) SKPhysicsBody *bodyToThrow;
@property (nonatomic, weak) SKNode *nodeToThrow;
@property (nonatomic) CGPoint startDragPosition;

@end

@implementation PL1MyGameScene

#pragma mark - Setup

-(void)didMoveToView:(SKView *)view
{
    if (self.didInitContent == NO) {
        [self initContent];
    }
}

-(void)initContent
{
    
    SKPhysicsBody *border = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody = border;
    [self runAction:[SKAction waitForDuration:1] completion:^{
        self.didInitContent = YES;
        [self updateState];
    }];

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

#pragma mark - Touch Hangling

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (self.state) {
        case PL1MyGameSceneStateDragging:{
            UITouch *anyTouch = [touches anyObject];
            CGPoint touchPosition = [anyTouch locationInNode:self];
            self.nodeToThrow.position = touchPosition;
            
        }break;
            
        default:
            break;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (self.state) {
        case PL1MyGameSceneStateDragging:{
            CGPoint touchFinishPosition = [[touches anyObject] locationInNode: self];
        } break;
            
        default:
            break;
    }
    
}

#pragma mark - Game Mechanics

-(void)throwNode:(SKNode *)aNode withDirection:(CGVector)direction
{
    
}

-(void)putNodeToBallPosition:(SKNode *)aNode
{
    self.nodeToThrow = aNode;
    self.bodyToThrow = aNode.physicsBody;
    aNode.physicsBody = nil;
    [aNode runAction:[SKAction moveTo:CGPointMake(150, 200) duration:1] completion:^{
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
