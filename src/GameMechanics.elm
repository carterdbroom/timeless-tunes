module GameMechanics exposing (..)

import GraphicSVG exposing (..)
import Types exposing (..)
import Shapes exposing (..)
import Conversions exposing (noteTimeToSecond,noteToStartPosition,noteToEndPosition, noteToXPosition, noteToEndYPosition, noteTypeToNoteShape)

{--
makeNoteTrack : List (Note, NoteTime) -> (Float, Float) -> Model -> Shape userMsg
makeNoteTrack song startPosition model = 
    case song of 
        (x::xs) ->
            case x of 
                (note, noteTime) -> 
                    case note of
                        --}


calculateTime : Float -> Float -> Float
calculateTime speed time =
    time*speed

-- The speed that the notes fall
noteSpeed : Float
noteSpeed = 20

-- The starting y position of notes 
yPos : Float
yPos = 50

calculateNoteDistance : (Note, NoteTime) -> (Note, NoteTime) -> Float
calculateNoteDistance (note1, notetime1) (note2, notetime2) = 
    let
        time = noteTimeToSecond notetime1
        endPos1 = noteToEndYPosition note1
        endPos2 = noteToEndYPosition note2
    in
        if
            (noteToEndYPosition note1) < (noteToEndYPosition note2)
        then
            noteSpeed*time + (endPos1 - endPos2)
        else if
            (noteToEndYPosition note1) > (noteToEndYPosition note2)
        then
            noteSpeed*time + (endPos1 - endPos2)
        else 
            noteSpeed*time

calculateDropTime : (Note, NoteTime) -> (Note, NoteTime) -> Float
calculateDropTime (note1, notetime1) (note2, notetime2) = 
    let
        noteTimeInSec = (noteTimeToSecond notetime1)
        distance = yDistance (noteToEndPosition note2) (noteToStartPosition note2)
    in
        noteTimeInSec - distance/noteSpeed

drawTrack : List ((Note, NoteTime)) -> (Float, Float) -> Shape userMsg -> Shape userMsg
drawTrack song startPosition shape =
            case startPosition of
                (x, y) -> 
                    case song of 
                        (x1::xs1) ->
                            case x1 of
                                (_,_) ->
                                    case xs1 of
                                        (x2::_) ->
                                            case x2 of
                                                (note2, noteTime2) ->
                                                    group((move (x, y) shape)::[drawTrack xs1 (noteToXPosition note2, y + (calculateNoteDistance x1 x2)) (noteTypeToNoteShape noteTime2)])
                                        _ ->
                                            group[]
                        _ ->
                            group[]


yDistance : (Float, Float) -> (Float, Float) -> Float
yDistance (s1, s2) (e1, e2) =
    abs(s2 - e2)