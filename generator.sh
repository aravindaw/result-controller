export RESULT_PATH=$1
export REPORT_PATH=$2
TMP_PATH=/home/allure-result
BACKUP_PATH=/home/backup
TIME_STAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# shellcheck disable=SC2129
echo "$RESULT_PATH" generating >> /home/result-controller/info.log
echo "$RESULT_PATH" >> /home/result-controller/info.log
echo "$REPORT_PATH" >> /home/result-controller/info.log

# unzip and backup zipped result file
echo extract tar file >> /home/result-controller/info.log
[ -f "$RESULT_PATH" ] && tar -xf "$RESULT_PATH" -C /home && mv "$RESULT_PATH" $BACKUP_PATH

# Remove history file if existing in the TMP result folder
[ ! -f "$TMP_PATH"/history ] && rm -rf "$TMP_PATH"/history

# Replace Report history file (if existing) with the TMP result folder
echo move history file to result folder >> /home/result-controller/info.log
[ ! -f "$REPORT_PATH"/history ] && mv "$REPORT_PATH"/history $TMP_PATH/history

echo generate report folder from result folder >> /home/result-controller/info.log
allure generate "$TMP_PATH" --clean -o "$REPORT_PATH/$TIME_STAMP"

echo remove tmp report >> /home/result-controller/info.log
[ ! -f  $TMP_PATH ] && rm -rf $TMP_PATH

echo create a symlink
ln -s "$REPORT_PATH/$TIME_STAMP" /home/allure-report

# Backup report
cp -pr /home/allure-report /home/report-backup

return 1
