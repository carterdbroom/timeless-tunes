module AdvancedApp exposing (..)


import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)

import List exposing (range)
import String
import Array

import Ports exposing(..)

{-StartingCode-}
-- Your shapes go here
myShapes model =
  [
    circle 10 
      |> filled red 
      |> notifyTap Pause
      |> move (-20, 0)
  , circle 10 
      |> filled green 
      |> notifyTap Play
      |> move (20, 0)
  ]

-- Add messages here
type Msg = Tick Float GetKeyState
        | Play
        | Pause

-- This is the type of your model
type alias Model = { time : Float }

-- Your update function goes here
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of
    Tick t _ -> ( { model | time = t }, Cmd.none )
    Play -> ( model, play mySound )
    Pause -> ( model, pause mySound )

mySound = { id = "Song", url = "https://github.com/CSchank/CSchank.github.io/raw/master/stylish-intro-logo-youtube-18457.mp3" }

-- Your initial model goes here
init : Model
init = { time = 0 }

-- Your subscriptions go here
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- Your main function goes here
main : EllieAppWithTick () Model Msg
main = 
  ellieAppWithTick Tick 
    { init = \flags -> (init, Cmd.none)
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- You view function goes here
view : Model -> { title: String, body : Collage Msg }
view model = 
  {
    title = "My App Title"
  , body = collage 192 128 (myShapes model)
  }

{-EndStartingCode-}

{-ViewonlyCode-}
-- repeat an animation for a given duration
repeatDuration : Float -> Int -> Float -> Float -> Float
repeatDuration speed duration startPosition time =
  speed * (time - toFloat duration * toFloat (floor time // duration)) + startPosition

repeatDistance : Float -> Float -> Float -> Float -> Float
repeatDistance speed distance startPosition time =
  repeatDuration speed (round <| distance / speed) startPosition time

animationPieces : List (Float, Float -> anytype) -> (Float -> anytype) -> Float -> anytype
animationPieces intervals finalAnimation time =
  case intervals of
    (duration, animation) :: rest ->
        if time <= duration then
          animation time
        else
          animationPieces rest finalAnimation (time - duration)
    [] ->
        finalAnimation time

plotGraph : (Float -> Float) -> Float -> Shape a
plotGraph f time =
  group
    [ openPolygon (List.map (\ t -> (-96+(toFloat t)/2.5 - 200 * toFloat (floor (time / 10)),f (toFloat t / 50))) <| List.range (500 * floor (time / 10)) (500 * ceiling (time / 10))) |> outlined (solid 1) (rgb 0 0 200)
    , group [
              circle 3 |> filled red
            , text ("(" ++ String.fromFloat time ++ ", " ++ String.fromFloat (toFloat (round <| (f time) * 100) / 100)  ++ ")")
                |> size 6
                |> filled black
                |> move (5, 5)
            ]

        |> move (-96+20* time - 200 * toFloat (floor (time / 10)),f (time))
    ]

{-EndViewonlyCode-}
