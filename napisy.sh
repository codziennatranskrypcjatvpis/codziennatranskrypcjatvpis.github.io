#!/bin/bash
rm /media/Recordings/Wiadomosci_archiwum/*.ts
/usr/local/bin/ccextractor $(ls -Art | grep \.ts | tail -n 1) -nofc -nots -tpage 778 -o Wiadomosci.srt
grep -v 'STRONA 777' Wiadomosci.srt | grep -v 'NAPISY DLA NIESŁYSZĄCYCH' | grep -v 'WYKAZ PROGRAM' | grep -v ",,," | grep -v 'KOLEJNA EMISJA' | grep -v " / " | sponge Wiadomosci.srt
grep -E "[A-Za-z]" Wiadomosci.srt | tr '\r\n' ' ' | tr -s \ > transcriptions_txt/Wiadomosci_$(date +%d.%m.%Y).txt
mv Wiadomosci.srt transcriptions_srt/Wiadomosci_$(date +%d.%m.%Y).srt
rm README.md
touch README.md
echo "* [Wiadomosci_$(date +%d.%m.%Y).srt](https://raw.githubusercontent.com/codziennatranskrypcjatvpis/codziennatranskrypcjatvpis.github.io/main/transcriptions_srt/Wiadomosci_$(date +%d.%m.%Y).srt)" | cat - lista.md | sponge lista.md
echo "* [Wiadomosci_$(date +%d.%m.%Y).txt](https://raw.githubusercontent.com/codziennatranskrypcjatvpis/codziennatranskrypcjatvpis.github.io/main/transcriptions_txt/Wiadomosci_$(date +%d.%m.%Y).txt)" | cat - lista.md | sponge lista.md
echo "[FAQ](https://github.com/codziennatranskrypcjatvpis/codziennatranskrypcjatvpis.github.io/blob/main/FAQ.md)" | cat - lista.md | sponge README.md
git add transcriptions_txt/Wiadomosci_$(date +%d.%m.%Y).txt
git add transcriptions_srt/Wiadomosci_$(date +%d.%m.%Y).srt
git add README.md
git commit -m "Nowe wydanie"
git push origin
