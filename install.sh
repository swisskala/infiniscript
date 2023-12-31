sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y git python3-pip python3-pil curl python-is-python3 cmake npm ca-certificates gnupg unzip tar

cd $HOME

GREEN='\033[0;32m'
RESET='\033[0m' # Reset text formatting and color

# Check for the existence of gcc-arm-none-eabi folder
if [ ! -d "gcc-arm-none-eabi-10.3-2021.10" ]; then
    wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
    tar -xvf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
    rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
else
    echo -e "${GREEN}gcc-arm-none-eabi-10.3-2021.10 folder already exists, skipping download and extraction.${RESET}"
fi

cd $HOME

# Check for the existence of nRF5_SDK folder
if [ ! -d "nRF5_SDK_15.3.0_59ac345" ]; then
    wget https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/nRF5_SDK_15.3.0_59ac345.zip
    unzip nRF5_SDK_15.3.0_59ac345.zip
    rm nRF5_SDK_15.3.0_59ac345.zip
else
    echo -e "${GREEN}nRF5_SDK_15.3.0_59ac345 folder already exists, skipping download and extraction.${RESET}"
fi

cd $HOME

# Check for the existence of Adafruit_nRF52_nrfutil repository
if [ ! -d "$HOME/Adafruit_nRF52_nrfutil" ]; then
    git clone https://github.com/adafruit/Adafruit_nRF52_nrfutil.git 
    cd $HOME/Adafruit_nRF52_nrfutil
    sudo python3 -m pip install -r requirements.txt
    sudo pip3 install adafruit-nrfutil
else
    echo "Adafruit_nRF52_nrfutil repository already exists, skipping clone."
    cd $HOME
fi

cd $HOME

git clone https://github.com/InfiniTimeOrg/InfiniTime.git  
cd $HOME/InfiniTime
git submodule update --init
mkdir build
python -m pip install wheel
python -m pip install -r tools/mcuboot/requirements.txt

npm install lv_font_conv@1.5.2			
npm i @swc/core@1.3.39
npm i nimble
 
cmake -DARM_NONE_EABI_TOOLCHAIN_PATH=/$HOME/gcc-arm-none-eabi-10.3-2021.10 -DNRF5_SDK_PATH=/$HOME/nRF5_SDK_15.3.0_59ac345 -DBUILD_RESOURCES=1 -DBUILD_DFU=1 
make -j4 pinetime-mcuboot-app 
