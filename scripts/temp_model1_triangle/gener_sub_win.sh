
for((i=1;i<=9;i++))
do
head -n 6 sub_mapping.sh > win_$i.sh 
echo "python win_$i.py" >> win_$i.sh
#tail -n 2 sub_mapping.sh >> win_$i.sh
done
