#!/bin/sh
# Make a copy of the BioNLP dataset without the 'Title' and 'Paragraph'
# annotations
#
# Assuming the annotator is installed at "~/brat-pages", you can run this
# script from anywhere
#
# After running this script, execute the 'fix_nbsp_linebreaks.py' to fix
# the problematic chars on the dataset.
#
# Don't forget to run the 'fix-permissions.sh' after this one
[ -d ~/brat-pages/data/BioNLP-2019_ssplit ] || cp -r ~/brat-pages/data/BioNLP-2019 ~/brat-pages/data/BioNLP-2019_ssplit
find ~/brat-pages/data/BioNLP-2019_ssplit -type f -name '*.ann' -exec sed -i -e '/^T[0-9][0-9]*\tTitle.*$/d' -e '/^T[0-9][0-9]*\tParagraph.*$/d' {} \;
