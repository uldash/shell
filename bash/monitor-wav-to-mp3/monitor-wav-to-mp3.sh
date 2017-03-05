#!/bin/bash
#Заменяет все wav файлы в указанной папке на mp3, но с расширением wav
#Для работы скрипта необходим lame
#Запуск скрипта ./monitor_wav_to_mp3 <путь к каталогу>
#<путь к каталогу> каталог содержащий записи астериск
#Скрипт пережмет все найденные записи в заданном каталоге из wav в mp3 с качеством V2
#Применение скрипта показало следующи результаты:
#25 GB -> 6.2 GB 4940 sek = 1.37 h

Пример вызова с подавлением вывода: ./monitor_wav_to_mp3.sh /var/spool/asterisk/monitor -1 > /dev/null 2>&1 Пережать все файлы в папке моложе 1 дня TEST
function ProgressBar {
        let _progress=(${1}*100/${2}*100)/100
        let _done=(${_progress}*4)/10
        let _left=40-$_done
        _fill=$(printf "%${_done}s")
        _empty=$(printf "%${_left}s")
        printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"
}

if [ $# -eq 0 ]
then
        echo 'Скрипт перекодирует wav файлы в указанной папке в mp3 формат, оставляя имя и разрешение'
        echo 'пример запуска ./monitor_wav_to_mp3.sh /var/spool/asterisk/monitor -1 > /dev/null 2>&1'
        exit 0
fi

MONDIR=$1
DMON=$2
if ! [ -d $MONDIR ];
then
        echo Directory not found!!!
        exit 1
fi

COUNT=$(find $MONDIR -type f -name "*.wav" -mtime $DMON| wc -l)
i=1

for WAVFILE in $(find $MONDIR -type f -name "*.wav" -mtime $DMON); do
        ProgressBar ${i} ${COUNT}
        i=$(($i+1))
        MP3FILE=$WAVFILE'.mp3'
        lame -V2 -S $WAVFILE $MP3FILE > /dev/null 2>&1
        mv -f $MP3FILE $WAVFILE > /dev/null 2>&1
        chown asterisk:asterisk $WAVFILE
done

echo -e "\nSeconds in script work:\t"$SECONDS
echo -e "\nFile encodered:\t"$i
exit 0
#ТЕСТ ТЕСТ
#01
#02:
