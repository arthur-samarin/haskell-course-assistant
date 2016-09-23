module HaskellRobot.Headers.Common
       ( varStart
       , varEnd
       
       , listStart
       , listItem
       , listEnd
       
       , taskPreabmle
       , taskProblemWord
       
       , documentStart
       , documentEnd
       ) where

-- variants begin * end
varStart :: Int -> Int -> String -> String
varStart cw i name = let var = show i in "\
\%\n\
\% Вариант " ++ var ++ "\n\
\%\n\
\\n\
\\\begin{center}\n\
\  \\textbf{\\LARGE{Вариант " ++ var ++ " (КР " ++ show cw ++ ")} \\\\}\n\
\\n\
\  " ++ name ++ "\n\
\\\end{center}\n\
\\n\
\Для каждого задания требуется также придумать несколько разумных тестов. \
\Хорошие тесты могут улучшить оценку задания. Также требуется перед каждой задачей в комментарии писать текст задания \
\(можно коротко, главное, чтобы было понятно, какое задание).\n\
\\n\
\\\begin{figure}[H]\n\
\  \\centering\n\
\  \\includegraphics[width=500pt]{images/bord3.png}\n\
\\\end{figure}\n\n"

varEnd :: String
varEnd = "\
\\\begin{figure}[H]\n\
\  \\centering\n\
\  \\includegraphics[width=500pt]{images/bord4.png}\n\
\\\end{figure}\n\
\\n\
\\\pagebreak\n\n"

-- variant list constants
listStart :: String
listStart = "\\begin{enumerate}\n"

listEnd :: String
listEnd = "\\end{enumerate}\n\n"

listItem :: Int -> String
listItem i = "  \\item[" ++ show i ++ ".]\n"

taskPreabmle :: Int -> String
taskPreabmle i = listItem i ++ "  \\textbf{\\textit{Условие:}}\n\n"

taskProblemWord :: String
taskProblemWord = "  \\textbf{\\textit{Задача:}}\n\n"

-- theory min specific header
theoryMinStart :: Int -> String -> String
theoryMinStart i name = "\
\\\begin{center}\n\
\    \\textbf{\\Large{Теоретический минимум} \\\\}\n\
\\n\
\    " ++ name ++ " (вариант " ++ show i ++ ")\n\
\\\end{center}\n\n"

theoryMinEnd :: String
theoryMinEnd = "\\pagebreak\n\n"

frameBox :: String
frameBox = "\\framebox(500,35){}"

-- tex document begin & end
documentHeader :: String
documentHeader = "\\documentclass[11pt,a4paper]{article}\n\
\\n\
\\\usepackage{fullpage}\n\
\\\usepackage[utf8]{inputenc}\n\
\\\usepackage[russian]{babel}\n\
\\\usepackage{graphicx}\n\
\\\usepackage{float}\n\
\\\usepackage[stable]{footmisc}\n\
\\\usepackage{caption}\n\
\\\usepackage{subcaption}\n\
\\\usepackage{url}\n\
\\\usepackage{amsmath}\n\
\\\usepackage{amssymb}\n\
\\\usepackage{listings}\n\
\\n\
\\\usepackage[margin=0.3in]{geometry}\n\
\\n\
\\\setlength\\parindent{0pt}\n\
\\n\
\\\pagenumbering{gobble}\n\
\\n\
\\\begin{document}\n\n"

documentEnd :: String
documentEnd = "\\end{document}"
