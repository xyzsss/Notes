
#!/bin/bash
# Usage: get douban  *.jpg

echo -e "Start get jpg Now ~~~~\n"
echo "-------------------------------"
sleep 2

for j in `seq 2189368128 2189994647`
do
        url=http://img3.douban.com/view/photo/photo/public/p$j.jpg
        wget $url
        sleep 1
done

echo -e "Down load Over !!!\n"
echo "-------------------------------"
