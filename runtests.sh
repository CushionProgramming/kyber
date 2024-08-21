#!/bin/sh -e
nproc="${nproc:-2}"

ARCH="${ARCH:-amd64}"
ARCH="${TRAVIS_CPU_ARCH:-$ARCH}"

if [ "$ARCH" = "amd64" -a "$TRAVIS_OS_NAME" != "osx" ]; then
  DIRS="ref avx2"
else
  DIRS="ref"
fi

if [ "$ARCH" = "amd64" -o "$ARCH" = "arm64" ]; then
<<<<<<< HEAD
  export CC="clang"
#  export CFLAGS="-fsanitize=address,undefined ${CFLAGS}"
=======
  export CC=/usr/bin/gcc
#  export CFLAGS="-fsanitize=undefined,address ${CFLAGS}"
>>>>>>> standard
fi

for dir in $DIRS; do
  make -j$(nproc) -C $dir clean
  make -j$(nproc) -C $dir
<<<<<<< HEAD
  for alg in 512 768 1024 512-90s 768-90s 1024-90s; do
    valgrind --vex-guest-max-insns=25 ./$dir/test_kyber$alg
    ./$dir/test_kyber$alg &
    PID1=$!
    ./$dir/test_kex$alg &
    PID2=$!
    ./$dir/test_vectors$alg > tvecs$alg &
    PID3=$!
    wait $PID1 $PID2 $PID3
=======
  for alg in 512 768 1024; do
    valgrind --vex-guest-max-insns=25 ./$dir/test/test_kyber$alg
    echo test_kyber$alg
    ./$dir/test/test_kyber$alg 
#    PID1=$!
#    echo testvec$alg
    ./$dir/test/test_vectors$alg > tvecs$alg 
#    PID2=$!
#    wait $PID1 $PID2
>>>>>>> standard
  done
  shasum -a256 -c SHA256SUMS
done

exit 0
