module Main where

import           System.Environment     (getArgs)

import           HaskellRobot.Converter (toTexCwVariant)
import           HaskellRobot.Runner    (TaskContext (..), generateTexFile)

main :: IO ()
main = do
    [studentsFileName, tasksFileName, outputFolder] <- getArgs  -- TODO: use optparse-applicative
    generateTexFile TaskContext{ texConverter = toTexCwVariant 1, .. }
