References: <1493106641-16173-1-git-send-email-chipitsine@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0cf5a2d1-87a8-5121-8b9b-656aef58aacb@...515...>
Date: Tue, 25 Apr 2017 14:12:45 +0300
MIME-Version: 1.0
In-Reply-To: <1493106641-16173-1-git-send-email-chipitsine@...277...>
Content-Type: multipart/mixed; boundary="------------B77A96C4E9C96F74E2A23DC3"
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only"
 configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------B77A96C4E9C96F74E2A23DC3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


On 25/04/2017 10:50, Ilya Shipitsin wrote:
> Inspired by
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13
032.html
>
>=20
build options are taken from regular windows installer builds
>=20
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...> --- v2: moved
> download/build dependencies into functions, changed cross build=20
> detection from shell expansion ${CHOST+x} to more recognised -z
> "${CHOST}", which required changing 'set -eux' to 'set -ex'. Added
> comments to make code readable without looking into commit
> message.
>=20
> .travis.yml           |  35 +++++++++++++---- .travis/build-deps.sh
> | 101 +++++++++++++++++++++++++++++++++++++++++++++++--- 2 files
> changed, 123 insertions(+), 13 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml index 3c0aa7d..2f9fe4c
> 100644 --- a/.travis.yml +++ b/.travis.yml @@ -12,6 +12,9 @@ env:=20
> global: - JOBS=3D3 - PREFIX=3D"${HOME}/opt" +    -
> TAP_WINDOWS_VERSION=3D9.21.2 +    - LZO_VERSION=3D2.10 +    -
> PKCS11_HELPER_VERSION=3D1.11 - MBEDTLS_VERSION=3D"2.4.0" -
> MBEDTLS_CFLAGS=3D"-I${PREFIX}/include" -
> MBEDTLS_LIBS=3D"-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto" @@
> -50,6 +53,12 @@ matrix: os: osx osx_image: xcode7.3 compiler:
> clang +    - env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32 +
> os: linux +      compiler: ": Win64 build only" +    - env:
> SSLLIB=3D"openssl" CHOST=3Di686-w64-mingw32 +      os: linux +
> compiler: ": Win32 build only" exclude: - compiler: gcc
>=20
> @@ -60,6 +69,7 @@ addons: - libpam0g-dev - liblz4-dev -
> linux-libc-dev +      - man2html
>=20
> cache: ccache: true @@ -72,16 +82,27 @@ before_install: - if [
> "${TRAVIS_OS_NAME}" =3D "osx" ]; then brew install lzo; fi
>=20
> install: +  - if [ ! -z "${CHOST}" ]; then unset CC; fi -
> .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log
> && exit 1)
>=20
> script: - if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then export
> LD_LIBRARY_PATH=3D"${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi - if [
> "${TRAVIS_OS_NAME}" =3D "osx"   ]; then export
> DYLD_LIBRARY_PATH=3D"${PREFIX}/lib:${DYLD_LIBRARY_PATH}"; fi -
> autoreconf -vi -  - ./configure --with-crypto-library=3D"${SSLLIB}"
> ${EXTRA_CONFIG} || (cat config.log && exit 1) -  - make -j$JOBS -
> - src/openvpn/openvpn --version || true -  - if [
> "${TRAVIS_OS_NAME}" =3D "linux" ]; then ldd src/openvpn/openvpn; fi -
> - if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then otool -L
> src/openvpn/openvpn; fi -  - make check -  - $EXTRA_SCRIPT +  - if
> [ -z "${CHOST}" ]; then +      ./configure
> --with-crypto-library=3D"${SSLLIB}" ${EXTRA_CONFIG} || (cat
> config.log && exit 1); +      make -j$JOBS; +
> src/openvpn/openvpn --version || true; +      if [
> "${TRAVIS_OS_NAME}" =3D "linux" ]; then ldd src/openvpn/openvpn; fi;=20
> +      if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then otool -L
> src/openvpn/openvpn; fi; +      make check; +      $EXTRA_SCRIPT; +
> else +      export
> TAP_CFLAGS=3D"-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include"; +
> export LZO_CFLAGS=3D"-I${PREFIX}/include"; +      export
> LZO_LIBS=3D"-L${PREFIX}/lib -llzo2"; +      export
> PKCS11_HELPER_LIBS=3D"-L${PREFIX}/lib -lpkcs11-helper"; +      export
> PKCS11_HELPER_CFLAGS=3D"-I${PREFIX}/include"; +      ./configure
> --with-crypto-library=3D"${SSLLIB}" --host=3D${CHOST}
> --build=3Dx86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins ||
> (cat config.log && exit 1); +      make -j$JOBS; +    fi



> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh index
> 3ffba0b..2229bb7 100755 --- a/.travis/build-deps.sh +++
> b/.travis/build-deps.sh @@ -1,9 +1,58 @@ #!/bin/sh -set -eux +set
> -ex
>=20
> # Set defaults PREFIX=3D"${PREFIX:-${HOME}/opt}"
>=20
> +download_tap_windows () { +    if [ ! -f
> "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then +
> wget -P download-cache/ \ +
> "http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS
_VERSION}.zip"
>
>=20
+    fi
> +} + +download_lzo () { +    if [ ! -f
> "download-cache/lzo-${LZO_VERSION}.tar.gz" ]; then +        wget -P
> download-cache/ \ +
> "http://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.t
ar.gz"
>
>=20
+    fi
> +} + +build_lzo () { +    if [ "$(cat ${PREFIX}/.lzo-version)" !=3D
> "${LZO_VERSION}" ]; then +        tar zxf
> download-cache/lzo-${LZO_VERSION}.tar.gz +        ( +            cd
> "lzo-${LZO_VERSION}" + +            ./configure --host=3D${CHOST}
> --program-prefix=3D'' \ +                --libdir=3D${PREFIX}/lib
> --prefix=3D${PREFIX} --build=3Dx86_64-pc-linux-gnu +            make
> all install +        ) +        echo "${LZO_VERSION}" >
> "${PREFIX}/.lzo-version" +    fi +} + +download_pkcs11_helper () {=20
> +    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2" ];
> then +        wget -P download-cache/ \ +
> "http://downloads.sourceforge.net/project/opensc/pkcs11-helper/pkcs11-
helper-${PKCS11_HELPER_VERSION}.tar.bz2"
>
>=20
+    fi
> +} + +build_pkcs11_helper () { +    if [ "$(cat
> ${PREFIX}/.pkcs11_helper-version)" !=3D "${PKCS11_HELPER_VERSION}" ];
> then +        tar jxf
> download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2 +
> ( +            cd "pkcs11-helper-${PKCS11_HELPER_VERSION}" + +
> ./configure --host=3D${CHOST} --program-prefix=3D''
> --libdir=3D${PREFIX}/lib \ +                 --prefix=3D${PREFIX}
> --build=3Dx86_64-pc-linux-gnu --disable-crypto-engine-gnutls
> --disable-crypto-engine-nss +            make all install +
> ) +         echo "${PKCS11_HELPER_VERSION}" >
> "${PREFIX}/.pkcs11_helper-version" +    fi +} + download_mbedtls ()
> { if [ ! -f "download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz"
> ]; then wget -P download-cache/ \ @@ -31,7 +80,6 @@
> download_openssl () { }
>=20
> build_openssl_linux () { -    tar zxf
> "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" ( cd
> "openssl-${OPENSSL_VERSION}/" ./config shared
> --openssldir=3D"${PREFIX}" -DPURIFY @@ -40,7 +88,6 @@
> build_openssl_linux () { }
>=20
> build_openssl_osx () { -    tar zxf
> "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" ( cd
> "openssl-${OPENSSL_VERSION}/" ./Configure darwin64-x86_64-cc shared
> \ @@ -49,9 +96,28 @@ build_openssl_osx () { ) }
>=20
> +build_openssl_mingw () { +    ( +        cd
> "openssl-${OPENSSL_VERSION}/" + +        if [ "${CHOST}" =3D
> "i686-w64-mingw32" ]; then +            export TARGET=3Dmingw +
> elif [ "${CHOST}" =3D "x86_64-w64-mingw32" ]; then +
> export TARGET=3Dmingw64 +        fi + +        ./Configure
> --cross-compile-prefix=3D${CHOST}- shared \ +           ${TARGET}
> no-multilib no-capieng --openssldir=3D"${PREFIX}" -static-libgcc +
> make install +    ) +} + build_openssl () { if [ "$(cat
> ${PREFIX}/.openssl-version)" !=3D "${OPENSSL_VERSION}" ]; then -
> if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then +        tar zxf
> "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" +        if [ !
> -z "${CHOST}" ]; then +            build_openssl_mingw +
> elif [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then build_openssl_osx elif [
> "${TRAVIS_OS_NAME}" =3D "linux" ]; then build_openssl_linux @@ -61,16
> +127,26 @@ build_openssl () { }
>=20
> # Enable ccache -if [ "${TRAVIS_OS_NAME}" !=3D "osx" ]; then +if [
> "${TRAVIS_OS_NAME}" !=3D "osx" ] && [ -z "${CHOST}" ]; then # ccache
> not available on osx, see: #
> https://github.com/travis-ci/travis-ci/issues/5567 +    # also
> ccache not enabled for cross builds mkdir -p "${HOME}/bin" ln -s
> "$(which ccache)" "${HOME}/bin/${CC}" PATH=3D"${HOME}/bin:${PATH}"=20
> fi
>=20
> +if [ ! -z "${CHOST}" ]; then +      # +      # openvpn requires at
> least mingw-gcc-4.9, which is available at xenial repo +      # +
> echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" |
> sudo tee -a /etc/apt/sources.list.d/xenial.list +      echo "deb
> http://archive.ubuntu.com/ubuntu xenial main" | sudo tee -a
> /etc/apt/sources.list.d/xenial.list +      sudo apt-get update +
> sudo apt-get -y install dpkg mingw-w64 +fi + # Download and build
> crypto lib -mkdir -p download-cache if [ "${SSLLIB}" =3D "openssl" ];
> then download_openssl build_openssl @@ -81,3 +157,16 @@ else echo
> "Invalid crypto lib: ${SSLLIB}" exit 1 fi + +# Download and build
> dependencies for mingw cross build +# dependencies are the same as
> in regular windows installer build +if [ ! -z "${CHOST}" ]; then +
> download_tap_windows +      unzip
> download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip + +
> download_lzo +      build_lzo + +      download_pkcs11_helper +
> build_pkcs11_helper +fi
>=20

Hi,

Looks much better than the previous patch, thanks! I believe all the
issues identified in the previous patch version[1] have been resolved,
namely:

- - Build/download code is now split into clean functions
- - Variables are now referenced using a consistent style

Travis seems to be happy with the changes also[2].

The only minor complaint is trailing whitespace on two lines:

$ git am <patch>
Applying: travis-ci: add 2 mingw "build only" configurations
/home/samuli/opt/openvpn/.git/rebase-apply/patch:169: trailing whitespac
e.
        if [ "${CHOST}" =3D "i686-w64-mingw32" ]; then
/home/samuli/opt/openvpn/.git/rebase-apply/patch:177: trailing whitespac
e.
        make install
warning: 2 lines add whitespace errors.


ACK on the condition that trailing whitespace is fixed. That can be
easily done at commit time by the repository maintainer, if he's willing
.

- --=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1]
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg143
06.html>
[2] <https://travis-ci.org/chipitsine/openvpn/builds/225505133>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY/y8tAAoJEClYTZ9AhkV4dJkH/1x1Fy5QRGpa6K2GRkAgQvUN
8J4H4CFg1e4xVO2hW5x1RFmsRyqFcMArxpekTwOdgKEJ+QZufhOXXE+bkkEbiytQ
MHWLTlWu15pA3zKaMlzoErQBIJjgP0LXaBp47mu9jVSLWYkA5ae8XoHzBsVc8kno
XyG2s+Dk9GzFRrpIpqwiharCqY/3E3+7+sEXOUbZ226mmktVIStcxeukbZyBakc+
oSLz4I3gwVfE3bTv14vJg0aONpdOK3d2SETIO/Gs+OxdJ6ntsLNkKdeVqYwgvq2Q
S1ZL7M2QPLDGwdqLbxkegSKJ3JOoBhTxYAlE2o/teM9teucgFCfnaZYJz8u/NtY=3D
=3DFJlW
-----END PGP SIGNATURE-----

--------------B77A96C4E9C96F74E2A23DC3
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------B77A96C4E9C96F74E2A23DC3--

