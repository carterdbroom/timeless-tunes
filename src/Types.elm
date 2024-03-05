module Types exposing (..)

import GraphicSVG.App exposing (GetKeyState)
import Dict exposing (..)

type alias Model = 
    {
    score : Int
    }

type Msg 
    = Tick Float GetKeyState

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