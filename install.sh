sudo apt-get update

sudo apt-get install -y git python3-pip curl python-is-python3 python3-full cmake ca-certificates gnupg unzip tar

sudo mkdir -p /etc/apt/keyrings 

curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs -y

cd /home/$USER

wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 	

tar -xvf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2

rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2

wget https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/nRF5_SDK_15.3.0_59ac345.zip

unzip nRF5_SDK_15.3.0_59ac345.zip 

rm nRF5_SDK_15.3.0_59ac345.zip

git clone https://github.com/adafruit/Adafruit_nRF52_nrfutil.git 
cd /home/$USER/Adafruit_nRF52_nrfutil
pip3 install -r requirements.txt

sudo python3 setup.py install

cd /home/$USER

git clone https://github.com/InfiniTimeOrg/InfiniTime.git  
cd /home/$USER/InfiniTime
git submodule update --init
mkdir build
python -m pip install wheel
python -m pip install -r tools/mcuboot/requirements.txt

npm install lv_font_conv@1.5.2			
npm install lv_img_conv@0.4.0
npm i @swc/core@1.3.39
npm i nimble
 
cmake -DARM_NONE_EABI_TOOLCHAIN_PATH=/$HOME/gcc-arm-none-eabi-10.3-2021.10 -DNRF5_SDK_PATH=/$HOME/nRF5_SDK_15.3.0_59ac345 -DBUILD_RESOURCES=1 -DBUILD_DFU=1 
make -j4 pinetime-mcuboot-app 
