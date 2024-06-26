module Game exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Types exposing (..)
import GameMechanics exposing (..)
import Songs exposing (..)
import Conversions exposing (..)
import Shapes exposing (..)

game model =
    case model.state of
      SongFinished ->
        group
          [
          -- starry background and gradient
          [
            rect 200 200
            |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
            ,
            nightSky
            |> rotate (degrees 3*(model.time))
            ] |> group
              |> move (0, -30),
          -- guitar only shows up in background if user has already played game
          guitar model,
          createMenu,
            
            text "CONGRATS! PLAY AGAIN? "
          |> sansserif
          |> centered
          |> filled white
          |> scale 0.6
          |> move (0,40)
          ,
          -- rectangles that highlight when hovering
          roundedRect 140 27 5
          |> filled (rgb 121 248 245)
          |> move (0, -3)
          |> move (-200,0)
          |> (if model.middle then move (200,0) else identity)
          ,
          roundedRect 140 27 5
          |> filled (rgb 121 248 245)
          |> move (0, -30)
          |> move (-200,0)
          |>(if model.bottom then move (200,0) else identity)
          ,
          roundedRect 140 27 5
          |> filled (rgb 121 248 245)
          |> move (0, 24)
          |> move (-200,0)
          |> (if model.top then move (200,0) else identity)
          ,
          -- song names
          text "twinkle twinkle little star"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-2,21)
          ,
          text "smoke on the water"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-8,-7)
          ,
          text "eye of the tiger"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-15,-34)
          , 
          -- music notes
          musicButton
          |> move (0,1), 
          musicButton 
          |> move (0, 28), 
          musicButton
          |> move (0,56)
          ,
          --sensor rectangles (if you hover on these on the menu 
          --it will highlight the section)
          rect 152 30 -- middle
          |> filled yellow
          |> makeTransparent 0
          |> notifyEnter HoverMiddle
          |> notifyTap ToGameScreen
          |> notifyTap ChangeSmokeOn
          |> notifyLeave NonHoverMiddle,
         rect 152 30 -- top
          |> filled green
          |> move (0, 30)
          |> makeTransparent 0
          |> notifyEnter HoverTop
          |> notifyTap ChangeTwinkleT
          |> notifyLeave NonHoverTop
          |> notifyTap ToGameScreen
          ,
          rect 152 30 -- bottom
          |> filled red
          |> move (0, -30)
          |> makeTransparent 0
          |> notifyEnter HoverBottom
          |> notifyLeave NonHoverBottom
          |> notifyTap ToGameScreen
          |> notifyTap ChangeThird]
      TitleScreen ->
        group
        [
          -- starry background and gradient
          [
          rect 200 200
          |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
          ,
          nightSky
          |> rotate (degrees 3*(model.time))
          ] |> group
            |> move (0, -30)
          ,
          -- rotating circle design
          [
          -- circles at the top of the screen
          circle 10
            |> outlined (longdash 1.1) (rgb 255 27 242)
            |> scale (4)
            |> rotate (1*model.time)
            |> move (0, 10)
            |> makeTransparent (0.7)
            ,
          circle 10
            |> outlined (longdash 1.1) (rgb 255 215 0)
            |> scale (3)
            |> rotate (degrees 8*model.time)
            |> move (0, 10)
            |> makeTransparent (0.6)
            ,
          -- Circles on the bottom of the screen
          circle 10
            |> outlined (longdash 1.1) (rgb 255 27 242)
            |> scale (2)
            |> rotate (degrees 5*model.time)
            |> move (90, -70)
            |> makeTransparent (0.5)
            ,
          circle 10
            |> outlined (longdash 1.1) (rgb 255 215 0)
            |> scale (1.5)
            |> rotate (degrees 5*model.time)
            |> move (90, -70)
            |> makeTransparent (0.5)
            ,
          circle 10
            |> outlined (longdash 1.1) (rgb 255 27 242)
            |> scale (2.5)
            |> rotate (degrees -5*model.time)
            |> move (-90, -70)
            |> makeTransparent (0.5)
            ,
          circle 10
            |> outlined (longdash 1.1) (rgb 255 215 0)
            |> scale (2)
            |> rotate (degrees -5*model.time)
            |> move (-90, -70)
            |> makeTransparent (0.5)
          ] |> group
          ,
          [
          -- neon text design
          text "TIMELESS TUNES"
            |> sansserif
            |> centered
            |> filled (rgb 255 27 242)           
            |> scale(1.8)
            |> makeTransparent 0.8
          ,
          text "TIMELESS TUNES"
            |> sansserif
            |> centered
            |> outlined (solid 0.5) (rgb 121 248 245)
            |> scale (1.81)
            |> move (0, 0)
          
          --start button
          , roundedRect 80 20 5
            |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 27 36 77) 100, stop purple 1]))
            |> move (0, -50)
          ,roundedRect 80 20 5
            |> outlined (dashed 0.5) white
            |> move (0, -50)
            |>(if model.hoveringstart then move (-200, -250) else identity)
          ,text "PRESS START"
            |> sansserif
            |> centered
            |> outlined (solid 1) (rgb 121 248 245)
            |> scale 0.8
            |> move (200, 200)
            |>(if model.hoveringstart then move (-200, -253) else identity)
          , roundedRect 80 20 5
            |> outlined (dashed 1) white
            |> move (200, 200)
            |>(if model.hoveringstart then move (-200, -250) else identity)
          ,text "PRESS START"
            |> sansserif
            |> centered
            |> filled white
            |> scale 0.8
            |> move (0, -53)
            |> makeTransparent 0.9
          --sensor for start button
          ,roundedRect 80 20 5
            |> filled red
            |> move (0, -50)
            |> makeTransparent 0
            |> notifyEnter HoverPlay
            |> notifyLeave NonHoverPlay
            |> notifyTap ToHowToPlay -- change this, should be to menu
          ] |> group,
          -- the ground
          group [
          rect 400 40
            |> filled (rgb 27 36 77)
          ,
          --lines on the ground
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 20),
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 18),
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 15),
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 10),
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 2),
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, -9),
          rect 50 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees 70)
            |> move (-12,-3),
          rect 50 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees -70)
            |> move (12,-3),
          rect 65 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees 45)
            |> move (-36,-3),
          rect 65 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees -45)
            |> move (36,-3),
          rect 90 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees 30)
            |> move (-60,-3),
          rect 90 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees -30)
            |> move (60,-3),
          rect 150 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees 18)
            |> move (-100,-3),
          rect 150 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees -18)
            |> move (100,-3),
          rect 170 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees 8)
            |> move (-124,8),
           rect 170 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees -8)
            |> move (124,8),
          rect 170 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees 8)
            |> move (-154,8),
           rect 170 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees -8)
            |> move (154,8)
          ]
          |>move (0, -90)
        ] 
          |> move (0, 40)
          
      InfoScreen ->
        group
        [
          -- starry background and gradient
          [
          rect 200 200
          |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
          ,
          nightSky
          |> rotate (degrees 3*(model.time))
          ] |> group
            |> move (0, -30),

          guitar model,
          createMenu,
          
          -- rectangles that highlight when hovering
          roundedRect 140 30 5
          |> filled (rgb 121 248 245)
          |> move (-200,0)
          |> (if model.middle then move (200,0) else identity)
          ,
          roundedRect 140 30 5
          |> filled (rgb 121 248 245)
          |> move (0, -30)
          |> move (-200,0)
          |> (if model.bottom then move (200,0) else identity)
          ,
          roundedRect 140 30 5
          |> filled (rgb 121 248 245)
          |> move (0, 30)
          |> move (-200,0)
          |> (if model.top then move (200,0) else identity)
          ,
          --play button
          curve (-58.60,35.084) [Pull (-58.60,13.108) (-58.60,-8.867),Pull (-57.53,-13.09) (-52.81,-10.40),Pull (-36.43,-0.385) (-20.04,9.6385),Pull (-16.58,12.722) (-20.04,15.807),Pull (-36.62,26.024) (-53.20,36.240),Pull (-57.82,39.029) (-58.60,34.698)]
          |> filled white
          |> scale 0.27
          |> move (-45, 26),
          -- info circle
          circle 6
          |> filled white
          |> move (-43.5,4.2)
          |> move (-13, -5),
          text "i"
          |> filled black
          |> move (-45,0)
          |> move (-13,-5),
          -- i changes color when highlighted
          text "i"
          |> filled (rgb 121 248 245)
          |> move (-45,0)
          |> move (-13,-5)
          |> move (-200,0)
          |> (if model.middle then move (200,0) else identity),

          -- house icon
           group[openPolygon [(0,0),(-20,-20),(20,-20)]
            |> filled white
            |> move (0,10), 
            rect 10 20
            |>filled white
            |> move (10,-15)
            , rect 10 20
            |>filled white
            |> move (-10,-15), 
            rect 12 10
            |> filled white 
            |> move (0,-10)]
            |> move (-147, -68)
            |> scale 0.38,
          
          -- titles for buttons
          -- song names
          text "play game"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-26,27)
          ,
          text "how to play"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-25,-3)
          ,
          text "back to main screen"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-10,-34),

          --sensor rectangles (if you hover on these on the menu 
          --it will highlight the section)
          rect 152 30 -- middle
          |> filled yellow
          |> makeTransparent 0
          |> notifyEnter HoverMiddle
          |> notifyTap ToHowToPlay
          |> notifyLeave NonHoverMiddle,
          rect 152 30 -- top
          |> filled green
          |> move (0, 30)
          |> makeTransparent 0
          |> notifyEnter HoverTop
          |> notifyLeave NonHoverTop
          |> notifyTap ToPickASong,
          rect 152 30 -- bottom
          |> filled red
          |> move (0, -30)
          |> makeTransparent 0
          |> notifyEnter HoverBottom
          |> notifyLeave NonHoverBottom
          |> notifyTap ToTitleScreen
          ]
      -- make pick a song set model.time to 0
      PickASong ->
        group
        [
          -- starry background and gradient
          [
          rect 200 200
          |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
          ,
          nightSky
          |> rotate (degrees 3*(model.time))
          ] |> group
            |> move (0, -30),
          -- guitar only shows up in background if user has already played game
          guitar model
          |> move (-3000, 0)
          |>(if model.gameplayed then move (3000,0) else identity),
          createMenu,
          text "SELECT A SONG TO PLAY: "
          |> sansserif
          |> centered
          |> filled white
          |> scale 0.6
          |> move (0,40)
          ,
          -- rectangles that highlight when hovering
          roundedRect 140 27 5
          |> filled (rgb 121 248 245)
          |> move (0, -3)
          |> move (-200,0)
          |> (if model.middle then move (200,0) else identity)
          ,
          roundedRect 140 27 5
          |> filled (rgb 121 248 245)
          |> move (0, -30)
          |> move (-200,0)
          |>(if model.bottom then move (200,0) else identity)
          ,
          roundedRect 140 27 5
          |> filled (rgb 121 248 245)
          |> move (0, 24)
          |> move (-200,0)
          |> (if model.top then move (200,0) else identity)
          ,
          -- song names
          text "twinkle twinkle little star"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-2,21)
          ,
          text "smoke on the water"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-8,-7)
          ,
          text "eye of the tiger"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-15,-34)
          , 
          -- music notes
          musicButton
          |> move (0,1), 
          musicButton 
          |> move (0, 28), 
          musicButton
          |> move (0,56)
          ,
          --sensor rectangles (if you hover on these on the menu 
          --it will highlight the section)
          rect 152 30 -- middle
          |> filled yellow
          |> makeTransparent 0
          |> notifyEnter HoverMiddle
          |> notifyTap ToGameScreen
          |> notifyTap ChangeSmokeOn
          |> notifyLeave NonHoverMiddle,
         rect 152 30 -- top
          |> filled green
          |> move (0, 30)
          |> makeTransparent 0
          |> notifyEnter HoverTop
          |> notifyTap ChangeTwinkleT
          |> notifyLeave NonHoverTop
          |> notifyTap ToGameScreen
          ,
          rect 152 30 -- bottom
          |> filled red
          |> move (0, -30)
          |> makeTransparent 0
          |> notifyEnter HoverBottom
          |> notifyLeave NonHoverBottom
          |> notifyTap ToGameScreen
          |> notifyTap ChangeThird
          ]

      HowToPlay ->
        group
        [
        -- starry background and gradient
        [
          rect 200 200
          |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
          ,
          nightSky
          |> rotate (degrees 3*(model.time))
          ] |> group
            |> move (0, -30),
        -- guitar only shows up in background if user has already played game
        guitar model
          |> move (-3000, 0)
          |>(if model.gameplayed then move (3000,0) else identity),
        group[
        createSmallMenu
        |> (if not model.gameplayed then makeTransparent 0 else identity),
        createMenu
        |> (if model.gameplayed then makeTransparent 0 else identity),
        text "HOW TO PLAY: "
          |> sansserif
          |> centered
          |> filled white
          |> scale 0.6
          |> move (0,38)
          |> (if model.gameplayed then move (0, 7) else identity),
        -- how to play description
        description
        |> move (0,5)
        |> (if model.gameplayed then move (0, 7) else identity),
        -- back button code only shows up if user has played the game before
         group[
        --back button hollow
         group[curve (-95.63,-16.72) [Pull (-85.01,-25.14) (-78.90,-20),Pull (-75.66,-15.91) (-81.09,-11.27),Pull (-83.81,-13.81) (-86.54,-16.36),Pull (-86.54,-8.363) (-86.54,-0.363),Pull (-78.54,-0.181) (-70.54,0),Pull (-73.09,-2.727) (-75.63,-5.454),Pull (-67.19,-13.67) (-72,-21.09),Pull (-81.38,-30.94) (-96,-16.72)]
          |> outlined (solid 1.5) white
          |> scale 0.4
          |> rotate (degrees 45)]
          |> move (-45, 64),
         
         -- back button gets filled in when hovering
         group[curve (-95.63,-16.72) [Pull (-85.01,-25.14) (-78.90,-20),Pull (-75.66,-15.91) (-81.09,-11.27),Pull (-83.81,-13.81) (-86.54,-16.36),Pull (-86.54,-8.363) (-86.54,-0.363),Pull (-78.54,-0.181) (-70.54,0),Pull (-73.09,-2.727) (-75.63,-5.454),Pull (-67.19,-13.67) (-72,-21.09),Pull (-81.38,-30.94) (-96,-16.72)]
          |> filled white
          |> scale 0.4
          |> rotate (degrees 45)
          |> move (-45, 64) -- -54, 90
          ]
          |> move (-200, 200)
          |> (if model.hovering2 then move (200,-200) else identity),
        -- sensor for back button
          rect 20 25
          |> filled red
          |> move (-69,31)
          |> makeTransparent 0
          |> notifyEnter HoverPause
          |> notifyLeave NonHoverPause
          |> notifyTap ToInfoScreen
         ]
          |> move (-3000, 7)
          |>(if model.gameplayed then move (3000,0) else identity),
        
        -- got it box

        --start button
          [
            
          curve (6.0631,-47.38) [Pull (6.0631,-31.66) (6.0631,-15.94),Pull (4.4912,-15.94) (2.9192,-15.94),Pull (1.3719,-16.01) (0.2245,-14.59),Pull (-0.426,-13.16) (1.1228,-11.45),Pull (4.7157,-7.185) (8.3087,-2.919),Pull (9.2070,-1.850) (10.105,-2.021),Pull (10.888,-1.954) (12.350,-3.368),Pull (15.943,-7.635) (19.536,-11.90),Pull (20.361,-13.02) (19.985,-14.14),Pull (19.472,-15.52) (18.638,-15.49),Pull (16.392,-15.49) (14.147,-15.49),Pull (14.147,-31.66) (14.147,-47.83),Pull (13.690,-50.56) (10.554,-50.97),Pull (7.0487,-51.33) (6.0631,-47.38)]
            |> filled black --(rgb 255 27 242) 
            |> rotate (degrees -90) 
            |> makeTransparent 0.6
            |> scale 1.2 --
            |> move (50, -35)
          ,curve (6.0631,-47.38) [Pull (6.0631,-31.66) (6.0631,-15.94),Pull (4.4912,-15.94) (2.9192,-15.94),Pull (1.3719,-16.01) (0.2245,-14.59),Pull (-0.426,-13.16) (1.1228,-11.45),Pull (4.7157,-7.185) (8.3087,-2.919),Pull (9.2070,-1.850) (10.105,-2.021),Pull (10.888,-1.954) (12.350,-3.368),Pull (15.943,-7.635) (19.536,-11.90),Pull (20.361,-13.02) (19.985,-14.14),Pull (19.472,-15.52) (18.638,-15.49),Pull (16.392,-15.49) (14.147,-15.49),Pull (14.147,-31.66) (14.147,-47.83),Pull (13.690,-50.56) (10.554,-50.97),Pull (7.0487,-51.33) (6.0631,-47.38)]
            -- outlined (solid 2) (rgb 255 27 242)  
            |> outlined (dashed 0.5) white
            |> rotate (degrees -90)
            |> makeTransparent 1
            |>(if model.hoveringstart then move (-10000, -10000) else identity)
            |> scale 1.2 --
            |> move (50, -35)
          ,text "NEXT"
            |> sansserif
            |> centered
            |> outlined (solid 1) (rgb 121 248 245)
            |> scale 0.7
            |> move (16, 3)
            |> move (200, 200)
            |> (if model.hoveringstart then move (-200, -253) else identity)
          ,curve (6.0631,-47.38) [Pull (6.0631,-31.66) (6.0631,-15.94),Pull (4.4912,-15.94) (2.9192,-15.94),Pull (1.3719,-16.01) (0.2245,-14.59),Pull (-0.426,-13.16) (1.1228,-11.45),Pull (4.7157,-7.185) (8.3087,-2.919),Pull (9.2070,-1.850) (10.105,-2.021),Pull (10.888,-1.954) (12.350,-3.368),Pull (15.943,-7.635) (19.536,-11.90),Pull (20.361,-13.02) (19.985,-14.14),Pull (19.472,-15.52) (18.638,-15.49),Pull (16.392,-15.49) (14.147,-15.49),Pull (14.147,-31.66) (14.147,-47.83),Pull (13.690,-50.56) (10.554,-50.97),Pull (7.0487,-51.33) (6.0631,-47.38)]
            |> outlined (dashed 0.8) white
            |> rotate (degrees -90)
            |> scale 1.2 --
            |> move (10000, 10000)
            |> move (50, -35)
            |> (if model.hoveringstart then move (-10000, -10000) else identity)
          ,text "NEXT"
            |> sansserif
            |> centered
            |> filled white
            |> scale 0.7
            |> move (16, 3)
            |> move (0, -53)
            |> makeTransparent 0.9
          --sensor for start button
          ,curve (6.0631,-47.38) [Pull (6.0631,-31.66) (6.0631,-15.94),Pull (4.4912,-15.94) (2.9192,-15.94),Pull (1.3719,-16.01) (0.2245,-14.59),Pull (-0.426,-13.16) (1.1228,-11.45),Pull (4.7157,-7.185) (8.3087,-2.919),Pull (9.2070,-1.850) (10.105,-2.021),Pull (10.888,-1.954) (12.350,-3.368),Pull (15.943,-7.635) (19.536,-11.90),Pull (20.361,-13.02) (19.985,-14.14),Pull (19.472,-15.52) (18.638,-15.49),Pull (16.392,-15.49) (14.147,-15.49),Pull (14.147,-31.66) (14.147,-47.83),Pull (13.690,-50.56) (10.554,-50.97),Pull (7.0487,-51.33) (6.0631,-47.38)]
            |> filled red
            |> rotate (degrees -90) 
            |> scale 1.2 --
            |> move (50, -35)
            |> makeTransparent 0
            |> notifyEnter HoverPlay
            |> notifyLeave NonHoverPlay
            |> notifyTap ToPickASong -- change this, should be to menu
          ] |> group
            |> scale 0.7
            |> move (-13, 25) -- (30,27)
            |> (if model.gameplayed then move (-3000,0) else identity)

        ]
        ,
        guitar model
        |> scale 0.7
        |> move (110, -20)
        |> (if model.gameplayed then move (5000,0) else identity),

        -- example of green dot
        group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-130,-39)
                |> scale 0.5
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-130,-39)     
                |> scale 0.5      
                |> makeTransparent 0.7]
                |> scale 0.7
                |> move (110, -20)
                |> (if 0.2*sin(model.time+(pi/2))>0 then makeTransparent 0 else identity)
                |> (if model.gameplayed then move (5000,0) else identity),
        -- pointer finger
        curve (-43.2,26.24) [Pull (-38.72,29.92) (-34.24,33.6),Pull (-31.53,37.44) (-34.24,41.28),Pull (-37.09,44.800) (-42.24,42.56),Pull (-55.2,32.160) (-68.16,21.76),Pull (-74.01,17.739) (-72.96,9.6),Pull (-72.96,2.88) (-72.96,-3.84),Pull (-70.61,-16.31) (-58.56,-18.24),Pull (-43.52,-18.08) (-28.48,-17.92),Pull (-24.52,-17.49) (-23.68,-12.48),Pull (-23.38,-9.92) (-26.24,-7.36),Pull (-24.47,-7.04) (-22.72,-6.72),Pull (-18.88,-4.199) (-18.88,-1.28),Pull (-18.86,1.3200) (-21.76,3.52),Pull (-14.98,3.8200) (-14.72,9.28),Pull (-14.50,11.68) (-16.96,14.08),Pull (-8,14.4) (0.96,14.72),Pull (6.1599,16.420) (6.4,20.8),Pull (6.3199,25.799) (0.64,26.88),Pull (-21.12,26.4) (-42.88,25.92)]
        |> outlined (solid 7) black
        -- scale 0.2
        |> rotate (degrees 90)
        |> move (450, -230)
        |> (if model.gameplayed then move (5000,0) else identity)
        |> scale (0.2*(sin(model.time)+4)/4),
        curve (-43.2,26.24) [Pull (-38.72,29.92) (-34.24,33.6),Pull (-31.53,37.44) (-34.24,41.28),Pull (-37.09,44.800) (-42.24,42.56),Pull (-55.2,32.160) (-68.16,21.76),Pull (-74.01,17.739) (-72.96,9.6),Pull (-72.96,2.88) (-72.96,-3.84),Pull (-70.61,-16.31) (-58.56,-18.24),Pull (-43.52,-18.08) (-28.48,-17.92),Pull (-24.52,-17.49) (-23.68,-12.48),Pull (-23.38,-9.92) (-26.24,-7.36),Pull (-24.47,-7.04) (-22.72,-6.72),Pull (-18.88,-4.199) (-18.88,-1.28),Pull (-18.86,1.3200) (-21.76,3.52),Pull (-14.98,3.8200) (-14.72,9.28),Pull (-14.50,11.68) (-16.96,14.08),Pull (-8,14.4) (0.96,14.72),Pull (6.1599,16.420) (6.4,20.8),Pull (6.3199,25.799) (0.64,26.88),Pull (-21.12,26.4) (-42.88,25.92)]
        |> filled white
        -- scale 0.2
        |> rotate (degrees 90)
        |> move (450, -230)
        |> (if model.gameplayed then move (5000,0) else identity)
        |> scale (0.2*(sin(model.time)+4)/4),


        -- how to play animation in the game
        group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-2.5,-55)
                |> scale 0.5
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-2.5,-55)    
                |> scale 0.5      
                |> makeTransparent 0.7]
                -- move (110, -20)
                |> (if 0.2*sin(model.time+(pi/2))>0 then makeTransparent 0 else identity)
                |> (if not model.gameplayed then move (5000,0) else identity),
        -- pointer finger
        curve (-43.2,26.24) [Pull (-38.72,29.92) (-34.24,33.6),Pull (-31.53,37.44) (-34.24,41.28),Pull (-37.09,44.800) (-42.24,42.56),Pull (-55.2,32.160) (-68.16,21.76),Pull (-74.01,17.739) (-72.96,9.6),Pull (-72.96,2.88) (-72.96,-3.84),Pull (-70.61,-16.31) (-58.56,-18.24),Pull (-43.52,-18.08) (-28.48,-17.92),Pull (-24.52,-17.49) (-23.68,-12.48),Pull (-23.38,-9.92) (-26.24,-7.36),Pull (-24.47,-7.04) (-22.72,-6.72),Pull (-18.88,-4.199) (-18.88,-1.28),Pull (-18.86,1.3200) (-21.76,3.52),Pull (-14.98,3.8200) (-14.72,9.28),Pull (-14.50,11.68) (-16.96,14.08),Pull (-8,14.4) (0.96,14.72),Pull (6.1599,16.420) (6.4,20.8),Pull (6.3199,25.799) (0.64,26.88),Pull (-21.12,26.4) (-42.88,25.92)]
        |> outlined (solid 7) black
        -- scale 0.2
        |> rotate (degrees 90)
        |> move (15, -190) -- 450, -230
        |> (if not model.gameplayed then move (5000,0) else identity)
        |> scale (0.2*(sin(model.time)+4)/4),
        curve (-43.2,26.24) [Pull (-38.72,29.92) (-34.24,33.6),Pull (-31.53,37.44) (-34.24,41.28),Pull (-37.09,44.800) (-42.24,42.56),Pull (-55.2,32.160) (-68.16,21.76),Pull (-74.01,17.739) (-72.96,9.6),Pull (-72.96,2.88) (-72.96,-3.84),Pull (-70.61,-16.31) (-58.56,-18.24),Pull (-43.52,-18.08) (-28.48,-17.92),Pull (-24.52,-17.49) (-23.68,-12.48),Pull (-23.38,-9.92) (-26.24,-7.36),Pull (-24.47,-7.04) (-22.72,-6.72),Pull (-18.88,-4.199) (-18.88,-1.28),Pull (-18.86,1.3200) (-21.76,3.52),Pull (-14.98,3.8200) (-14.72,9.28),Pull (-14.50,11.68) (-16.96,14.08),Pull (-8,14.4) (0.96,14.72),Pull (6.1599,16.420) (6.4,20.8),Pull (6.3199,25.799) (0.64,26.88),Pull (-21.12,26.4) (-42.88,25.92)]
        |> filled white
        -- scale 0.2
        |> rotate (degrees 90)
        |> move (15, -190)
        |> (if not model.gameplayed then move (5000,0) else identity)
        |> scale (0.2*(sin(model.time)+4)/4)]

      GameScreen ->
        let 
          timer = model.time - model.startTime
        in
        group
        [
        -- starry background and gradient
        [
          rect 200 200
          |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
          ,
          nightSky
          |> rotate (degrees 3*(model.time))
          ] |> group
            |> move (0, -30)
         ,
          -- PROGRESS BAR HERE
          progressBar model.totalSections model.sectionsCompleted
         ,

          -- song title depends on song selected
          text "twinkle twinkle"
            |> sansserif
            |> centered
            |> filled (rgb 255 27 242)           
            |> scale(1)
            |> move (-33, 32)
            -- makeTransparent 0.8
            |> (if model.songname == TwinkleT then makeTransparent 0.8 else makeTransparent 0)
          ,
          text "twinkle twinkle"
            |> sansserif
            |> centered
            |> outlined (solid 0.5) (rgb 121 248 245)
            |> scale (1.01)
            |> move (-33, 32)
            |> (if model.songname == TwinkleT then makeTransparent 1 else makeTransparent 0),

          -- smoke on the water
          text "smoke on the water"
            |> sansserif
            |> centered
            |> filled (rgb 255 27 242)           
            |> scale(0.89)
            |> move (-33, 32)
            -- makeTransparent 0.8
            |> (if model.songname == SmokeOn then makeTransparent 0.8 else makeTransparent 0)
          ,
          text "smoke on the water"
            |> sansserif
            |> centered
            |> outlined (solid 0.5) (rgb 121 248 245)
            |> scale (0.9)
            |> move (-33, 32)
            |> (if model.songname == SmokeOn then makeTransparent 1 else makeTransparent 0),

            -- eye of the tiger
          text "eye of the tiger"
            |> sansserif
            |> centered
            |> filled (rgb 255 27 242)           
            |> scale(0.89)
            |> move (-33, 32)
            -- makeTransparent 0.8
            |> (if model.songname == Third then makeTransparent 0.8 else makeTransparent 0)
          ,
          text "eye of the tiger"
            |> sansserif
            |> centered
            |> outlined (solid 0.5) (rgb 121 248 245)
            |> scale (0.9)
            |> move (-33, 32)
            |> (if model.songname == Third then makeTransparent 1 else makeTransparent 0),

         --back button hollow
         group[curve (-95.63,-16.72) [Pull (-85.01,-25.14) (-78.90,-20),Pull (-75.66,-15.91) (-81.09,-11.27),Pull (-83.81,-13.81) (-86.54,-16.36),Pull (-86.54,-8.363) (-86.54,-0.363),Pull (-78.54,-0.181) (-70.54,0),Pull (-73.09,-2.727) (-75.63,-5.454),Pull (-67.19,-13.67) (-72,-21.09),Pull (-81.38,-30.94) (-96,-16.72)]
          |> outlined (solid 1.5) white
          |> scale 0.6
          |> rotate (degrees 45)]
          |> move (-54, 90),
         
         -- back button gets filled in when hovering
         group[curve (-95.63,-16.72) [Pull (-85.01,-25.14) (-78.90,-20),Pull (-75.66,-15.91) (-81.09,-11.27),Pull (-83.81,-13.81) (-86.54,-16.36),Pull (-86.54,-8.363) (-86.54,-0.363),Pull (-78.54,-0.181) (-70.54,0),Pull (-73.09,-2.727) (-75.63,-5.454),Pull (-67.19,-13.67) (-72,-21.09),Pull (-81.38,-30.94) (-96,-16.72)]
          |> filled white
          |> scale 0.6
          |> rotate (degrees 45)
          |> move (-54, 90)
          ,
          --message that pops up when hovering
          roundedRect 37 10 1
          |> filled (rgb 150 87 205)
          |> move (-52,50),
          
          roundedRect 37 10 1
          |> outlined (dashed 0.3) white
          |> move (-52,50),
          
          text "quit game?"
            |> sansserif
            |> centered
            |> filled white
            |> scale (0.5)
            |> move (-52, 48)
          ]
          |> move (-200, 200)
          |> (if model.hovering2 then move (200,-200) else identity),
          -- sensor for back button
           rect 20 25
          |> filled red
          |> move (-83,51)
          |> makeTransparent 0
          |> notifyEnter HoverPause
          |> notifyLeave NonHoverPause
          |> notifyTap ToInfoScreen, 


        guitar model,
        guitarsensors model,
      
        (noteToGuitarGuideButton model.guideNote model)
        |> notifyMouseDown GuideNoteDown
        |> notifyMouseDown (PlayNote model.guideNote)
        |> notifyMouseUp GuideNoteUp
        |> notifyMouseUp (UpdateGuideNote model.noteList)
        |> (if model.guideNote == G then notifyEnter Hover2 
        else if model.guideNote == GSharp then notifyEnter Hover2 
        else if model.guideNote == FSharp then notifyEnter Hover5 
        else if model.guideNote == B then notifyEnter Hover6
        else if model.guideNote == D then notifyEnter Hover6
        else if model.guideNote == E then notifyEnter Hover6
        else if model.guideNote == ASharp then notifyEnter Hover4
        else if model.guideNote == CSharp then notifyEnter Hover4
        else if model.guideNote == A then notifyEnter Hover4
        else if model.guideNote == C then notifyEnter Hover1
        else if model.guideNote == DSharp then notifyEnter Hover1
        else if model.guideNote == F then notifyEnter Hover3
        else identity)

        -- animate buttons
        ]    



nightSky =
  group
  [
  group
  [ circle 0.4 |> filled white |> move (80, -60),
    circle 0.3 |> filled white |> move (60, -80),
    circle 0.4 |> filled white |> move (-50, 70),
    circle 0.5 |> filled white |> move (40, -60),
    circle 0.3 |> filled white |> move (-30, 50),
    circle 0.4 |> filled white |> move (20, -40),
    circle 0.5 |> filled white |> move (-10, 30),
    circle 0.3 |> filled white |> move (0, -20),
    circle 0.4 |> filled white |> move (10, 10),
    circle 0.5 |> filled white |> move (-20, 20),
    circle 0.3 |> filled white |> move (30, -30),
    circle 0.4 |> filled white |> move (-40, 40),
    circle 0.5 |> filled white |> move (50, -50),
    circle 0.3 |> filled white |> move (-60, 60),
    circle 0.4 |> filled white |> move (70, -70),
    circle 0.4 |> filled white |> move (60, 0),
    circle 0.4 |> filled white |> move (-50, -50),
    circle 0.5 |> filled white |> move (40, 40),
    circle 0.3 |> filled white |> move (-30, -30),
    circle 0.4 |> filled white |> move (20, 20),
    circle 0.5 |> filled white |> move (-10, -10)
    ],
    group
    [ circle 0.4 |> filled white |> move (20, -40),
    circle 0.5 |> filled white |> move (-10, 30),
    circle 0.3 |> filled white |> move (0, -20),
    circle 0.4 |> filled white |> move (10, 10),
    circle 0.5 |> filled white |> move (-20, 20),
    circle 0.3 |> filled white |> move (30, -30),
    circle 0.4 |> filled white |> move (-40, 40)
    ]
    |> move (20,0)
    |> rotate (degrees 45)
    ,  
    group
    [ circle 0.5 |> filled white |> move (-10, 30),
    circle 0.3 |> filled white |> move (0, -20),
    circle 0.4 |> filled white |> move (10, 10),
    circle 0.5 |> filled white |> move (-20, 20),
    circle 0.3 |> filled white |> move (30, -30),
    circle 0.4 |> filled white |> move (20, 20)
    ]
    |> move (-65,0)
    |> rotate (degrees 22)
    ,
    group
    [group
    [ circle 0.4 |> filled white |> move (80, -60),
    circle 0.3 |> filled white |> move (60, -80),
    circle 0.4 |> filled white |> move (-50, 70),
    circle 0.5 |> filled white |> move (40, -60),
    circle 0.3 |> filled white |> move (-30, 50),
    circle 0.4 |> filled white |> move (20, -40),
    circle 0.5 |> filled white |> move (-10, 30),
    circle 0.3 |> filled white |> move (0, -20),
    circle 0.4 |> filled white |> move (10, 10),
    circle 0.5 |> filled white |> move (-20, 20),
    circle 0.3 |> filled white |> move (30, -30),
    circle 0.4 |> filled white |> move (-40, 40),
    circle 0.5 |> filled white |> move (50, -50),
    circle 0.3 |> filled white |> move (-60, 60),
    circle 0.4 |> filled white |> move (70, -70),
    circle 0.4 |> filled white |> move (60, 0),
    circle 0.4 |> filled white |> move (-50, -50),
    circle 0.5 |> filled white |> move (40, 40),
    circle 0.3 |> filled white |> move (-30, -30),
    circle 0.4 |> filled white |> move (20, 20),
    circle 0.5 |> filled white |> move (-10, -10)
    ]
    ,
    group
    [ circle 0.4 |> filled white |> move (20, -40),
    circle 0.5 |> filled white |> move (-10, 30),
    circle 0.3 |> filled white |> move (0, -20),
    circle 0.4 |> filled white |> move (10, 10),
    circle 0.5 |> filled white |> move (-20, 20),
    circle 0.3 |> filled white |> move (30, -30),
    circle 0.4 |> filled white |> move (-40, 40)
    ]
    |> move (20,0)
    |> rotate (degrees 45),  
    group
    [ circle 0.5 |> filled white |> move (-10, 30),
    circle 0.3 |> filled white |> move (0, -20),
    circle 0.4 |> filled white |> move (10, 10),
    circle 0.5 |> filled white |> move (-20, 20),
    circle 0.3 |> filled white |> move (30, -30),
    circle 0.4 |> filled white |> move (20, 20)
    ]
    |> move (-65,0)
    |> rotate (degrees 22)]
    |> rotate (degrees 152)
    |> move (0, 60)
    ]

createMenu = 
  group [
        rect 3000 3000
        |> filled black
        |> makeTransparent 0.5,
        --- black menu box
        roundedRect 152 102 5
        |> filled black,
        roundedRect 147 97 5
        |> outlined (solid 1) (rgb 189 0 81)
  ]

createSmallMenu = 
  group [
        --- black menu box
        roundedRect 152 55 5
        |> filled black,
        roundedRect 147 50 5
        |> outlined (solid 1) (rgb 189 0 81)
  ]
  |> move (0, 33)

-- music button for picking song page
musicButton = 
  group[
        roundedRect 13 3.3 0.4
        |> filled white

        ,roundedRect 1.6 13 0.4
        |> filled white
        |> move (-5.7,-6)

        ,roundedRect 1.6 13 0.4
        |> filled white
        |> move (5.7,-6)
        ,
        oval 4 7
        |> filled white
        |> rotate (degrees -60)
        |> move (-7.9,-13)
        ,
        oval 4 7
        |> filled white
        |> rotate (degrees -60)
        |> move (3.4,-13)
        ]
        |> move (-69, -33)
        |> scale 0.8 

guitar model = group[
          curve (37.667,-10.63) [Pull (43.820,-15.29) (41.852,-24.58),Pull (37.667,-35.46) (24.762,-38.53),Pull (12.821,-38.64) (11.160,-44.11),Pull (12.132,-54.56) (32.784,-57.72),Pull (51.591,-55.95) (65.918,-50.39),Pull (82.166,-43.27) (95.215,-45.51),Pull (95.215,1.9182) (95.215,49.351),Pull (86.627,47.896) (68.359,55.280),Pull (40.298,62.358) (34.877,47.956),Pull (35.923,41.974) (45.689,40.632),Pull (58.344,37.467) (59.640,25.983),Pull (61.277,12.230) (49.874,10.637),Pull (44.991,8.7193) (40.108,6.8010),Pull (39.062,-2.092) (38.016,-10.98)]
          |> filled black
          |> scale 1.6
          |> move (-55,-25)
          |> makeTransparent 0.5,
          curve (37.667,-10.63) [Pull (43.820,-15.29) (41.852,-24.58),Pull (37.667,-35.46) (24.762,-38.53),Pull (12.821,-38.64) (11.160,-44.11),Pull (12.132,-54.56) (32.784,-57.72),Pull (51.591,-55.95) (65.918,-50.39),Pull (82.166,-43.27) (95.215,-45.51),Pull (95.215,1.9182) (95.215,49.351),Pull (86.627,47.896) (68.359,55.280),Pull (40.298,62.358) (34.877,47.956),Pull (35.923,41.974) (45.689,40.632),Pull (58.344,37.467) (59.640,25.983),Pull (61.277,12.230) (49.874,10.637),Pull (44.991,8.7193) (40.108,6.8010),Pull (39.062,-2.092) (38.016,-10.98)]
          |> filled (rgb 67 29 228)
          |> scale 1.6
          |> move (-50,-27),

          rect 90 14
          |>  filled (rgb 82 81 80)
          |> move (47,6.7)
          |> scale 3.5
          |> rotate (degrees 180)
          |> move (80,0), -- 68


          group[
          roundedRect 1 14 2 
          |> filled black
          |> move (60,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (54,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (48,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (42,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (36,6.7),
          roundedRect 1 14 2 
          |> filled black
          |> move (30,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (24,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (18,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (12,6.7),
          roundedRect 1 14 2 
          |> filled black
          |> move (6,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (0,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (-6,6.7), 
          roundedRect 1 14 2 -- this is closest to the right
          |> filled black
          |> move (-12,6.7), 

          -- pick up
          roundedRect 5 15 3 
          |> filled (hsl (degrees 252) 0.017 0.143)
          |> move (-19,6.7), -- 18

          -- dots on the pickup
          roundedRect 1.5 1 2
          |> filled (hsl (degrees 252) 0.03 0.505)
          |> move (-19, 4.5),
          roundedRect 1.5 1 2
          |> filled (hsl (degrees 252) 0.03 0.505)
          |> move (-19, 8.9),
          roundedRect 1.5 1 2
          |> filled (hsl (degrees 252) 0.03 0.505)
          |> move (-19, 2.3),
          roundedRect 1.5 1 2
          |> filled (hsl (degrees 252) 0.03 0.505)
          |> move (-19, 6.7),
          roundedRect 1.5 1 2
          |> filled (hsl (degrees 252) 0.03 0.505)
          |> move (-19, 11.1)
          
          ]
            |> scale 3.5
            |> rotate (degrees 180)
            |> move (30,0),


          [
          group[


          roundedRect 3 20 2
          |> filled black
          |> move (-48,8), 


          circle 1
          |> filled white 
          |> move (-46,1), 
          circle 1
          |> filled white 
          |> move (-46,3.3), 
          circle 1
          |> filled white 
          |> move (-46,5.6), 
          circle 1
          |> filled white 
          |> move (-46,7.9), 
          circle 1
          |> filled white 
          |> move (-46,10.1), 
          circle 1
          |> filled white 
          |> move (-46,12.4),

          -- wires
          group[
          rect 140 0.5
          |> filled grey
          |> move (4,12.4)
          |> (if model.string1 then addOutline (solid 0.3) grey  else identity)
          ,
          rect 140 0.5
          |> filled grey
          |> move (4,3.3)
          |> (if model.string2 then addOutline (solid 0.3) grey  else identity)
          , 
          rect 140 0.5
          |> filled grey
          |> move (4,5.6)
          |> (if model.string3 then addOutline (solid 0.3) grey  else identity)
          , 
          rect 140 0.5
          |> filled grey
          |> move (4,7.9)
          |> (if model.string4 then addOutline (solid 0.3) grey  else identity)
          , 
          rect 140 0.5
          |> filled grey
          |> move (4,10.1)
          |> (if model.string5 then addOutline (solid 0.3) grey  else identity)
          ,
          rect 140 0.5
          |> filled grey
          |> move (4,1)
          |> (if model.string6 then addOutline (solid 0.3) grey  else identity)
          ]
          |> move (20,0)]
          |> move (-20,0), 
          curve (55.52,10.88) [Pull (55.52,6.7200) (55.52,2.56),Pull (58.079,-1.760) (66.08,-2.24),Pull (66.08,6.24) (66.08,14.72),Pull (57.339,14.599) (55.84,9.92)]
          |> filled (rgb 63 65 65)
          |> scale 0.86
          |> move (16,1.5), 
          roundedRect 26 15 5
          |> filled (rgb 63 65 65)
          |> move (81,7), 
          -- nobs i think? they r also out of frame
          circle 1.5 
          |> filled white 
          |> move (80, 3), 
          circle 1.5 
          |> filled white 
          |> move (75, 3), 
          circle 1.5 
          |> filled white 
          |> move (85, 3),
          circle 1.5 
          |> filled white 
          |> move (85, 11), 
          circle 1.5 
          |> filled white 
          |> move (80,11), 
          circle 1.5 
          |> filled white 
          |> move (75,11), 
          -- extra guitar stuff that is probs out of frame lol
          rect 1.5 2 
          |> filled grey 
          |> move (75,15), 
          rect 1.5 2 
          |> filled grey 
          |> move (80,15), 
          rect 1.5 2 
          |> filled grey 
          |> move (85,15), 
          rect 1.5 2 
          |> filled grey 
          |> move (75,-1), 
          rect 1.5 2 
          |> filled grey 
          |> move (80,-1),
          rect 1.5 2 
          |> filled grey 
          |> move (85,-1), 
          roundedRect 3 2 3 
          |> filled grey 
          |> move (85,16), 
          roundedRect 3 2 3 
          |> filled grey 
          |> move (75,16), 
          roundedRect 3 2 3 
          |> filled grey 
          |> move (80,16), 
          roundedRect 3 2 3 
          |> filled grey 
          |> move (75,-2), 
          roundedRect 3 2 3 
          |> filled grey 
          |> move (80,-2), 
          roundedRect 3 2 3 
          |> filled grey 
          |> move (85,-2), 
          rect 10 0.5
          |> filled grey
          |> rotate ( degrees -10)
          |> move (70,11.5), 
          rect 9 0.5
          |> filled grey
          |> rotate ( degrees 10)
          |> move (71,1.8), 
          rect 17.5 0.5 
          |> filled grey 
          |> move (72, 3.3), 
          rect 23 0.5 
          |> filled grey 
          |> rotate (degrees 14)
          |> move (74, 8.3), 
          rect 23 0.5 
          |> filled grey 
          |> rotate (degrees -11)
          |> move (74, 5.8), 
          rect 20 0.5 
          |> filled grey 
          |> move (70,10.1)
          ]
            |> group
            |> scale 3.5
            |> rotate (degrees 180)
            |> move (30,0)] 
whitedots =[roundedRect 2.7 1.5 1 
          |> filled white
          |> move (33,6.8), 
          roundedRect 2.7 1.5 1 
          |> filled white
          |> move (21,6.8)
          , roundedRect 2 1.5 1 
          |> filled white
          |> move (3,9), --6
          roundedRect 2 1.5 1 
          |> filled white
          |> move (3,4.5), 
          roundedRect 2 1.5 1 
          |> filled white
          |> move (-3,6.7)
          ]
            |> group
            |> scale 3.5
            |> rotate (degrees 180)
            |> move (30,0)
guitarsensors model = group[
          rect 140 2.4
          |> filled green
          |> move (4,12.4)
          |> notifyEnter Hover1
          |> notifyLeave NonHover1
          |> makeTransparent 0
          , 
          rect 140 2.4
          |> filled red
          |> move (4,3.3)
          |> notifyEnter Hover2
          |> notifyLeave NonHover2
          |> makeTransparent 0
          , 
          rect 140 2.4
          |> filled yellow
          |> move (4,5.6)
          |> notifyEnter Hover3
          |> notifyLeave NonHover3
          |> makeTransparent 0
          , 
          rect 140 2.4
          |> filled blue
          |> move (4,7.9)
          |> notifyEnter Hover4
          |> notifyLeave NonHover4
          |> makeTransparent 0
          , 
          rect 140 2.4
          |> filled red
          |> move (4,10.1)
          |> notifyEnter Hover5
          |> notifyLeave NonHover5
          |> makeTransparent 0
          ,
          rect 140 2.4
          |> filled red
          |> move (4,1)
          |> notifyEnter Hover6
          |> notifyLeave NonHover6
          |> makeTransparent 0]
          |> scale 3.5
          |> rotate (degrees 180)
          |> move (30,0)

description = group[
  text "after selecting your song of choice, green"
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,22),
  text "circles will appear on the guitar that you must tap"
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,15),
  text "continously until the song is complete."
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,8),
  text "sounds will be formed as the buttons are tapped."
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,1)--,  
  {--text "monitor your progress using the progress bar that" 
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,-10),
  text "indicates how much of the song you have played."
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,-17),
  text "by using the back arrow button, you are able to"
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,-28),
  text "switch the song and practice with another song."
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,-35),
  text "have fun and enjoy playing!"
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,-42)--}]

progressBar total completed =
    group
    [
      -- INSIDE RECTANGLE
      group
      [
        roundedRect (completed*(78/total)) 9 3
        |> filled (rotateGradient (degrees 45) (gradient [stop (rgb 70 230 230) -10, stop (pink) 20, stop pink 10]))
      ]
      ,
      -- OUTSIDE RECTANGLE
      group
      [
        roundedRect 80 10 3
        |> outlined (solid 1) black
      ]
    ] |> move (-33, 21)
