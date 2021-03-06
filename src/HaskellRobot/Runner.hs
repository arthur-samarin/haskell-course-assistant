module HaskellRobot.Runner
       ( TaskContext (..)
       , generateTexFile
       ) where

import           Prelude                          hiding (putStrLn, readFile, writeFile)

import           Control.Monad.Random             (evalRandIO)
import           Data.Text                        (Text)
import           Data.Text.IO                     (putStrLn, readFile, writeFile)
import           Formatting                       (int, sformat, (%))
import           System.FilePath                  (takeFileName, (<.>), (</>))
import           Text.LaTeX.Base                  (render)
import           Text.Megaparsec                  (parse)

import           HaskellRobot.Converter           (TexConverter, toTexFile)
import           HaskellRobot.Data.ReifiedStudent (ReifiedStudent)
import           HaskellRobot.Data.Task           (TaskBlock, TaskId)
import           HaskellRobot.Parsers.People      (peopleParser)
import           HaskellRobot.Parsers.Tasks       (tasksParser)
import           HaskellRobot.Shuffler            (assignRandomTasks)

data TaskContext = TaskContext
    { tasksFileName    :: FilePath
    , studentsFileName :: FilePath
    , outputFolder     :: FilePath
    , texConverter     :: TexConverter
    }

parseTasks :: Text -> TaskBlock
parseTasks s = case parse tasksParser "" s of
                    Left e      -> error $ show e
                    Right tasks -> tasks

parseStudents :: Text -> [ReifiedStudent TaskId]
parseStudents s = case parse peopleParser "" s of
                       Left e         -> error $ show e
                       Right students -> students

generateTexFile :: TaskContext -> IO ()
generateTexFile TaskContext{..} = do
    tasksFileContent    <- readFile tasksFileName
    studentsFileContent <- readFile studentsFileName
    let parsedTasks      = parseTasks tasksFileContent
    let students         = parseStudents studentsFileContent

    putStrLn $ sformat ("Total students: "    % int) $ length students
    putStrLn $ sformat ("Total task blocks: " % int) $ length parsedTasks

    variants <- evalRandIO $ assignRandomTasks students parsedTasks
    putStrLn "Tasks assigned!"
    let texVariants = render $ toTexFile texConverter variants

    -- TODO: check if directory exist
    let outputFileName = outputFolder </> takeFileName tasksFileName <.> "tex"
    writeFile outputFileName texVariants
