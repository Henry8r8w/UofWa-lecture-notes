#!/bin/bash

####################################
# Name: <Your name here>
# CSE 391 - Winter 2025
# Homework 2 - Task 2
####################################

function problem1 {
  # Type your answer to problem #1 below this line
  javac ParseColumn.java
}

function problem2 {
  # Type your answer to problem #2 below this line
  java ParseColumn 3 < intro_survey.csv > candies.txt

}

function problem3 {
  # Type your answer teads a CSV file from stdin and outputs only the specified column in the CSV file.o problem #3 below this line
  grep --ignore-case "chocolate" candies.txt
}

function problem4 {
  # Type your answer to problem #4 below this line
  grep -vi "chocolate" candies.txt
}

function problem5 {
  # Type your answer to problem #5 below this line
  tail -n +2 intro_survey.csv > intro_survey_no_header.csv  
}

function problem6 {
  # Type your answer to problem #6 below this line
  tail -n 1 intro_survey_no_header.csv | java ParseColumn 2
}

function problem7 {
  # Type your answer to problem #7 below this line
  echo "$(wc -l < intro_survey_no_header.csv) intro_survey_no_header.csv"
}

function problem8 {
  # Type your answer to problem #8 below this line
  java ParseColumn 4 < intro_survey.csv | grep -ix "no" | wc -l
}

function problem9 {
  # Type your answer to problem #9 below this line
  java ParseColumn 1 < intro_survey.csv | tail -n +2 | sort -f | uniq -i | wc -l
}
