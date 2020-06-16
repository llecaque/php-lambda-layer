#!/bin/bash -e

echo "Building layer for PHP 7.3 - using official repository"

yum install -y php73 php73-mbstring php73-pdo php73-mysql php73-pgsql php73-xml php73-process

mkdir /tmp/layer
cd /tmp/layer
cp /opt/layer/bootstrap bootstrap
sed "s/PHP_MINOR_VERSION/3/g" /opt/layer/php.ini >php.ini

mkdir bin
cp /usr/bin/php bin/

mkdir lib
for lib in libncurses.so.5 libtinfo.so.5 libpcre.so.0; do
  cp "/lib64/${lib}" lib/
done

cp /usr/lib64/libedit.so.0 lib/
# cp /usr/lib64/libargon2.so.0 lib/
cp /usr/lib64/libpq.so.5 lib/
# cp /usr/lib64/libonig.so.5 lib/

mkdir -p lib/php/7.3
cp -a /usr/lib64/php/7.3/modules lib/php/7.3/

zip -r /opt/layer/php73.zip .

