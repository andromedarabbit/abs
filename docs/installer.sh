command -v uname >/dev/null || {
  echo >&2 'requires uname'
  exit 1
}

OS="linux"

if [ "${OSTYPE:0:6}" = "darwin" ]; then
  OS="darwin"
elif [ "${OSTYPE:0:6}" = "cygwin" ]; then
  OS="windows"
elif [ "${OSTYPE:0:5}" = "win32" ]; then
  OS="windows"
elif [ "${OSTYPE:0:4}" = "msys" ]; then
  OS="windows"
elif [ "${OSTYPE:0:7}" = "freebsd" ]; then
  OS="freebsd"
else
  OS=$(uname -s | tr '[:upper:]' '[:lower:]')
fi

ARCH="386"
MACHINE_TYPE=$(uname -m)
if [ "${MACHINE_TYPE}" = 'x86_64' ]; then
  ARCH="amd64"
fi

echo "Trying to detect the details of your architecture."
echo ""
echo "If these don't seem correct, head over to https://github.com/abs-lang/abs/releases"
echo "and download the right binary for your architecture."
echo ""
echo "OS: ${OS}"
echo "ARCH: ${ARCH}"
echo ""
echo "Are these correct? [y/N]"

while read line
do
  INPUT=$(echo ${line} | awk '{print toupper($0)}')
  if [ "${INPUT}" = "Y" ]; then
    break
  fi
  echo Installation interrupted
  exit 1
done < "/dev/stdin"

VERSION=preview-4
BIN=abs-${VERSION}-${OS}-${ARCH}
wget https://github.com/abs-lang/abs/releases/download/${VERSION}/${BIN}
mv ${BIN} ./abs
chmod +x ./abs
echo "\n"
echo "ABS installation completed!\n"
echo "You can start hacking by './abs script.abs'"
echo "We recommend moving ABS into your \${PATH} so that you can do 'abs ./script.abs' from any location.\n"
echo "If you just want to have a look around, run './abs' and you will enter the REPL."
