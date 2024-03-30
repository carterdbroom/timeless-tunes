module GameMechanics exposing (..)

import GraphicSVG exposing (..)
import Types exposing (..)
import Shapes exposing (..)
import Conversions exposing (noteTimeToSecond,noteToStartPosition,noteToEndPosition, noteToXPosition, noteToEndYPosition, noteTypeToNoteShape)
import Conversions exposing (noteToGuitarGuideButton)

-- The speed that the notes fall
noteSpeed : Float
noteSpeed = 20

-- The starting y position of notes 
yPos : Float
yPos = 50

-- This function calculates the distance to space two notes.
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

-- This function draws the "track" of notes. The function takes in a song and 
-- draws a "track" that is one shape.
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


-- THIS FUNCTION NEEDS TO BE FIXED
updateNoteGuides : List ((Note, NoteTime)) -> Float -> Float -> Note
updateNoteGuides  song songYPosition count  =
    case song of
        (x1::xs) ->
            case x1 of
                (note, _) ->
                    if 
                        -- isn't quite right yet, need to make function that finds position of each individual note in 
                        -- context to track.
                        isPast note (getNoteYPositionInTrack song count 0 0)
                    then
                        updateNoteGuides xs songYPosition (count + 1) 
                    else
                        note
                        
        _ ->
            Rest
isPast : Note -> Float -> Bool
isPast note noteYPosition =
    if
        (noteToEndYPosition note) - 5 < noteYPosition
    then
        False
    else
        True

getNoteYPositionInTrack : List ((Note, NoteTime)) -> Float -> Float -> Float -> Float
getNoteYPositionInTrack song noteNumber distance count = 
    case song of 
        (x1::xs1) ->
            case x1 of
                (_,_) ->
                    case xs1 of
                        (x2::_) ->
                            if count < noteNumber
                            then
                                getNoteYPositionInTrack xs1 4 (distance + (calculateNoteDistance x1 x2)) (count + 1)
                            else
                                distance
                        _ ->
                            0
        _ ->
            0