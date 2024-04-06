module GameMechanics exposing (..)

import GraphicSVG exposing (..)
import Types exposing (..)
import Shapes exposing (..)
import Conversions exposing (..)

-- The speed that the notes fall
noteSpeed : Float
noteSpeed = 20

-- The starting y position of notes 
yPos : Float
yPos = 50

{--
-- This function calculates the distance to space two notes.
calculateNoteDistance : (Note, NoteTime) -> (Note, NoteTime) -> Float
calculateNoteDistance (note1, notetime1) (note2, notetime2) = 
    let
        time = noteTimeToSecond notetime1
        endPos1 = noteToEndYPosition note1
        endPos2 = noteToEndYPosition note2
    in
        noteSpeed*time + (endPos2 - endPos1)

{--
test one
drawTrack : List ((Note, NoteTime)) -> Float -> Int -> Int -> Shape userMsg 
drawTrack song distance noteNumber count =
    case song of
        (head::tail) ->
            case head of
                (note, noteTime) ->
                    if count == 0 then 
                        (noteTypeToNoteShape noteTime) 
                        |> move (getStartPositionFromList song)
                    else
                        group(move (noteToXPosition note, (getNoteYPositionInTrack song (50 + distance) noteNumber count)) (noteTypeToNoteShape noteTime)::[drawTrack tail (50 + distance) (noteNumber + 1) count])
        [] ->
            group[]
--}




-- This is the original
-- This function draws the "track" of notes. The function takes in a song and 
-- draws a "track" that is one shape.
drawTrack : List ((Note, NoteTime)) -> (Float, Float) -> Shape userMsg -> Shape userMsg
drawTrack song startPosition shape =
    case startPosition of
        (x, y) -> 
            case song of 
                (x1::xs1) ->
                    case xs1 of
                        (x2::_) ->
                            case x2 of
                                (note2, noteTime2) ->
                                    group((move (x, y) shape)::[drawTrack xs1 (noteToXPosition note2, y + (calculateNoteDistance x1 x2)) (noteTypeToNoteShape noteTime2)])
                        _ ->
                            group[]
                _ ->
                    group[]

{--
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
--}

updateNoteGuides : List ((Note, NoteTime)) -> Float -> Int -> Note
updateNoteGuides song songYPosition count =
    case song of
        (x1 :: xs) ->
            case x1 of
                (note, _) ->
                    if isPast note (getNoteYPositionInTrack song (50 + songYPosition) count 0) then
                        updateNoteGuides xs songYPosition (count + 1)
                    else
                        note
        _ ->
            Rest

isPast : Note -> Float -> Bool
isPast note noteYPosition =
    (noteToEndYPosition note) >= noteYPosition

getNoteYPositionInTrack : List ((Note, NoteTime)) -> Float -> Int -> Int -> Float
getNoteYPositionInTrack song distance noteNumber count =
    case song of
        (x1 :: x2 :: xs) ->
            if count == noteNumber then
                distance
            else
                getNoteYPositionInTrack (x2 :: xs) (distance + calculateNoteDistance x1 x2) noteNumber (count + 1)
        [_] ->
            if count == noteNumber then
                distance 
            else
                0
        [] ->
            0
--}
updateGuideNote : List ((Note, NoteTime)) -> Note
updateGuideNote list =
    case list of
        (head1 :: head2 ::_) ->
            case head2 of 
                (note, _) ->
                    note
        _ ->
            Rest
updateNoteList : List ((Note, NoteTime)) -> List ((Note, NoteTime))
updateNoteList list = 
    case list of
        (_ :: tail) ->
            tail  
        _ ->
            []

playTapAnimation : List ((Note, NoteTime)) -> Float -> Model -> Shape userMsg
playTapAnimation list startTime model = 
    let 
        timer = model.time - startTime
    in 
        if 
            timer < 0.05
        then
            animationCircle (noteToGuitarGuidePosition (getFirstNoteFromList list)) 1
        else if 
            timer > 0.05 && timer < 0.1
        then
            animationCircle (noteToGuitarGuidePosition (getFirstNoteFromList list)) 1.25
        else if 
            timer > 0.1 && timer < 0.15
        then
            animationCircle (noteToGuitarGuidePosition (getFirstNoteFromList list)) 1.5
        else
            group[]