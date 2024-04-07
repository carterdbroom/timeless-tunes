port module Ports exposing (..)

type alias Sound = { id : String, url : String }

port play : Sound -> Cmd msg
