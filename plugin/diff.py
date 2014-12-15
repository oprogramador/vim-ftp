import sys
a = sys.argv[1]
b = sys.argv[2]
i = 0
while i<len(a) and i<len(b):
    if a[i] != b[i]:
        break
    i += 1
print b[i:]
