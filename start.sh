#!/bin/bash

ln -fs /home/report-backup/allure-report /home/allure-report
allure open -p 8080 /home/allure-report/ &
/usr/bin/python3 /home/result-controller/src/resultController.py
