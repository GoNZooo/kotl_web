module Monitor where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import StartApp exposing (start)
import String exposing (toLower)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import Json.Decode as Json exposing ((:=))

-- Model
type alias Monitoree = {kind : String, name : String, status : String}

type alias Model = List Monitoree

init : (Model, Effects Action)
init =
  ([], Effects.none)
  

type Action
  = NoOp
  | SetMonitorees Model

-- Update
update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      ([], Effects.none)
    SetMonitorees monitorees ->
      (monitorees, Effects.none)

-- View
renderMonitoree : Monitoree -> Html
renderMonitoree monitoree =
  let name = monitoree.name
      kind = monitoree.kind
      status = monitoree.status
  in
  div [] [text (name ++ " (" ++ kind ++ ") is " ++ status)]

view : Signal.Address Action -> Model -> Html
view address model =
  div [] (List.map renderMonitoree model)

-- Effects
decodeMonitorees : Json.Decoder Model
decodeMonitorees =
  let
    monitoree =
      Json.object3 (\kind name status -> (Monitoree kind name status))
          ("kind" := Json.string)
          ("name" := Json.string)
          ("status" := Json.string)
  in
    Json.at ["data"] (Json.list monitoree)

-- Signals
incomingActions : Signal Action
incomingActions =
  Signal.map SetMonitorees monitorees

port tasks : Signal (Task Never ())
port tasks =
  app.tasks

port monitorees : Signal Model

app = start { init = init
            , inputs = [incomingActions]
            , update = update
            , view = view
            }

main : Signal Html
main =
  app.html
