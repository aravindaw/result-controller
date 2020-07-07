export RESULT_PATH=$1
export REPORT_PATH=$2
TMP_PATH=/home/allure-results

echo $RESULT_PATH generating >> /home/result-controller/info.log
[ -f $RESULT_PATH ] && mv $RESULT_PATH $TMP_PATH
[ ! -f $REPORT_PATH_PATH/history ] && mv $REPORT_PATH/history $TMP_PATH/history
allure generate $TMP_PATH --clean -o $REPORT_PATH
echo $TMP_PATH generated >> /home/result-controller/info.log
[ -f  $TMP_PATH] && rm -rf $TMP_PATH
return 1
