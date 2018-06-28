module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

import Button as B

main :: Effect Unit
main = do
  HA.runHalogenAff (
    do body <- HA.awaitBody
       runUI B.component unit body
                   )
  log "Hello sailor!"
