Message-ID: <b6c9abb2-6fa9-d8ab-89a7-a8b06cc4408b@...2181...>
Date: Thu, 19 May 2022 13:08:21 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220519093153.18944-1-a@...2181...>
 <20220519093153.18944-5-a@...2181...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220519093153.18944-5-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 5/5] Add support for GitLab CI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

please ignore this patch - it was sent by accident.

Regards,

On 19/05/2022 11:31, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>   .gitlab-ci.yml         | 182 +++++++++++++++++++++++++++++++++++++++++
>   .gitlab/build-check.sh |  23 ++++++
>   .gitlab/build-deps.sh  | 157 +++++++++++++++++++++++++++++++++++
>   3 files changed, 362 insertions(+)
>   create mode 100644 .gitlab-ci.yml
>   create mode 100755 .gitlab/build-check.sh
>   create mode 100755 .gitlab/build-deps.sh
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 00000000..fe25eb48
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,182 @@
> +stages:
> +  - test
> +
> +variables:
> +  JOBS: 3
> +  PREFIX: ${CI_PROJECT_DIR}/builds
> +  TAP_WINDOWS_VERSION: 9.24.6
> +  LZO_VERSION: "2.10"
> +  PKCS11_HELPER_VERSION: "1.22"
> +  MBEDTLS_VERSION: "2.26.0"
> +  MBEDTLS_CFLAGS: -I${CI_PROJECT_DIR}/builds/include
> +  MBEDTLS_LIBS: -L${CI_PROJECT_DIR}/builds/lib -lmbedtls -lmbedx509 -lmbedcrypto
> +  OPENSSL_VERSION: 1.1.1m
> +  OPENSSL_CFLAGS: -I${CI_PROJECT_DIR}/builds/include
> +  OPENSSL_LIBS: -L${CI_PROJECT_DIR}/builds/lib -lssl -lcrypto
> +  SSLLIB: "openssl"
> +
> +default:
> +  image: gcc:latest
> +
> +  before_script:
> +    - apt-get update -qq && apt-get install -y -qq liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html build-essential python
> +    - .gitlab/build-deps.sh
> +
> +  cache:
> +    key: ${CI_JOB_NAME}
> +    paths:
> +      - download-cache/
> +      - ${PREFIX}/
> +
> +dco:
> +  variables:
> +    EXTRA_CONFIG: "--enable-dco"
> +  before_script:
> +    - apt-get update -qq && apt-get install -y -qq liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html build-essential python libnl-genl-3-dev
> +    - .gitlab/build-deps.sh
> +  script:
> +    - .gitlab/build-check.sh
> +
> +mtls-latest:
> +  variables:
> +    SSLLIB: "mbedtls"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +mtls-2_16_11:
> +  variables:
> +    MBEDTLS_VERSION: "2.16.11"
> +    SSLLIB: "mbedtls"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +mtls-2_7_19:
> +  variables:
> +    MBEDTLS_VERSION: "2.7.19"
> +    SSLLIB: "mbedtls"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl:
> +  variables:
> +    SSLLIB: "openssl"
> +    EXTRA_SCRIPT: "make distcheck"
> +  artifacts:
> +    paths:
> +      - src/openvpn/openvpn
> +  before_script:
> +    - apt-get update -qq && apt-get install -y -qq liblzo2-dev libpam0g-dev liblz4-dev build-essential unzip python3-docutils libssl-dev
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-gcc9:
> +  image: gcc:9
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-fedora-latest:
> +  image: fedora:latest
> +  before_script:
> +    - yum -y install libtool openssl-devel lzo-devel pam-devel lz4-devel man2html python gcc make autoconf automake wget
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-rockylinux-latest:
> +  image: rockylinux:latest
> +  before_script:
> +    - yum -y install epel-release
> +    - yum -y install libtool openssl-devel lzo-devel pam-devel lz4-devel man2html python39 gcc make autoconf automake wget
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-1_1_0:
> +  variables:
> +    OPENSSL_VERSION: "1.1.0l"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-1_0_2:
> +  variables:
> +    OPENSSL_VERSION: "1.0.2u"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +
> +#ossl-sanitizeaddr:
> +#  variables:
> +#    CFLAGS: "-fsanitize=address"
> +#  script:
> +#    - .gitlab/build-check.sh
> +
> +ossl-sanitizeleak:
> +  variables:
> +    CFLAGS: "-fsanitize=leak"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-sanitizeundef:
> +  variables:
> +    CFLAGS: "-fsanitize=undefined"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-win64:
> +  variables:
> +    CHOST: "x86_64-w64-mingw32"
> +    EXTRA_CONFIG: "--disable-lz4"
> +  artifacts:
> +    paths:
> +      - src/openvpn/openvpn.exe
> +    name: "openvpn_win64-${CI_COMMIT_REF_SLUG}"
> +  before_script:
> +    - apt-get update -qq && apt-get install -y -qq liblzo2-dev libpam0g-dev build-essential mingw-w64 unzip man2html
> +    - .gitlab/build-deps.sh
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-win32:
> +  variables:
> +    CHOST: "i686-w64-mingw32"
> +    EXTRA_CONFIG: "--disable-lz4"
> +  before_script:
> +    - apt-get update -qq && apt-get install -y -qq liblzo2-dev libpam0g-dev build-essential mingw-w64 unzip man2html
> +    - .gitlab/build-deps.sh
> +  script:
> +    - .gitlab/build-check.sh
> +
> +mtls-iproute2:
> +  variables:
> +    SSLLIB: "mbedtls"
> +    EXTRA_CONFIG: "--enable-iproute2"
> +  before_script:
> +    - apt-get update -qq && apt-get install -y -qq liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html build-essential iproute2 python
> +    - .gitlab/build-deps.sh
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-nolzo:
> +  before_script:
> +    - apt-get update -qq && apt-get install -y -qq libpam0g-dev liblz4-dev build-essential unzip
> +    - .gitlab/build-deps.sh
> +  variables:
> +    EXTRA_CONFIG: "--disable-lzo"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-small:
> +  variables:
> +    EXTRA_CONFIG: "--enable-small"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-asyncpush:
> +  variables:
> +    EXTRA_CONFIG: "--enable-async-push"
> +  script:
> +    - .gitlab/build-check.sh
> +
> +ossl-no-mgmt:
> +  variables:
> +    EXTRA_CONFIG: "--disable-management"
> +  script:
> +    - .gitlab/build-check.sh
> diff --git a/.gitlab/build-check.sh b/.gitlab/build-check.sh
> new file mode 100755
> index 00000000..7ecb4255
> --- /dev/null
> +++ b/.gitlab/build-check.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +set -eux
> +
> +export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
> +
> +autoreconf -vi
> +
> +if [ -z ${CHOST+x} ]; then
> +	./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG:-} || (cat config.log && exit 1)
> +	make -j$JOBS
> +	src/openvpn/openvpn --version || true
> +	ldd src/openvpn/openvpn
> +	make check
> +	${EXTRA_SCRIPT:-}
> +else
> +	export TAP_CFLAGS="-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include"
> +	export LZO_CFLAGS="-I${PREFIX}/include"
> +	export LZO_LIBS="-L${PREFIX}/lib -llzo2"
> +	export PKCS11_HELPER_LIBS="-L${PREFIX}/lib -lpkcs11-helper"
> +	export PKCS11_HELPER_CFLAGS="-I${PREFIX}/include"
> +	./configure --with-crypto-library="${SSLLIB}" --host=${CHOST} --build=x86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins ${EXTRA_CONFIG:-} || (cat config.log && exit 1)
> +	make -j${JOBS}
> +fi
> diff --git a/.gitlab/build-deps.sh b/.gitlab/build-deps.sh
> new file mode 100755
> index 00000000..d92158be
> --- /dev/null
> +++ b/.gitlab/build-deps.sh
> @@ -0,0 +1,157 @@
> +#!/bin/sh
> +set -eux
> +
> +# Set defaults
> +PREFIX="${PREFIX:-${HOME}/opt}"
> +
> +download_tap_windows () {
> +    if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then
> +       wget -P download-cache/ \
> +           "http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
> +    fi
> +}
> +
> +download_lzo () {
> +    if [ ! -f "download-cache/lzo-${LZO_VERSION}.tar.gz" ]; then
> +        wget -P download-cache/ \
> +            "http://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
> +    fi
> +}
> +
> +build_lzo () {
> +    if [ "$(cat ${PREFIX}/.lzo-version)" != "${LZO_VERSION}" ]; then
> +        tar zxf download-cache/lzo-${LZO_VERSION}.tar.gz
> +        (
> +            cd "lzo-${LZO_VERSION}"
> +
> +            ./configure --host=${CHOST} --program-prefix='' \
> +                --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
> +            make all install
> +        )
> +        echo "${LZO_VERSION}" > "${PREFIX}/.lzo-version"
> +    fi
> +}
> +
> +download_pkcs11_helper () {
> +    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2" ]; then
> +        wget -P download-cache/ \
> +            "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
> +    fi
> +}
> +
> +build_pkcs11_helper () {
> +    if [ "$(cat ${PREFIX}/.pkcs11_helper-version)" != "${PKCS11_HELPER_VERSION}" ]; then
> +        tar jxf download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
> +        (
> +            cd "pkcs11-helper-${PKCS11_HELPER_VERSION}"
> +
> +            ./configure --host=${CHOST} --program-prefix='' --libdir=${PREFIX}/lib \
> +                 --prefix=${PREFIX} --build=x86_64-pc-linux-gnu \
> +                 --disable-crypto-engine-gnutls \
> +                 --disable-crypto-engine-nss \
> +                 --disable-crypto-engine-polarssl \
> +                 --disable-crypto-engine-mbedtls
> +            make all install
> +         )
> +         echo "${PKCS11_HELPER_VERSION}" > "${PREFIX}/.pkcs11_helper-version"
> +    fi
> +}
> +
> +download_mbedtls () {
> +    if [ ! -f "download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz" ]; then
> +	    wget "https://github.com/ARMmbed/mbedtls/archive/refs/tags/v${MBEDTLS_VERSION}.tar.gz" \
> +	    -O download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
> +    fi
> +}
> +
> +build_mbedtls () {
> +    if [ "$(cat ${PREFIX}/.mbedtls-version)" != "${MBEDTLS_VERSION}" ]; then
> +        tar zxf download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
> +        (
> +            cd "mbedtls-${MBEDTLS_VERSION}"
> +            make
> +            make install DESTDIR="${PREFIX}"
> +        )
> +	echo "${MBEDTLS_VERSION}" > "${PREFIX}/.mbedtls-version"
> +    fi
> +}
> +
> +download_openssl () {
> +    if [ ! -f "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" ]; then
> +        wget -P download-cache/ \
> +            "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
> +    fi
> +}
> +
> +build_openssl_linux () {
> +    (
> +        cd "openssl-${OPENSSL_VERSION}/"
> +        ./config shared --prefix="${PREFIX}" --openssldir="${PREFIX}" -DPURIFY
> +        make all install_sw
> +    )
> +}
> +
> +build_openssl_osx () {
> +    (
> +        cd "openssl-${OPENSSL_VERSION}/"
> +        ./Configure darwin64-x86_64-cc shared \
> +            --prefix="${PREFIX}" --openssldir="${PREFIX}" -DPURIFY
> +        make depend all install_sw
> +    )
> +}
> +
> +build_openssl_mingw () {
> +    (
> +        cd "openssl-${OPENSSL_VERSION}/"
> +
> +        if [ "${CHOST}" = "i686-w64-mingw32" ]; then
> +            export TARGET=mingw
> +        elif [ "${CHOST}" = "x86_64-w64-mingw32" ]; then
> +            export TARGET=mingw64
> +        fi
> +
> +        ./Configure --cross-compile-prefix=${CHOST}- shared \
> +           ${TARGET} no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}" -static-libgcc
> +        make install
> +    )
> +}
> +
> +build_openssl () {
> +    if [ "$(cat ${PREFIX}/.openssl-version)" != "${OPENSSL_VERSION}" ]; then
> +        tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
> +        if [ ! -z ${CHOST+x} ]; then
> +            build_openssl_mingw
> +        else
> +            build_openssl_linux
> +        fi
> +        echo "${OPENSSL_VERSION}" > "${PREFIX}/.openssl-version"
> +    fi
> +}
> +
> +mkdir -p ${PREFIX}
> +mkdir -p download-cache
> +
> +# Download and build crypto lib
> +if [ "${SSLLIB}" = "openssl" ]; then
> +    download_openssl
> +    build_openssl
> +elif [ "${SSLLIB}" = "mbedtls" ]; then
> +    download_mbedtls
> +    build_mbedtls
> +else
> +    echo "Invalid crypto lib: ${SSLLIB}"
> +    exit 1
> +fi
> +
> +# Download and build dependencies for mingw cross build
> +# dependencies are the same as in regular windows installer build
> +if [ ! -z ${CHOST+x} ]; then
> +      download_tap_windows
> +      unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
> +
> +      download_lzo
> +      build_lzo
> +
> +      download_pkcs11_helper
> +      build_pkcs11_helper
> +fi

-- 
Antonio Quartulli

