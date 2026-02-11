#!/bin/bash
/usr/local/bin/ccextractor "$1" -nofc -nots -tpage 778 -o /tmp/Wiadomosci.srt
cat /tmp/Wiadomosci.srt | grep -v 'STRONA 777' | grep -v 'NAPISY DLA NIESŁYSZĄCYCH' | grep -v 'WYKAZ PROGRAM' | grep -v ",,," | grep -v 'KOLEJNA EMISJA' | grep -v " / " > transcriptions_srt/Wiadomosci_$(date +%d.%m.%Y).srt
grep -E "[A-Za-z]" transcriptions_srt/Wiadomosci_$(date +%d.%m.%Y).srt | tr '\r\n' ' ' | tr -s \ > transcriptions_txt/Wiadomosci_$(date +%d.%m.%Y).txt
echo "* [Wiadomosci_$(date +%d.%m.%Y).srt](https://raw.githubusercontent.com/codziennatranskrypcjatvpis/codziennatranskrypcjatvpis.github.io/main/transcriptions_srt/Wiadomosci_$(date +%d.%m.%Y).srt)" | cat - README.md | sponge README.md
echo "* [Wiadomosci_$(date +%d.%m.%Y).txt](https://raw.githubusercontent.com/codziennatranskrypcjatvpis/codziennatranskrypcjatvpis.github.io/main/transcriptions_txt/Wiadomosci_$(date +%d.%m.%Y).txt)" | cat - README.md | sponge README.md
echo "Wiadomosci_$(date +%d.%m.%Y).txt~$(date +%Y-%m-%d)~$(cat transcriptions_txt/Wiadomosci_$(date +%d.%m.%Y).txt)" >> Wyszukiwarka/pliki
./push_to_git.sh
cd Wyszukiwarka && /var/lib/tvheadend/.volta/bin/node createTarball.mjs && ./copy_to_s3.sh
