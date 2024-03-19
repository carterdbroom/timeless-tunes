module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Types exposing (..)
import Conversions exposing (noteToStartPosition, noteToEndPosition, noteTimeToSecond, noteTypeToNoteShape, getStartNoteShapeFromSong, getStartPositionFromSong)
import Songs exposing (twinkle)
import GameMechanics exposing (drawTrack, calculateDropTime, yPos, noteSpeed)
import Shapes exposing (quarterNote, halfNote, wholeNote)




yDistance : (Float, Float) -> (Float, Float) -> Float
yDistance (s1, s2) (e1, e2) =
    abs(s2 - e2)

myShapes model =
  [

    drawTrack twinkle (getStartPositionFromSong (Twinkle twinkle)) (getStartNoteShapeFromSong (Twinkle twinkle))
    |> move (0, -noteSpeed*model.time)
    {--
    quarterNote black red 3 (0, 0)
    ,
    halfNote black red 3 (40, 0) 
    ,
    wholeNote black red 3 (-40, 0)
    , 
    eighthNote black red 3 (60, 0)
    --}
    --dropNote twinkle (50,50) 1 model (filled red (circle 5))
  ]



update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     ToTitleScreen ->
                       case model.state of
                         InfoScreen ->
                           { model | state = TitleScreen }
                         _ ->
                           model
                     ToInfoScreen ->
                       case model.state of
                         TitleScreen ->
                           { model | state = InfoScreen }
                         _ ->
                           model
                     ToGameScreen ->
                       case model.state of
                         TitleScreen ->
                           { model | state = GameScreen }
                         _ ->
                           model
                     HoverButton ->
                       { model | hovering = True }
                     DontHoverButton ->
                       { model | hovering = False }
                     HoverPause -> {model | hovering2 = True}
                     NonHoverPause -> {model | hovering2 = False}
                     Hover1 -> {model | string1 = True}
                     NonHover1 -> {model | string1 = False}
                     Hover2 -> {model | string2 = True}
                     NonHover2 -> {model | string2 = False}
                     Hover3 -> {model | string3 = True}
                     NonHover3 -> {model | string3 = False}
                     Hover4 -> {model | string4 = True}
                     NonHover4 -> {model | string4 = False}
                     Hover5 -> {model | string5 = True}
                     NonHover5 -> {model | string5 = False}
                     Hover6 -> {model | string6 = True}
                     NonHover6 -> {model | string6 = False}
                     HoverPlay -> {model | hoveringstart = True}
                     NonHoverPlay -> {model | hoveringstart = False}
  

init = { time = 0
       , state = TitleScreen
       , hovering = False 
       , hovering2 = False
       , string1 = False
       , string2 = False
       , string3 = False
       , string4 = False
       , string5 = False
       , string6 = False
       ,hoveringstart = False}

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

