#!/bin/bash
# usage:
# ./webp_crush.sh inputfile

# example:
# ./webp.sh mpv-shot0001.png

LC_NUMERIC=en_US.UTF-8


TMPFILE=$(mktemp)
trap "rm -f $TMPFILE" EXIT

cwebp "$1" -o "$1".ll.webp -lossless -z 1 -quiet
echo "$(du -b "$1".ll.webp) -z 1"

cwebp "$1" -o "$TMPFILE" -lossless -z 2 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 2"
fi

cwebp "$1" -o "$TMPFILE" -lossless -z 3 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 3"
fi

cwebp "$1" -o "$TMPFILE" -lossless -z 4 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 4"
fi

cwebp "$1" -o "$TMPFILE" -lossless -z 5 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 5"
fi

cwebp "$1" -o "$TMPFILE" -lossless -z 6 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 6"
fi

cwebp "$1" -o "$TMPFILE" -lossless -z 7 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 7"
fi

cwebp "$1" -o "$TMPFILE" -lossless -z 8 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 8"
fi

cwebp "$1" -o "$TMPFILE" -lossless -z 9 -quiet
if((`stat -c%s "$TMPFILE"`<`stat -c%s "$1.ll.webp"`));then
  mv $TMPFILE "$1".ll.webp
  echo "$(du -b "$1".ll.webp) -z 9"
fi
