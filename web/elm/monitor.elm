module Monitor where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import StartApp.Simple exposing (start)
import String exposing (toLower)

-- Model
type Status
  = Up
  | Down

type Kind
  = Node
  | Host
  | Process

type alias Monitoree = {kind : Kind, name : String, status : Status}

type alias Model = List Monitoree

initialModel : Model
initialModel = [{kind = Node, name = "node", status = Up}]

type Action
  = NoOp
  | Update

-- Update
update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      initialModel
    _ ->
      initialModel

-- View
renderMonitoree : Monitoree -> Html
renderMonitoree monitoree =
  let monName = monitoree.name
      monKind = monitoree.kind |> toString |> toLower
      monStatus = monitoree.status |> toString |> toLower
  in
  span [] [text (monName ++ " (" ++ monKind ++ ") is " ++ monStatus)]

view : Signal.Address Action -> Model -> Html
view address model =
  div [] (List.map renderMonitoree model)

main =
  start {model = initialModel, update = update, view = view}
