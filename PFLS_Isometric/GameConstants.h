//
//  GameConstants.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/4/13.


#ifndef PFLS_Isometric_GameConstants_h
#define PFLS_Isometric_GameConstants_h


/* Game Time Constants */
#define kTILE_MOVEMENT_SPEED 0.25f //Velocity of player (sec/tile)


/* Game TMX file names  should be kLEVELNAME_MAP_NAME*/
#define kTEST_LEVEL_MAP_NAME @"Maze.tmx"

/* Tiled Map Layer names */
#define kGROUND_LAYER   @"Floor"
#define kBARRIERS_LAYER  @"Barriers"

/* Game Touch dispatcher priorities */
#define kPLAYER_PRIORITY 0
#define kLEVEL_LAYER_PRIORITY 1

/* Game Level id's */

#define kTEST_LEVEL_ID 1

#endif
