#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''Just a simple script to fix nbsp's and linebreaks on the dataset'''
from argparse import ArgumentParser
import os
import re


def has_ext(fname):
    '''Check if the argument is a text or annotation file'''
    return fname.endswith(('.txt', 'a1', 'a2', 'ann'))


def main(target_dir):
    if target_dir is None:
        working_dir = './'
    else:
        working_dir = target_dir

    for fname in filter(has_ext, os.listdir(working_dir)):
        fpath = os.path.join(working_dir, fname)

        with open(fpath) as fd:
            text = fd.read()

        if re.fullmatch(r'BB-rel-F-\d+-\d\d\d.txt', fname) is not None:
            print(f'REPLACING NEWLINEWS ON "{fname}"')
            text = text.strip()
            text = text.replace('\n', ' ')

            with open(fpath, 'w') as fd:
                fd.write(text + '\n')

        elif '\xa0' in text:
            print(f'THE FILE "{fname}" CONTAINS NBSP, FIXING')
            text = text.replace('\xa0', ' ')

            with open(fpath, 'w') as fd:
                fd.write(text)

    print('DONE!')


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--target-dir', type=str, default=None,
                        help="The files' root directory path")

    args = parser.parse_args()
    main(args.target_dir)
