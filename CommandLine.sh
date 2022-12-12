#!/bin/sh

pip install csvkit

clear

echo "Which location has the maximum number of purchases been made?"
csvcut -c CustLocation bank_transactions.csv | sort | uniq -c | sort -n -r | head -n 1

echo "In the dataset provided, did females spend more than males, or vice versa?"
csvsql --query "select CustGender, sum([TransactionAmount (INR)]) as totalAmount from bank_transactions group by CustGender order by totalAmount desc limit 1;" bank_transactions.csv | csvlook

echo "Report the customer with the highest average transaction amount in the dataset."
awk '{ sum += $2 } END { if (NR > 0) print sum / NR }' | csvcut -c 2,9 bank_transactions.csv | csvsort -c 2 -r | head -n 2


