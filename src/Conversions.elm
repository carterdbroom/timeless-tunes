module Conversions exposing (..)

import GraphicSVG exposing (..)
import Types exposing (..)
import Shapes exposing (wholeNote, halfNote, quarterNote)

-- Given a String, it returns the String converted to a Note. We use the Maybe type because 
-- we can have random Strings we don't want, so we just return Nothing in that case.
stringToNote : String -> Maybe Note
stringToNote string
    = case string of
        "C" -> Just C
        "CSharp" -> Just CSharp
        "D" -> Just D
        "DSharp" -> Just DSharp
        "E" -> Just E
        "F" -> Just F
        "FSharp" -> Just FSharp
        "G" -> Just G
        "GSharp" -> Just GSharp
        "A" -> Just A
        "ASharp" -> Just ASharp
        "B" -> Just B
        "Rest" -> Just Rest
        _ -> Nothing

-- Given a NoteTime, it returns the NoteTime converted to seconds.
noteTimeToSecond : NoteTime -> Float
noteTimeToSecond noteTime 
    = case noteTime of 
        Whole ->
            4
        Half ->
            2
        Quarter ->
            1
        Eighth ->
            0.5
        WholeRest ->
            4
        HalfRest ->
            2
        QuarterRest ->
            1
        EighthRest ->
            0.5

-- Given a Note, it returns the position where the note should start as a Tuple of Floats.
noteToStartPosition : Note -> (Float, Float)
noteToStartPosition note 
    = case note of
        C -> (-50, 50)
        CSharp -> (-45, 50)
        D -> (-40, 50)
        DSharp -> (-35, 50)
        E -> (-30, 50)
        F -> (-25, 50)
        FSharp -> (-20, 50)
        G -> (-15, 50)
        GSharp -> (-10, 50)
        A -> (-5, 50)
        ASharp -> (0, 50)
        B -> (5, 50)
        Rest -> (0, 50)

-- Given a Note, it returns the position where the note should end/disappear as a Tuple of Floats.
noteToEndPosition : Note -> (Float, Float)
noteToEndPosition note 
    = case note of
        C -> (-50, -50)
        CSharp -> (-45, -50)
        D -> (-40, -50)
        DSharp -> (-35, -50)
        E -> (-30, -50)
        F -> (-25, -50)
        FSharp -> (-20, -50)
        G -> (-15, -50)
        GSharp -> (-10, -50)
        A -> (-5, -50)
        ASharp -> (0, -50)
        B -> (5, -50)
        Rest -> (0, -50)

-- Given a Note, it returns the associated y-coordinate as a Float.
noteToEndYPosition : Note -> Float
noteToEndYPosition note
    = case note of
        C -> -40
        CSharp -> -40
        D -> -45
        DSharp -> -45
        E -> -45
        F -> -45
        FSharp -> -45
        G -> -50
        GSharp -> -50
        A -> -50
        ASharp -> -50
        B -> -55
        Rest -> -60

-- Given a two Tuples of Floats, this function adds their elements together and returns a Tuple of Floats.
addTuple : (Float, Float) -> (Float, Float) -> (Float, Float)
addTuple firstTup secondTup
    = case firstTup of
        (x1, y1) -> 
            case secondTup of 
                (x2, y2) ->
                    (x1 + x2, y1 + y2)

-- Given a BPM (Beats Per Minute), converts the BPM to seconds and returns a Float.
bpmToSeconds : Float -> Float
bpmToSeconds bpm
    = bpm/60

-- Given a Note, it returns the associated x-coordinate as a Float.
noteToXPosition : Note -> Float
noteToXPosition note =
    case note of
        C -> -50
        CSharp -> -45
        D -> -40
        DSharp -> -35
        E -> -30
        F -> -25
        FSharp -> -20
        G -> -15
        GSharp -> -10
        A -> -5
        ASharp -> 0
        B -> 5
        Rest -> 10

-- Takes in a Song, finds the first Tuple in the List, finds the Note, then returns the associated start position  
-- as a Tuple of Floats.
getStartPositionFromSong : Song -> (Float, Float)
getStartPositionFromSong song =
    case song of 
        Twinkle list -> 
            case list of 
                (head::_) ->
                    case head of 
                        (note, _) ->
                            noteToStartPosition note
                [] -> 
                    (0,0)
-- Takes in a Song, finds the first Tuple in the List, finds the NoteTime, then returns the associated Shape.
getStartNoteShapeFromSong : Song -> Shape userMsg
getStartNoteShapeFromSong song =
    case song of
        Twinkle list ->
            case list of 
                (head::_) ->
                    case head of
                        (_, noteTime) ->
                            noteTypeToNoteShape noteTime
                [] -> 
                    group[]

-- Takes in a NoteTime, and returns the associated Shape.
noteTypeToNoteShape : NoteTime -> Shape userMsg
noteTypeToNoteShape noteTime =
    case noteTime of
        Whole -> 
            wholeNote black green 1 (0, 0)
            |> scale 0.5
        Half ->
            halfNote black green 1 (0, 0)
            |> scale 0.5
        Quarter ->
            quarterNote black green 1 (0, 0)
            |> scale 0.5
        Eighth ->
            square 5
            |> filled red 
        WholeRest ->
            group[]
        HalfRest ->
            group[]
        QuarterRest ->
            group[]
        EighthRest ->
            group[]
