# BitPanda-Shell
A very simple BitPanda Api wrapper in bash shell

## Description
Easy way to get informations about a list of stocks from BitPanda using shell.

## Usage
#### Download
```shell
# clone the repo
git clone https://github.com/DrankRock/BitPanda-Shell.git
# change the working directory to BitPanda-Shell
cd BitPanda-Shell/
```
#### Use
```shell
# Update the list of all the stocks
./BitPandaGather.sh
# Find the informations about Amazon, Apple and Google
./BitPandaCheck.sh "AMZN,GOOGL,AAPL"
# or (Alphabet is the stock name of google)
./BitPandaCheck.sh "Amazon,Apple,Alphabet"
```
#### Output
```text
Id, Name, Price, Daily Price Change, Weekly Price Change, Monthly Price Change, Yearly Price Change, Circulating Supply
AMZN,Amazon,2403.00,0.06,1.41,-3.80,36.69,662121000.00
GOOGL,Alphabet,2652.50,-0.17,-1.94,-3.61,5.37,509000000.00
AAPL,Apple,147.98,-0.46,2.25,-1.62,45.68,16426786000.00
```

