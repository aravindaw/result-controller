#!/bin/bash

ln -s /home/report-backup /home/allure-report
allure open -p 8080 /home/allure-report/ &
/usr/bin/python3 /home/result-controller/src/resultController.py
