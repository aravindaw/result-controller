export RESULT_PATH=$1
export REPORT_PATH=$2
TMP_PATH=/home/allure-results

echo $RESULT_PATH generating >> /home/info.log
echo $RESULT_PATH >> /home/info.log
echo $REPORT_PATH >> /home/info.log
[ -f $RESULT_PATH ] && tar -xvf $RESULT_PATH -C /home && rm -rf $RESULT_PATH
echo extract tar file >> /home/info.log
[ -f $REPORT_PATH_PATH/history ] && mv $REPORT_PATH/history $TMP_PATH/history
echo move history file to result folder >> /home/info.log
allure generate $TMP_PATH --clean -o $REPORT_PATH
echo generate report folder from result folder >> /home/info.log
[ -f  $TMP_PATH ] && rm -rf $TMP_PATH
echo remove tmp report >> /home/info.log
kill -9 $(ps aux | grep 'allure' | awk '{print $2}')
echo open allure report >> /home/info.log
allure open -p 8080 /home/allure-report/ &
return 1
