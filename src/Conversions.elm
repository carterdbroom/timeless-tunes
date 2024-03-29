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
        C -> (-60, 50)
        CSharp -> (-43.5, 50)
        D -> (-27, 50)
        DSharp -> (-10.5, 50)
        E -> (-43.5, 50)
        F -> (-27, 50)
        FSharp -> (-10.5, 50)
        G -> (6, 50)
        GSharp -> (-60, 50)
        A -> (-43.5, 50)
        ASharp -> (-27, 50)
        B -> (-10.5, 50)
        Rest -> (0, 50)

-- Given a Note, it returns the position where the note should end/disappear as a Tuple of Floats.
noteToEndPosition : Note -> (Float, Float)
noteToEndPosition note 
    = case note of
        C -> (-60, -19)
        CSharp -> (-43.5, -19)
        D -> (-27, -19)
        DSharp -> (-10.5, -19)
        E -> (-43.5, -31.5)
        F -> (-27, -31.5)
        FSharp -> (-10.5, -31.5)
        G -> (6, -31.5)
        GSharp -> (-60, -25.25)
        A -> (-43.5, -25.25)
        ASharp -> (-27, -25.25)
        B -> (-10.5, -25.25)
        Rest -> (0, -50)

-- Given a Note, it returns the associated y-coordinate as a Float.
noteToEndYPosition : Note -> Float
noteToEndYPosition note
    = case note of
        C -> -19
        CSharp -> -19
        D -> -19
        DSharp -> -19
        E -> -31.5
        F -> -31.5
        FSharp -> -31.5
        G -> -31.5
        GSharp -> -25.25
        A -> -25.25
        ASharp -> -25.25
        B -> -25.25
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
        C -> -60
        CSharp -> -43.5
        D -> -27
        DSharp -> -10.5
        E -> -43.5
        F -> -27
        FSharp -> -10.5
        G -> 6
        GSharp -> -60
        A -> -43.5
        ASharp -> -27
        B -> -10.5
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
