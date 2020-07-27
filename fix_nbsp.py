#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Just a simple script to replace non-breaking whitespaces in data
from argparse import ArgumentParser
import os


def has_ext(fname):
    '''Check if the argument is a text or annotation file'''
    return fname.endswith(('.txt', 'ann'))


def main(target_dir):
    if target_dir is None:
        working_dir = './'
    else:
        working_dir = target_dir

    for fname in filter(has_ext, os.listdir(working_dir)):
        fpath = os.path.join(working_dir, fname)

        with open(fpath) as fd:
            text = fd.read()

        if '\xa0' in text:
            print(f'THE FILE "{fname}" CONTAINS NBSP, FIXING IT...')
            text = text.replace('\xa0', ' ')
            with open(fpath, 'w') as fd:
                fd.write(text)

    print('DONE!')


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--target-dir', type=str, default=None,
                        help="The directory to fix npsp's")

    args = parser.parse_args()
    main(args.target_dir)
