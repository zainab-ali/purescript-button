module Button where

import Prelude
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

data Query a = Toggle a | IsOn (Boolean -> a)
-- sealed trait Query[A]
-- case class Toggle[A] extends Query[A]
-- case class IsOn[A](f: Boolean -> A) extends Query[A]

data Message = Toggled Boolean
-- sealed trait Message
-- case class Toggled(value: Boolean) extends Message


component :: forall m. H.Component HH.HTML Query Unit Message m
component =
  H.component
  {
    initialState : const initialState
    , render
    , eval
    , receiver: const Nothing
  }
  where initialState :: Boolean
        initialState = false

        render :: Boolean -> H.ComponentHTML Query
        render isToggled =
          let label = if isToggled then "On" else "Off"
          in HH.button [
            HP.title label
            , HE.onClick (HE.input_ Toggle)
            ]
             [ HH.text label]
        eval :: Query ~> H.ComponentDSL Boolean Query Message m
        eval = case _ of
          Toggle next -> do
            _ <- H.modify(\state -> not state)
            pure next
          IsOn reply -> do
            state <- H.get
            pure (reply state)
