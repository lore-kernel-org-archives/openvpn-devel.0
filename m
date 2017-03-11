References: <1488734492-5319-1-git-send-email-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5b3860c0-8ad2-3851-2553-71ace756a09a@...1856...>
Date: Sat, 11 Mar 2017 12:22:12 +0100
MIME-Version: 1.0
In-Reply-To: <1488734492-5319-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: remove unused files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 05-03-17 18:21, Ilya Shipitsin wrote:
> Those files were commited by mistake. I implemented building
> dependencies in 4 separate scripts, later Steffan Karger combined
> all 4 scripts into "build-deps.sh".
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  .travis/build-mbedtls-linux.sh |  9 ---------
>  .travis/build-mbedtls-osx.sh   |  9 ---------
>  .travis/build-openssl-linux.sh | 12 ------------
>  .travis/build-openssl-osx.sh   | 11 -----------
>  4 files changed, 41 deletions(-)
>  delete mode 100755 .travis/build-mbedtls-linux.sh
>  delete mode 100755 .travis/build-mbedtls-osx.sh
>  delete mode 100755 .travis/build-openssl-linux.sh
>  delete mode 100755 .travis/build-openssl-osx.sh
> 
> diff --git a/.travis/build-mbedtls-linux.sh b/.travis/build-mbedtls-linux.sh
> deleted file mode 100755
> index dc92aaf..0000000
> --- a/.travis/build-mbedtls-linux.sh
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#!/bin/sh
> -
> -if [ ! -f download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz ]; then
> -	wget -O download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz https://tls.mbed.org/download/mbedtls-${MBEDTLS_VERSION}-apache.tgz;
> -fi
> -
> -tar zxf download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
> -cd mbedtls-${MBEDTLS_VERSION} && make > build.log 2>&1 || (cat build.log && exit 1)
> -make install DESTDIR=$MBEDTLS_PREFIX && cd ..
> diff --git a/.travis/build-mbedtls-osx.sh b/.travis/build-mbedtls-osx.sh
> deleted file mode 100755
> index dc92aaf..0000000
> --- a/.travis/build-mbedtls-osx.sh
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#!/bin/sh
> -
> -if [ ! -f download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz ]; then
> -	wget -O download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz https://tls.mbed.org/download/mbedtls-${MBEDTLS_VERSION}-apache.tgz;
> -fi
> -
> -tar zxf download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
> -cd mbedtls-${MBEDTLS_VERSION} && make > build.log 2>&1 || (cat build.log && exit 1)
> -make install DESTDIR=$MBEDTLS_PREFIX && cd ..
> diff --git a/.travis/build-openssl-linux.sh b/.travis/build-openssl-linux.sh
> deleted file mode 100755
> index 84f4aae..0000000
> --- a/.travis/build-openssl-linux.sh
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#!/bin/sh
> -
> -if [ ! -f download-cache/openssl-${OPENSSL_VERSION}.tar.gz ]; then
> -	wget -O download-cache/openssl-${OPENSSL_VERSION}.tar.gz https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz;
> -fi
> -
> -tar zxf download-cache/openssl-${OPENSSL_VERSION}.tar.gz
> -cd openssl-${OPENSSL_VERSION}/
> -./config shared --prefix=$OPENSSL_PREFIX -DPURIFY > build.log 2>&1 || (cat build.log && exit 1)
> -make > build.log 2>&1 || (cat build.log && exit 1)
> -make install_sw > build.log 2>&1 || (cat build.log && exit 1)
> -cd ..
> diff --git a/.travis/build-openssl-osx.sh b/.travis/build-openssl-osx.sh
> deleted file mode 100755
> index 61c8016..0000000
> --- a/.travis/build-openssl-osx.sh
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -#!/bin/sh
> -
> -if [ ! -f download-cache/openssl-${OPENSSL_VERSION}.tar.gz ]; then
> -        wget -O download-cache/openssl-${OPENSSL_VERSION}.tar.gz https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz;
> -fi
> -
> -tar zxf download-cache/openssl-${OPENSSL_VERSION}.tar.gz
> -cd openssl-${OPENSSL_VERSION}/
> -./Configure darwin64-x86_64-cc shared --prefix=$OPENSSL_PREFIX -DPURIFY > build.log 2>&1 || (cat build.log && exit 1)
> -make depend install > build.log 2>&1 || (cat build.log && exit 1)
> -cd ..
> 

ACK

-Steffan

