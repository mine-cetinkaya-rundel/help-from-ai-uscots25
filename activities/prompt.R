library(ellmer)
library(glue)
library(tidyverse)
library(dotenv) # Will read OPENAI_API_KEY from .env file

prompt <- function(question, rubric, answer) {
  chat <- chat_anthropic(
    system_prompt = paste(
      "You are a helpful course instructor teaching a course on data science with the R programming language and the tidyverse and tidymodels suite of packages. You like to give succinct but precise feedback.",
      read_lines("system-prompt/pipes.qmd") |> glue_collapse()
    )
  )

  chat$chat(
    glue(
      "Carefully read the {question} and the {rubric_detailed}, then evaluate {answer} against the {rubric_detailed} to provide feedback. 
      Provide feedback in an output section named **Feedback:**. 
      Format the feedback as bullet points: Each bullet point should first state the rubric item text from {rubric}, and then provide one sentence explaining whether the {answer} meets the {rubric} item.
      Do not give away the correct answer in the feedback."
    )
  )
}
