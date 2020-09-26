jobstatus.py
jobfilter.py
geom_time.py -l 1 2 geom.xyz
./rename.sh l12.dat
geom_time.py -d 1 2 5 6 geom.xyz
./rename.sh d1256.dat
geom_time.py -d 1 2 6 5 geom.xyz
./rename.sh d1265.dat
geom_time.py -d 2 1 3 4 geom.xyz
./rename.sh d2134.dat
geom_time.py -d 2 1 4 3 geom.xyz
./rename.sh d2143.dat
geom_time.py -d 3 4 2 1 geom.xyz
./rename.sh d3421.dat
geom_time.py -d 6 5 1 2 geom.xyz
./rename.sh d6512.dat
