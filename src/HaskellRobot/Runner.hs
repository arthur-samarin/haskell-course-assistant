module HaskellRobot.Runner
       ( TaskContext (..)
       , generateTexFile
       ) where

import           Control.Monad.Random             (evalRandIO)
import           System.FilePath                  (takeFileName, (<.>), (</>))
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

parseTasks :: String -> TaskBlock
parseTasks s = case parse tasksParser "" s of
                    Left e      -> error $ show e
                    Right tasks -> tasks

parseStudents :: String -> [ReifiedStudent TaskId]
parseStudents s = case parse peopleParser "" s of
                       Left e         -> error $ show e
                       Right students -> students

generateTexFile :: TaskContext -> IO ()
generateTexFile TaskContext{..} = do
    tasksFileContent    <- readFile tasksFileName
    studentsFileContent <- readFile studentsFileName
    let tasks            = parseTasks tasksFileContent
    let students         = parseStudents studentsFileContent

    putStrLn $ "Total students: " ++ show (length students)
    putStrLn $ "Total task blocks: " ++ show (length tasks)

    variants <- evalRandIO $ assignRandomTasks students tasks
    let texVariants = toTexFile texConverter variants

    -- TODO: check if directory exist
    let outputFileName = outputFolder </> (takeFileName tasksFileName) <.> "tex"
    writeFile outputFileName texVariants
--    withFile ("vars" </> cwOutput) WriteMode $ \cwVarsHandle -> do
--        hSetEncoding cwVarsHandle utf8
--        hPutStr cwVarsHandle texVariants
