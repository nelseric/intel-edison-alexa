#! /bin/bash

apt-get update
apt-get install  libasound2-dev memcached python-pip mpg123 python-alsaaudio
pip install -r requirements.txt
cp initd_alexa.sh /etc/init.d/alexa
cd /etc/rc5.d
ln -s ../init.d/alexa S99alexa
touch /var/log/alexa.log

#Install MRAA library from Intel GitHub
#echo "Installing other dependencies"
#apt-get install swig

echo "Installing MRAA"
#git clone https://github.com/intel-iot-devkit/mraa.git
#mkdir mraa/build && cd $_
#cmake .. -DBUILDSWIGNODE=OFF
#make
#make install
#cd
echo "MRAA install DONE"

echo "Enter your ProductID:"
read productid
echo ProductID = \"$productid\" >> creds.py

echo "Enter your Security Profile Description:"
read spd
echo Security_Profile_Description = \"$spd\" >> creds.py

echo "Enter your Security Profile ID:"
read spid
echo Security_Profile_ID = \"$spid\" >> creds.py

echo "Enter your Security Client ID:"
read cid
echo Client_ID = \"$cid\" >> creds.py

echo "Enter your Security Client Secret:"
read secret
echo Client_Secret = \"$secret\" >> creds.py

ip = `ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`
python ./auth_web.py 
echo "Open http://$ip:5000"

echo "You can now reboot"

