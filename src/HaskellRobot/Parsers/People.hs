module HaskellRobot.Parsers.People
       ( peopleParser
       ) where

import           Control.Applicative              ((<|>))
import           Data.Text                        (pack)

import           Text.Megaparsec                  (eof, sepEndBy, some)
import           Text.Megaparsec.Char             (char, letterChar, newline)

import           HaskellRobot.Data.ReifiedStudent (ReifiedStudent (..))
import           HaskellRobot.Data.Task           (TaskId)
import           HaskellRobot.Parsers.Common      (Parser)

studentRow :: Parser (ReifiedStudent TaskId)
studentRow = do
    name <- pack <$> some (letterChar <|> char ' ')
    return ReifiedStudent { variant = -1, tasks = [], .. }

peopleParser :: Parser [ReifiedStudent TaskId]
peopleParser = do
    students <- studentRow `sepEndBy` newline
    eof
    return $ zipWith (\i sample -> sample{ variant = i }) [1..] students
