
name=$(basename $0)
if [ $name = "addem" ]
then
total=$[ $1 + $2 ]
elif [ $name = "multem" ]
then
total=$[ $1 * $2 ]
fi
echo
echo Izračunana vrijednost je $total
