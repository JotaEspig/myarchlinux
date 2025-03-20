pwd=$(pwd)
myarchlinuxdir=$(dirname `readlink -f $0`)
cd $myarchlinuxdir # Ensure we are in the correct directory
cp ~/.zshrc .
cd $pwd
