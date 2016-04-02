module Monitor where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import StartApp.Simple exposing (start)

-- Model
type Status
  = Up
  | Down

type alias Monitoree = { name : String
                       , status : Status
                       }
type alias Model = List Monitoree

initialModel : Model
initialModel =
  [
   { name = "node"
   , status = Up
   }
  ]

type Action
  = NoOp

-- Update
update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      initialModel

-- View
view : Signal.Address Action -> Model -> Html
view address model =
  text (toString model)

main =
  start { model = initialModel
        , update = update
        , view = view
        }
