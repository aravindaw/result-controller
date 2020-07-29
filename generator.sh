export RESULT_PATH=$1
export REPORT_PATH=$2
TMP_PATH=/home/allure-result

# shellcheck disable=SC2129
echo "$RESULT_PATH" generating >> /home/result-controller/info.log
echo "$RESULT_PATH" >> /home/result-controller/info.log
echo "$REPORT_PATH" >> /home/result-controller/info.log
# unzip and remove zipped result file
[ -f "$RESULT_PATH" ] && tar -xf "$RESULT_PATH" -C /home && rm -rf "$RESULT_PATH"
echo extract tar file >> /home/result-controller/info.log
# Remove history file if existing in the result folder
[ ! -f "$TMP_PATH"/history ] && rm -rf "$TMP_PATH"/history
[ ! -f "$REPORT_PATH_PATH"/history ] && mv "$REPORT_PATH"/history $TMP_PATH/history
echo move history file to result folder >> /home/result-controller/info.log
allure generate "$TMP_PATH" --clean -o "$REPORT_PATH"
echo generate report folder from result folder >> /home/result-controller/info.log
[ ! -f  $TMP_PATH ] && rm -rf $TMP_PATH
echo remove tmp report >> /home/result-controller/info.log
# shellcheck disable=SC2046
# shellcheck disable=SC2009
allure open -p 8080 /home/allure-report/ &
return 1
