
curl http://169.254.169.254/latest/meta-data/instance-id >> z-sid.temp

for i in $(cat z-sid.temp)
do
	python3 string-slicer.py $i >> sliced-string
done

for n in $(cat sliced-string)
do
	echo "add_header z-sid $n;" >> aws_"$n"_header-include
	sudo mv aws_"$n"_header-include /etc/nginx/headers
done

rm -rf z-sid.temp sliced-string test
