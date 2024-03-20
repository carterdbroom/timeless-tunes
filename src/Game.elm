module Game exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Types exposing (..)

game model =
    case model.state of
      TitleScreen ->
        group
        [
          
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
            |> move (200, 200) -- 0 -50
            |>(if model.hoveringstart then move (-200, -250) else identity)
          
            
          ,text "PRESS START"
            |> sansserif
            |> centered
            |> filled white
            |> scale 0.8
            |> move (0, -53)
            |> makeTransparent 0.9
            
          ,roundedRect 80 20 5
            |> filled red
            |> move (0, -50)
            |> makeTransparent 0
            |> notifyEnter HoverPlay
            |> notifyLeave NonHoverPlay
            |> notifyTap ToGameScreen -- change this
            
          ] |> group
          
          
          ,
          [
            --guitarNeck
          ] |> group
          ,
          
          -- ground
          group [
          rect 400 40
            |> filled (rgb 27 36 77)
          ,
          
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 20),
          
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 18),
            
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 15)
          
          ,
          
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 10),
          
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, 2),
            
          rect 400 1
            |> filled (rgb 35 81 193)
            |> move (0, -9),
          
          rect 50 1 -- 50
            |> filled (rgb 35 81 193)
            |> rotate (degrees 70)
            |> move (-12,-3),
            
          rect 50 1
            |> filled (rgb 35 81 193)
            |> rotate (degrees -70)
            |> move (12,-3),
            
          rect 65 1 -- 65
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
          ,
          [
          -- buttons
          ] |> group
            |> scale (1)
            |> move (0, -65)
        ] 
          |> move (0, 40)
      InfoScreen ->
        group -- identifierinfo
        [
          [
          rect 200 200
          |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
          ,
          nightSky
          |> rotate (degrees 3*(model.time))
          ] |> group
            |> move (0, -30)
            
          , group[curve (-61.68,27.759) [Pull (-61.68,12.337) (-61.68,-3.084),Pull (-60.55,-5.453) (-55.90,-5.783),Pull (-50.81,-5.240) (-50.12,-2.698),Pull (-50.12,12.530) (-50.12,27.759),Pull (-50.37,31.299) (-55.51,32),Pull (-61.52,31.306) (-61.68,27.373)]
          --filled (rgb 75 0 130)
          |> filled white
          |> move (57, -3)
          |> scale 0.4,

          curve (-61.68,27.759) [Pull (-61.68,12.337) (-61.68,-3.084),Pull (-60.55,-5.453) (-55.90,-5.783),Pull (-50.81,-5.240) (-50.12,-2.698),Pull (-50.12,12.530) (-50.12,27.759),Pull (-50.37,31.299) (-55.51,32),Pull (-61.52,31.306) (-61.68,27.373)]
          |> filled white
          |> move (74, -3)
          |> scale 0.4
          ]
          |> move (-200, 200)
          -- move (-87,47)
          |> (if model.hovering then move (113,-153) else identity)
            ,

          -- guitar by sonia

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
          |> scale 2.7
          |> rotate (degrees 180)
          |> move (68,-10),


        group[roundedRect 1 14 2 
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
          |> move (10,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (2,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (-6,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (-12,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (-18,6.7)]
            |> scale 2.7
            |> rotate (degrees 180)
            |> move (30,-10),


        group[
        group[

          rect 9.9 30
          |> filled black
          |> move (-33, 7)
          |> move (-10,0), 
          circle 15
          |> filled (rgb 150 87 205)
          |> move (0, 7)
          |> move (-10,0), 
          circle 14
          -- filled (rgb 119 72 47) -- brown one mybe
          |> filled (rgb 192 234 255) 
          |> move (0,7)
          |> move (-10,0),
          circle 12.5
          |> filled black 
          |> move (0,7)
          |> move (-10,0),


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
          |> notifyEnter Hover1
          |> notifyLeave NonHover1
          |> (if model.string1 then addOutline (solid 0.3) grey  else identity)
          , 
          
          rect 140 0.5
          |> filled grey
          |> move (4,3.3)
          |> notifyEnter Hover2
          |> notifyLeave NonHover2
          |> (if model.string2 then addOutline (solid 0.3) grey  else identity)

          , 
          rect 140 0.5
          |> filled grey
          |> move (4,5.6)
          |> notifyEnter Hover3
          |> notifyLeave NonHover3
          |> (if model.string3 then addOutline (solid 0.3) grey  else identity)

          , 
          rect 140 0.5
          |> filled grey
          |> move (4,7.9)
          |> notifyEnter Hover4
          |> notifyLeave NonHover4
          |> (if model.string4 then addOutline (solid 0.3) grey  else identity)

          , 
          rect 140 0.5
          |> filled grey
          |> move (4,10.1)
          |> notifyEnter Hover5
          |> notifyLeave NonHover5
          |> (if model.string5 then addOutline (solid 0.3) grey  else identity)

          ,
          rect 140 0.5
          |> filled grey
          |> move (4,1)
          |> notifyEnter Hover6
          |> notifyLeave NonHover6
          |> (if model.string6 then addOutline (solid 0.3) grey  else identity)


          ]
          |> move (20,0)] -- end of first group
          |> move (-20,0), 
          curve (55.52,10.88) [Pull (55.52,6.7200) (55.52,2.56),Pull (58.079,-1.760) (66.08,-2.24),Pull (66.08,6.24) (66.08,14.72),Pull (57.339,14.599) (55.84,9.92)]
          |> filled (rgb 63 65 65)
          |> scale 0.86
          |> move (16,1.5), 
          roundedRect 26 15 5
          |>filled (rgb 63 65 65)
          |> move (81,7), 
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

          roundedRect 3 1.5 1 
          |> filled white
          |> move (45,6.8), 
          roundedRect 3 1.5 1 
          |> filled white
          |> move (33,6.8), 
          roundedRect 3 1.5 1 
          |> filled white
          |> move (21,6.8)
          , roundedRect 2 1.5 1 
          |> filled white
          |> move (6,9), 
          roundedRect 2 1.5 1 
          |> filled white
          |> move (6,4.5), 
          roundedRect 2 1.5 1 
          |> filled white
          |> move (-3,6.7)

         ]
            |> scale 2.7
            |> rotate (degrees 180)
            |> move (30,-10),

        rect 300 300
        |> filled black
        |> makeTransparent 0.5,

        --- NEW MENU STUFF HERE
        roundedRect 152 102 5
        |> filled black,

        roundedRect 147 97 5
        |> outlined (solid 1) (rgb 189 0 81)
        ,
        
        curve (-58.60,35.084) [Pull (-58.60,13.108) (-58.60,-8.867),Pull (-57.53,-13.09) (-52.81,-10.40),Pull (-36.43,-0.385) (-20.04,9.6385),Pull (-16.58,12.722) (-20.04,15.807),Pull (-36.62,26.024) (-53.20,36.240),Pull (-57.82,39.029) (-58.60,34.698)]
        |> filled white
        |> scale 0.27
        |> move (-45, 26)
        ,
        
       

        circle 6
        |> filled white
        |> move (-43.5,4.2)
        |> move (-13, -5),
        
        text "i"
        |> filled black
        |> move (-45,0)
        |> move (-13,-5),
        
        group[roundedRect 13 3.3 0.4
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
        |> move (3.4,-13)]
          |> move (-69, -33)
          |> scale 0.8
        ,
        rect 152 30 -- middle
        |> filled yellow
        |> makeTransparent 0
        
        ,
        rect 152 30 -- top
        |> filled green
        |> move (0, 30)
        |> makeTransparent 0
        ,
        rect 152 30 -- bottom
        |> filled red
        |> move (0, -30)
        |> makeTransparent 0
        
        ]
        
      GameScreen ->
        group
        [
        
        -- background
        [
          rect 200 200
          |> filled (rotateGradient (degrees 270) (gradient [stop (rgb 75 0 130) 1, stop (rgb 221 160 221) 100, stop pink 1]))
          ,
          nightSky
          |> rotate (degrees 3*(model.time))
          ] |> group
            |> move (0, -30)
         ,
         
          group[curve (-61.68,27.759) [Pull (-61.68,12.337) (-61.68,-3.084),Pull (-60.55,-5.453) (-55.90,-5.783),Pull (-50.81,-5.240) (-50.12,-2.698),Pull (-50.12,12.530) (-50.12,27.759),Pull (-50.37,31.299) (-55.51,32),Pull (-61.52,31.306) (-61.68,27.373)]
          --filled (rgb 75 0 130)
          |> filled white
          |> move (57, -3)
          |> scale 0.4,

          curve (-61.68,27.759) [Pull (-61.68,12.337) (-61.68,-3.084),Pull (-60.55,-5.453) (-55.90,-5.783),Pull (-50.81,-5.240) (-50.12,-2.698),Pull (-50.12,12.530) (-50.12,27.759),Pull (-50.37,31.299) (-55.51,32),Pull (-61.52,31.306) (-61.68,27.373)]
          |> filled white
          |> move (74, -3)
          |> scale 0.4
          ]
          |> move (-200, 200)
          -- move (-87,47)
          |> (if model.hovering2 then move (113,-153) else identity)
            ,
        -- pause button
        group[curve (-61.68,27.759) [Pull (-61.68,12.337) (-61.68,-3.084),Pull (-60.55,-5.453) (-55.90,-5.783),Pull (-50.81,-5.240) (-50.12,-2.698),Pull (-50.12,12.530) (-50.12,27.759),Pull (-50.37,31.299) (-55.51,32),Pull (-61.52,31.306) (-61.68,27.373)]
          |> outlined (solid 2) white
          |> move (57, -3)
          |> scale 0.4,

          curve (-61.68,27.759) [Pull (-61.68,12.337) (-61.68,-3.084),Pull (-60.55,-5.453) (-55.90,-5.783),Pull (-50.81,-5.240) (-50.12,-2.698),Pull (-50.12,12.530) (-50.12,27.759),Pull (-50.37,31.299) (-55.51,32),Pull (-61.52,31.306) (-61.68,27.373)]
          |> outlined (solid 2) white
          |> move (74, -3)
          |> scale 0.4]
            |> move (-87,47)
          ,

           rect 12 15
          |> filled red
          |> move (-83,51)
          |> makeTransparent 0
          |> notifyEnter HoverPause
          |> notifyLeave NonHoverPause
          |> notifyTap ToInfoScreen, -- this doesnt work??
          
         
          
          

          -- guitar by sonia

         curve (37.667,-10.63) [Pull (43.820,-15.29) (41.852,-24.58),Pull (37.667,-35.46) (24.762,-38.53),Pull (12.821,-38.64) (11.160,-44.11),Pull (12.132,-54.56) (32.784,-57.72),Pull (51.591,-55.95) (65.918,-50.39),Pull (82.166,-43.27) (95.215,-45.51),Pull (95.215,1.9182) (95.215,49.351),Pull (86.627,47.896) (68.359,55.280),Pull (40.298,62.358) (34.877,47.956),Pull (35.923,41.974) (45.689,40.632),Pull (58.344,37.467) (59.640,25.983),Pull (61.277,12.230) (49.874,10.637),Pull (44.991,8.7193) (40.108,6.8010),Pull (39.062,-2.092) (38.016,-10.98)]
          |> filled black
          |> scale 1.6
          |> move (-55,-25)
          |> makeTransparent 0.5
        
          ,
        curve (37.667,-10.63) [Pull (43.820,-15.29) (41.852,-24.58),Pull (37.667,-35.46) (24.762,-38.53),Pull (12.821,-38.64) (11.160,-44.11),Pull (12.132,-54.56) (32.784,-57.72),Pull (51.591,-55.95) (65.918,-50.39),Pull (82.166,-43.27) (95.215,-45.51),Pull (95.215,1.9182) (95.215,49.351),Pull (86.627,47.896) (68.359,55.280),Pull (40.298,62.358) (34.877,47.956),Pull (35.923,41.974) (45.689,40.632),Pull (58.344,37.467) (59.640,25.983),Pull (61.277,12.230) (49.874,10.637),Pull (44.991,8.7193) (40.108,6.8010),Pull (39.062,-2.092) (38.016,-10.98)]
          |> filled (rgb 67 29 228)
          |> scale 1.6
          |> move (-50,-27),

        rect 90 14
          |>  filled (rgb 82 81 80)
          |> move (47,6.7)
          |> scale 2.7
          |> rotate (degrees 180)
          |> move (68,-10),


        group[roundedRect 1 14 2 
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
          |> move (10,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (2,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (-6,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (-12,6.7), 
          roundedRect 1 14 2 
          |> filled black
          |> move (-18,6.7)]
            |> scale 2.7
            |> rotate (degrees 180)
            |> move (30,-10),


        group[
        group[

          rect 9.9 30
          |> filled black
          |> move (-33, 7)
          |> move (-10,0), 
          circle 15
          |> filled (rgb 150 87 205)
          |> move (0, 7)
          |> move (-10,0), 
          circle 14
          -- filled (rgb 119 72 47) -- brown one mybe
          |> filled (rgb 192 234 255) 
          |> move (0,7)
          |> move (-10,0),
          circle 12.5
          |> filled black 
          |> move (0,7)
          |> move (-10,0),


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
          
          rect 140 2.4
          |> filled red
          |> move (4,12.4)
          |> notifyEnter Hover1
          |>makeTransparent 0
          |> notifyLeave NonHover1
          ,
          
          rect 140 0.5
          |> filled grey
          |> move (4,3.3)
          |> (if model.string2 then addOutline (solid 0.3) grey  else identity)

          , 
          
          rect 140 2.4
          |> filled red
          |> move (4,3.3)
          |>makeTransparent 0
          |> notifyEnter Hover2
          |> notifyLeave NonHover2
         
          , 
          rect 140 0.5
          |> filled grey
          |> move (4,5.6)
          |> (if model.string3 then addOutline (solid 0.3) grey  else identity)

          , 
          
          rect 140 2.4
          |> filled red
          |>makeTransparent 0
          |> move (4,5.6)
          |> notifyEnter Hover3
          |> notifyLeave NonHover3
          
          , 
          rect 140 0.5
          |> filled grey
          |> move (4,7.9)
          |> (if model.string4 then addOutline (solid 0.3) grey  else identity)

          , 
          
          
          rect 140 2.4
          |> filled red
          |> move (4,7.9)
          |> notifyEnter Hover4
          |>makeTransparent 0
          |> notifyLeave NonHover4
          , 
          rect 140 0.5
          |> filled grey
          |> move (4,10.1)
          |> (if model.string5 then addOutline (solid 0.3) grey  else identity)
          ,
          rect 140 2.4
          |> filled red
          |> move (4,10.1)
          |>makeTransparent 0
          |> notifyEnter Hover5
          |> notifyLeave NonHover5
          ,
          rect 140 0.5
          |> filled grey
          |> move (4,1)
          |> (if model.string6 then addOutline (solid 0.3) grey  else identity)
          ,
          rect 140 2.4
          |> filled red
          |>makeTransparent 0
          |> move (4,1)
          |> notifyEnter Hover6
          |> notifyLeave NonHover6
          ]
          |> move (20,0)] -- end of first group
          |> move (-20,0), 
          curve (55.52,10.88) [Pull (55.52,6.7200) (55.52,2.56),Pull (58.079,-1.760) (66.08,-2.24),Pull (66.08,6.24) (66.08,14.72),Pull (57.339,14.599) (55.84,9.92)]
          |> filled (rgb 63 65 65)
          |> scale 0.86
          |> move (16,1.5), 
          roundedRect 26 15 5
          |>filled (rgb 63 65 65)
          |> move (81,7), 
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

          roundedRect 3 1.5 1 
          |> filled white
          |> move (45,6.8), 
          roundedRect 3 1.5 1 
          |> filled white
          |> move (33,6.8), 
          roundedRect 3 1.5 1 
          |> filled white
          |> move (21,6.8)
          , roundedRect 2 1.5 1 
          |> filled white
          |> move (6,9), 
          roundedRect 2 1.5 1 
          |> filled white
          |> move (6,4.5), 
          roundedRect 2 1.5 1 
          |> filled white
          |> move (-3,6.7)

        ]
            |> scale 2.7
            |> rotate (degrees 180)
            |> move (30,-10)

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

guitarTransparency : Float
guitarTransparency = 1

guitarNeck =
  -- REVERT TO VERSION 269 IF YOU DON'T LIKE IT
  group [
  -- NECK
  rect 210 45
    |> filled black
    |> makeTransparent (guitarTransparency)
    |> move (0, -72.5)
    ,
  -- STRINGS
  rect 210 1
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (0, -53)
    ,
  rect 210 1.5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (0, -58.5)
    ,
  rect 210 2
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (0, -65)
    ,
  rect 210 2.5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (0, -72.5)
    ,
  rect 210 3
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (0, -80.5)
    ,
  rect 210 3.25
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (0, -89.5)
    ,
  -- FRETS
  roundedRect 1 45 5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (50, -72.5)
    ,
  roundedRect 1 45 5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (10, -72.5)
    ,
  roundedRect 1 45 5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (-25, -72.5)
    ,
  roundedRect 1 45 5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (-47, -72.5)
    ,
  roundedRect 1 45 5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (-65, -72.5)
    ,
  roundedRect 1 45 5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (-80, -72.5)
    ,
  roundedRect 1 45 5
    |> filled white
    |> makeTransparent (guitarTransparency)
    |> move (-90, -72.5)
  ] |> move (0, -9)