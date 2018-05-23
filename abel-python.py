# -*- coding: utf-8 -*-
"""
Created on Sun Dec 10 13:24:46 2017

"""

import sys, time
from collections import Counter

def abel(seq):
    
    pool = []
    for n in range(1, len(seq)+1):
        tmp = []
        for i in range(len(seq)-n+1):
            if (i==0) or (n<4):
                sub = seq[i:i+n]
                count = Counter(sub)
            else:
                count.subtract(seq[i-1])
                count.update(seq[i+n-1])
            Id = (count['A'],count['T'],count['C'],count['G'])
            tmp.append(Id)
        Set = set(tmp)
        pool.append(len(Set))
    
    return pool

def read_and_write(infile, outfile):
    
    with open(outfile, 'wb') as output:
        with open(infile, 'rb') as source:
            for line in source:
                parse = line.rstrip()
                if parse and (not parse.startswith('>')):
                    Ids = abel(parse)
                    output.write('\t'.join(map(str, Ids))+'\n')

if __name__ == '__main__':
    
    # start = time.time()
    infile = sys.argv[1]
    outfile = sys.argv[2]
    read_and_write(infile, outfile)
    # elapse = time.time() - start
    #print 'Time elapsed: %s' % elapse
