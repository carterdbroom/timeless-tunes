module Shapes exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Types exposing (..)
import Conversions exposing (noteToStartPosition, noteToEndPosition, addTuple, noteTimeToSecond)
import Html exposing (s)
import Conversions exposing (addTuple)

shape1 : Shape userMsg
shape1 
    = group
    [
        rect 5 10
        |> filled black
        ,
        circle 5
        |> filled red
        |> move (30, 30)
    ]

fallingNote : (Float, Float) -> Float -> Color -> Shape userMsg
fallingNote position size colour = 
    circle 1
    |> outlined (solid 1) colour
    |> scale size
    |> move position

drawSongRepresentation : List(Note, NoteTime) -> (Float, Float) -> Shape userMsg
drawSongRepresentation list moveup
    = case list of
        (head::tail) -> 
            case head of
                (note, noteTime) ->
                    fallingNote (noteToStartPosition note) 1 red
        _ ->
            group[]


{--
drawSongRepresentation : List(Note, NoteTime) -> (Float, Float) -> Shape userMsg
drawSongRepresentation list moveup
    = case list of
        (head::tail) -> 
            case head of
                (note, noteTime) ->
                    group[group((fallingNote (addTuple (noteToStartPosition note) moveup) 1 red)::[drawSongRepresentation tail (0, 20 + (noteTimeToSecond noteTime))])]
        _ -> 
            group[]
--}


playSong : Song -> Shape userMsg
playSong song 
    = case song of
        Twinkle list ->
            drawSongRepresentation list (0,0)
