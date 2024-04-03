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
          text "RETRO RIFFS"
            |> sansserif
            |> centered
            |> outlined (solid 0.5) (rgb 121 248 245)
            |> scale (2.01)
            |> move (0, 0)
          ,
          text "RETRO RIFFS"
            |> sansserif
            |> centered
            |> filled (rgb 255 27 242)
            |> makeTransparent (0.8)
            |> scale (2)
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
            |> notifyTap ToGameScreen -- change this, should be to menu
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
          --music note
          musicButton
          |> move (0, 1),
          
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
          text "more options"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-23,-34),

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
          text "smoke on"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-24,-7)
          ,
          text "sxfuhjjkbyt"
          |> sansserif
          |> centered 
          |> filled white
          |> scale 0.6
          |> move (-23,-34)
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
          |> notifyLeave NonHoverMiddle
          |> notifyTap ChangeSmokeOn,
         rect 152 30 -- top
          |> filled green
          |> move (0, 30)
          |> makeTransparent 0
          |> notifyEnter HoverTop
          |> notifyLeave NonHoverTop
          |> notifyTap ToGameScreen
          |> notifyTap ChangeTwinkleT
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
        createMenu,
        text "HOW TO PLAY: "
          |> sansserif
          |> centered
          |> filled white
          |> scale 0.6
          |> move (0,38),
        -- how to play description
        description,
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
          |> move (-3000, 0)
          |>(if model.gameplayed then move (3000,0) else identity)
        ]
        |> scale 0.75
        |> move (-30, 20),

        guitar model
        |> scale 0.8 
        |> move (50, -20),

        quarterNote black green 0.4 (0,0)
        |> move (42, 20-(7*model.time))
        |> (if modBy (round(model.time)) 5 == 0 then move (0, -30) else identity)
        ]

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
         -- progress bar 
         drawProgressBar (model.time)
          |> move (-40, -56),
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
       group[e,f,fsharp,g,gsharp,a,asharp,b,c,csharp,d,dsharp]
       |> makeTransparent 0,
       group[esensor,fsensor,fsharpsensor,gsensor,gsharpsensor,asensor,asharpsensor,bsensor,csensor,csharpsensor,dsensor,dsharpsensor]
        |> makeTransparent 0
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
          |> move (70,10.1), 

          -- white dots on guitar
          roundedRect 2.7 1.5 1 
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
          |> move (-3,6.7),
          
          -- sensor wires
          group[
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
          |> makeTransparent 0
          ]
          ]
            |> group
            |> scale 3.5
            |> rotate (degrees 180)
            |> move (30,0)] 
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
  text "continously until the song has completed."
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,8),
  text "The sounds will be formed as the buttons are tapped."
    |> sansserif
    |> centered
    |> filled white
    |> scale 0.5
    |> move (0,1),  
  text "Monitor your progress using the progress bar. It" 
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
    |> move (0,-42)]

g = group[
  circle 5
    |> filled (rgb 4 251 4)
    |> move (-130,-23)
    |> scale 0.5
    |> makeTransparent 0.9,   
  circle 5     
    |> outlined (solid 2.4) (rgb 4 251 4)     
    |> move (-130,-23)     
    |> scale 0.5      
    |> makeTransparent 0.7]
gsensor = group[
  rect 40 13
      |> filled red
      |> move (-130,-23)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover2
      |> notifyLeave NonHover2]
      
gsharp = group[
  circle 5
    |> filled (rgb 4 251 4)
    |> move (-87.5,-23)
    |> scale 0.5 --      
    |> makeTransparent 0.9,   
  circle 5     
    |> outlined (solid 2.4) (rgb 4 251 4)     
    |> move (-87.5,-23)     
    |> scale 0.5      
    |> makeTransparent 0.7]
gsharpsensor = group[
  rect 40 13
      |> filled red
      |> move (-87.5,-23)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover2
      |> notifyLeave NonHover2]
dsharp = group[
  circle 5
      |> filled (rgb 4 251 4)
      |> move (-2.5,-87)
      |> scale 0.5 --      
      |> makeTransparent 0.9, 
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-2.5,-87)     
      |> scale 0.5      
      |> makeTransparent 0.7]
dsharpsensor = group[
  rect 40 13
      |> filled red
      |> move (-2.5,-87)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover1
      |> notifyLeave NonHover1]
b = group[
  circle 5
      |> filled (rgb 4 251 4)
      |> move (-172.5,-7)
      |> scale 0.5 --      
      |> makeTransparent 0.9,   
    
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-172.5,-7)     
      |> scale 0.5      
      |> makeTransparent 0.7]
bsensor = group[
  rect 40 13
      |> filled red
      |> move (-172.5,-7)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover6
      |> notifyLeave NonHover6]
fsharp = group[
  circle 5
      |> filled (rgb 4 251 4)
      |> move (-87.5,-71)
      |> scale 0.5 --      
      |> makeTransparent 0.9,   
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-87.5,-71)     
      |> scale 0.5      
      |> makeTransparent 0.7]
fsharpsensor = group[
  rect 40 13
      |> filled red
      |> move (-87.5,-71)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover5
      |> notifyLeave NonHover5]
d = group[
  circle 5
      |> filled (rgb 4 251 4)
      -- filled red
      |> move (-45,-7)
      |> scale 0.5 --      
      |> makeTransparent 0.9,    
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-45,-7)     
      |> scale 0.5      
      |> makeTransparent 0.7]
dsensor = group[
  rect 40 13
      |> filled red
      |> move (-45,-7)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover6
      |> notifyLeave NonHover6]

asharp = group[
  circle 5
      |> filled (rgb 4 251 4)
      |> move (-130,-55)
      |> scale 0.5 --      
      |> makeTransparent 0.9,   
    
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-130,-55)     
      |> scale 0.5      
      |> makeTransparent 0.7]
asharpsensor = group[
  rect 40 13
      |> filled red
      |> move (-130,-55)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover4
      |> notifyLeave NonHover4]

f = group[
  circle 5
      |> filled (rgb 4 251 4)
      |> move (-45,-39)
      |> scale 0.5 --      
      |> makeTransparent 0.9,   
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-45,-39)     
      |> scale 0.5      
      |> makeTransparent 0.7]
fsensor = group[
  rect 40 13
      |> filled red
      |> move (-45,-39)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover3
      |> notifyLeave NonHover3]

csharp = group[

  circle 5
      |> filled (rgb 4 251 4)
      |> move (-2.5,-55)
      |> scale 0.5 --      
      |> makeTransparent 0.9,   
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-2.5,-55)     
      |> scale 0.5      
      |> makeTransparent 0.7]
csharpsensor = group[
  rect 40 13
      |> filled red
      |> move (-2.5,-55)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover4
      |> notifyLeave NonHover4]

a = group[
    circle 5
      |> filled (rgb 4 251 4)
      |> move (-172.5,-55)
      |> scale 0.5 --      
      |> makeTransparent 0.9,   
    
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-172.5,-55)     
      |> scale 0.5      
      |> makeTransparent 0.7]
asensor = group[
  rect 40 13
      |> filled red
      |> move (-172.5,-55)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover4
      |> notifyLeave NonHover4]

e = group[
  circle 5
      |> filled (rgb 4 251 4)
      |> move (40,-7) -- -120
      |> scale 0.5
      |> makeTransparent 0.9,   
  circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (40,-7)   
      |> scale 0.5      
      |> makeTransparent 0.7]

esensor = group[
  rect 40 13
      |> filled red
      |> move (40,-7)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover6
      |> notifyLeave NonHover6]

c = group[
  circle 5
      |> filled (rgb 4 251 4)
      |> move (-87.5,-87)
      |> scale 0.5
      |> makeTransparent 0.9,  
    circle 5     
      |> outlined (solid 2.4) (rgb 4 251 4)     
      |> move (-87.5,-87)     
      |> scale 0.5      
      |> makeTransparent 0.7]

csensor = group[
  rect 40 13
      |> filled red
      |> move (-87.5,-87)
      |> scale 0.5
      |> makeTransparent 0.9
      |> notifyEnter Hover1
      |> notifyLeave NonHover1]

-- aidens progress bar 

-- amount of beats/notes in the song
beats : Float
beats = 42

-- bpm of the song
beatsPerMin : Float
beatsPerMin = 88

-- how many seconds the song takes to play
lengthOfSong : Float
lengthOfSong = (beats / beatsPerMin) * 60

-- stall time to let the first initial notes drop in
stallTime : Float
stallTime = 5

-- total time that will take to fill the bar
totalTime : Float
totalTime = stallTime + lengthOfSong

-- progress bar (outside) quantities
length : Float
length = 80
width : Float
width = 10
roundness : Float
roundness = 3

-- progress bar (inside) quantities
inLength : Float
inLength = (length - 1)
inWidth : Float
inWidth = (width - 1)
inRoundness : Float
inRoundness = (roundness - 1)

-- progress bar gradient design
rotationDeg = 45
lightBlue = (rgb 70 230 230)

-- function that draws an animated progress bar
drawProgressBar time =
  [
  -- outline of the bar
  roundedRect length width roundness
  |> outlined (solid 1) black
  ,
  -- animation to expand the bar
  if time < totalTime then
    group [
      roundedRect ((inLength/totalTime)*time) inWidth inRoundness
      |> filled (rotateGradient (degrees rotationDeg) (gradient [stop lightBlue -10, stop pink 20, stop pink 10]))
    ]
  -- when the song is fully complete stop expanding the bar
  else
    group [
      roundedRect inLength inWidth inRoundness
      |> filled (rotateGradient (degrees 45) (gradient [stop (rgb 70 230 230) -10, stop (pink) 20, stop pink 10]))
      
    ]
  ] |> group
