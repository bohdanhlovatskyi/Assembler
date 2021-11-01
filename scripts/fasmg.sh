#/bin/zsh

export INCLUDE=.
file_path=$1
echo "Compiling..."
echo $file_path

fasmg $file_path
ex=${file_path%".asm"}
echo "Done! Executable name:"
echo $ex
chmod +x "$ex"