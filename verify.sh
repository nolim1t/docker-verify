#!/bin/bash


# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

check_dependencies () {
  for cmd in "$@"; do
    if ! command -v $cmd >/dev/null 2>&1; then
      echo "This script requires \"${cmd}\" to be installed"
      exit 1
    fi
done
}

check_dependencies sha256sum getopts gpg

while getopts f:h flag
do
    case "${flag}" in
        f) FILENAME=${OPTARG};;
        h)
            echo "Usage: "
            echo "      verify.sh -h                Displays this help message"
            echo "      verify.sh -f <filename>     Checks sha256sum of a file"
            exit 0
            ;;
        \?)
            echo "Invalid option. Try -h for options"
            exit 1
            ;;
        :)
            echo "Invalid Option: -$OPTARG requires an argument" 1>&2
            exit 1
            ;;
    esac
done
if [ -z $FILENAME ]; then
    echo "Error: Must specify a filename with the -f flag"
    exit 1
fi

if [ ! -f $FILENAME ]; then
	echo "Filename ${FILENAME} does not exist!"
	exit 1
fi

SHA256SUM=$(cat $FILENAME | sha256sum | awk '{print $1}')
SHA256SUMFILE=$(cat "${FILENAME}.sha256" | awk '{print $1}')
# 64-bit key ID (You can get it from gpg --keyid-format LONG --list-keys)
# Defaults to my key
GPGKEY="${GPGKEY:-F6287B82CC84BCBD}"

gpg --keyserver keyserver.ubuntu.com --recv-key $GPGKEY

if [ $SHA256SUM == $SHA256SUMFILE ]; then
    echo "SHA256sums match OK"
    # Do PGP verify
    # gpg --armor --output test.txt.sha256.asc --detach-sig test.txt.sha256
    if [ -f $(echo "${FILENAME}.sha256.asc") ]; then
        gpg --verify ${FILENAME}.sha256.asc
        exit 0
    else
        echo "GPG signed sha256 file does not exist. Expected ${FILENAME}.sha256.asc signed by ${GPGKEY}"
        exit 1
    fi
else
    echo "Not ok"
    echo "Filename Hash ${SHA256SUM} but got ${SHA256SUMFILE} for the hash file. Please check"
    exit 1
fi

