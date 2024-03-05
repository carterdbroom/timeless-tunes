module Types exposing (..)

import Dict exposing (..)



type Note
    = C
    | CSharp
    | D
    | DSharp
    | E
    | F
    | FSharp
    | G
    | GSharp
    | A
    | ASharp
    | B 

type NoteTime
    = Whole
    | Half
    | Quarter
    | Eighth
    | Sixteenth

type Song
    = Twinkle (Dict (Maybe Note) NoteTime)