#!/usr/bin/env bash

# скрипт переименновывает файлы в папке, подставляя номера
# от конца и до начала, т.е. первый файл будет 999, второй 998
# и т.д. Сделано это для того, что бы плеер в телевизоре 
# начинал проигрывание с последнего и переходил к предпоследнему
# а не перескакивал на первый.
# запуск ./rename_masha.sh <pathdir>
MAXCOUNT=999
path=$1

cd $path
for filename in *; do
	tofile=`echo "$MAXCOUNT $filename" | cut --complement -d" " -f2`
	mv "$filename" "$tofile"
	((MAXCOUNT--))
done
exit 0
