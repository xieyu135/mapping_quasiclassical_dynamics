#!/bin/bash

main_dir=$PWD


texfile='plot.tex'
dvifile='plot.dvi'


exec 1>$texfile
echo '\documentclass{article}'
echo '\usepackage{graphicx}'
echo '\begin{document}'
echo ""
num=0
for wc in 39      40   95     100   182    200   1000
do
  for kdw in   0.5    1.0  1.5
  do
    num=`echo "$num+1" | bc`
    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    caption="wc_$wc""_kdw_$kdw"
    echo "\\begin{figure}"
    echo "\\begin{center}"
    echo "\\includegraphics[width=0.8\textwidth]{$work_dir/kdw.eps}"
    echo "\\end{center}"
    tmp=${caption//_/\\_}
    echo "\\caption{\$$tmp$}"
    echo "\\end{figure}"
    j=`echo "$num%18" | bc`
#    echo $j
if [ "$j" -eq '0' ];then
    echo "\\clearpage"
    echo ""
fi
  done
done

echo "\\end{document}"
exec 1>'shtex.log'


latex $texfile
dvipdfm $dvifile
rm plot.aux  plot.dvi  plot.log  plot.tex  shtex.log
