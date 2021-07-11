#!/bin/bash
rm /tmp/*.ts
/usr/local/bin/ccextractor *TVP*.ts -nofc -nots -tpage 777 -o Wiadomosci.srt
grep -v 'STRONA 777' Wiadomosci.srt > Wiadomosci2.srt
grep -v 'NAPISY DLA NIESŁYSZĄCYCH' Wiadomosci2.srt > Wiadomosci.srt
grep -v 'WYKAZ PROGRAM' Wiadomosci.srt > Wiadomosci2.srt
grep -v ",,," Wiadomosci2.srt > Wiadomosci.srt
grep -v 'KOLEJNA EMISJA' Wiadomosci.srt > Wiadomosci2.srt
grep -v " / " Wiadomosci2.srt > Wiadomosci.srt
mv Wiadomosci.srt Wiadomosci_$(date +%d.%m.%Y).srt
rm Wiadomosci2.srt
/usr/local/bin/ccextractor *TVP*.ts -nofc -nots -tpage 777 -out=txt -o Wiadomosci.txt
grep -v 'STRONA 777' Wiadomosci.txt > Wiadomosci2.txt
grep -v 'NAPISY DLA NIES ^aYSZ ^dCYCH' Wiadomosci2.txt > Wiadomosci.txt
grep -v 'WYKAZ PROGRAM' Wiadomosci.txt > Wiadomosci2.txt
grep -v ",,," Wiadomosci2.txt > Wiadomosci.txt
grep -v 'KOLEJNA EMISJA' Wiadomosci.txt > Wiadomosci2.txt
grep -v " / " Wiadomosci2.txt > Wiadomosci.txt
tr '\r\n' ' ' < Wiadomosci.txt > Wiadomosci2.txt
tr -s \ < Wiadomosci2.txt > Wiadomosci.txt
mv Wiadomosci.txt Wiadomosci_$(date +%d.%m.%Y).txt
rm Wiadomosci2.txt
rm README.md
touch README.md
echo "* [Wiadomosci_$(date +%d.%m.%Y).srt](https://raw.githubusercontent.com/codziennatranskrypcjatvpis/codziennatranskrypcjatvpis.github.io/main/Wiadomosci_$(date +%d.%m.%Y).srt)" | cat - lista.md | sponge lista.md
echo "* [Wiadomosci_$(date +%d.%m.%Y).txt](https://raw.githubusercontent.com/codziennatranskrypcjatvpis/codziennatranskrypcjatvpis.github.io/main/Wiadomosci_$(date +%d.%m.%Y).txt)" | cat - lista.md | sponge lista.md
echo "Znaczniki czasu w plikach .srt są nieprawidłowo przesunięte z przyczyn technicznych, mile widziane poprawki w pull requestach. " | cat - lista.md | sponge README.md
git add Wiadomosci_$(date +%d.%m.%Y).txt
git add Wiadomosci_$(date +%d.%m.%Y).srt
git add README.md
git commit -m "Nowe wydanie"
git push origin
mv *.ts /tmp/
