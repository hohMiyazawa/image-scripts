#!/bin/bash
# usage:
# ./jxl_crush.sh inputfile

# example:
# ./jxl_crush.sh mpv-shot0001.png

LC_NUMERIC=en_US.UTF-8

if [ "$2" = "--strip" ]; then
  echo "metadata not preserved due to '--strip'"
else
  echo "metadata preserved by default. Add '--strip' to remove"
fi
echo "crunching... ctrl-c to stop at any time"

TMPFILE=$(mktemp)
trap "rm -f $TMPFILE" EXIT

cjxl "$1" "$1".ll.jxl --quiet -q 100 -s 1 $2
echo "$(du -b "$1".ll.jxl) -s 1"

cjxl "$1" $TMPFILE --quiet -q 100 -s 2 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 2"
fi

cjxl "$1" $TMPFILE --quiet -q 100 -s 3 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 3"
fi

cjxl "$1" $TMPFILE --quiet -q 100 -s 4 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 4"
fi

cjxl "$1" $TMPFILE --quiet -q 100 -s 5 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 5"
fi

cjxl "$1" $TMPFILE --quiet -q 100 -s 6 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 6"
fi

cjxl "$1" $TMPFILE --quiet -q 100 -s 7 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 7"
fi

cjxl "$1" $TMPFILE --quiet -q 100 -s 8 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 8"
fi

GVALUE=2
cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I 1 -g $GVALUE $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I 1 -g $GVALUE"
fi

cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I 1 -g 0 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  GVALUE=0
  echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I 1 -g 0"
fi
cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I 1 -g 1 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  GVALUE=1
  echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I 1 -g 1"
fi
cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I 1 -g 3 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  GVALUE=3
  echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I 1 -g 3"
fi

USEPATCHES=""
cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I 1 -g $GVALUE --patches=0 $2
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
  mv $TMPFILE "$1".ll.jxl
  USEPATCHES="--patches=0"
  echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I 1 -g $GVALUE --patches=0"
fi

USEP=""
for i in {0..13}
do
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I 1 -g $GVALUE $USEPATCHES -P $i $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    USEP="-P $i"
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I 1 -g $GVALUE $USEPATCHES $USEP"
  fi
done

IVALUE=1
for x in {00..99..10}; do
  i=`bc <<< "scale=2; $x/100"`
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    IVALUE=$i
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP"
  fi
done
for x in {01..99..2}; do
  i=`bc <<< "scale=2; $x/100"`
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    IVALUE=$i
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP"
  fi
done
for x in {00..99..2}; do
  i=`bc <<< "scale=2; $x/100"`
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    IVALUE=$i
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP"
  fi
done
if [ "$USEPATCHES" = "--patches=0" ]; then
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I $IVALUE -g $GVALUE --patches=1 $USEP $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    USEPATCHES="--patches=1"
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I $IVALUE -g $GVALUE $USEPATCHES $USEP"
  fi
else
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I $IVALUE -g $GVALUE --patches=0 $USEP $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    USEPATCHES="--patches=0"
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I $IVALUE -g $GVALUE $USEPATCHES $USEP"
  fi
fi

for i in $(seq $(echo "$IVALUE - 0.05" | bc) 0.001 $(echo "$IVALUE + 0.05" | bc)); do
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    IVALUE=$i
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP"
  fi
done

for i in $(seq $(echo "$IVALUE - 0.005" | bc) 0.0001 $(echo "$IVALUE + 0.005" | bc)); do
  cjxl "$1" $TMPFILE --quiet -q 100 -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP $2
  if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.jxl"`));then
    mv $TMPFILE "$1".ll.jxl
    IVALUE=$i
    echo "$(du -b "$1".ll.jxl) -s 9 -E 3 -I $i -g $GVALUE $USEPATCHES $USEP"
  fi
done

