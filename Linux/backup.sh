mkdir /tmp/meow
cp -rp /etc /tmp/meow/etc
cp -rp /root /tmp/meow/root
cp -rp /home /tmp/meow/home
cp -rp /var /tmp/meow/var
cp -rp /usr /tmp/meow/usr
cp -rp /opt /tmp/meow/opt

tar -zcf /opt/re.tar.gz /tmp/meow
rm -rf /tmp/meow
