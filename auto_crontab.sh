#!/usr/bin/env bash
#sudo wget -N --no-check-certificate https://github.com/itwarlock/shadowsocksR_1nstall/raw/master/auto_crontab.sh && chmod +x auto_crontab.sh && bash auto_crontab.sh
#sudo wget -N --no-check-certificate https://github.com/itwarlock/shadowsocksR_1nstall/raw/master/ssr_check.sh -O /tmp/ssr_check.sh && chmod +x /tmp/ssr_check.sh


CUR_PATH=$(cd "$(dirname "$0")"; pwd)
echo "${CUR_PATH}" 
sudo wget -N --no-check-certificate https://github.com/itwarlock/shadowsocksR_1nstall/raw/master/ssr_check.sh
sudo chmod +x /tmp/ssr_check.sh

SCRIPT_NAME="ssr_check.sh"
# 要定时执行的任务
TASK_COMMAND="sudo bash ${CUR_PATH}/ssr_check.sh"
# 要添加的crontab任务
# 每1分钟执行一次 任务
CRONTAB_TASK="*/1 * * * * ${TASK_COMMAND}"
# 备份原始crontab记录文件
CRONTAB_BAK_FILE="${CUR_PATH}/crontab_bak"
echo   ${CRONTAB_BAK_FILE}

# 创建crontab任务函数
function create_crontab()
{
    echo 'Create crontab task...'
    crontab -l > ${CRONTAB_BAK_FILE} 2>/dev/null
    sed -i "/.*${CRONTAB_TASK}/d" ${CRONTAB_BAK_FILE}  # 已存在任务时会被sed删除，防止重复添加
    echo "${CRONTAB_TASK}" >> ${CRONTAB_BAK_FILE}
    crontab ${CRONTAB_BAK_FILE}

    echo 'Complete'
}

# 清除crontab任务函数
function clear_crontab(){
    echo 'Delete crontab task...'
    crontab -l > ${CRONTAB_BAK_FILE} 2>/dev/null
    sed -i "/.*${SCRIPT_NAME}/d" ${CRONTAB_BAK_FILE}
    crontab ${CRONTAB_BAK_FILE}

    echo 'Complete'
}

if [ $# -lt 1 ]; then
    echo "Usage: $0 [start | stop]"
    exit 1
fi

case $1 in
    'start' )
        create_crontab
        ;;
    'stop' )
        clear_crontab
        ;;
esac
