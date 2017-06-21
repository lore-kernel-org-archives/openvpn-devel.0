References: <1497897488-15999-1-git-send-email-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <13eea999-51c2-d2a7-4c0a-797f2587e1a7@...1856...>
Date: Wed, 21 Jun 2017 21:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <1497897488-15999-1-git-send-email-chipitsine@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: added gcc and clang
 openssl-1.1.0 builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 19-06-17 20:38, Ilya Shipitsin wrote:
> openssl build script was modified according to official openssl manual:
> https://wiki.openssl.org/index.php/Compilation_and_Installation
> ---
>  .travis.yml           | 6 ++++++
>  .travis/build-deps.sh | 6 +++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index bb44222..db90e03 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -27,9 +27,15 @@ matrix:
>      - env: SSLLIB="openssl"
>        os: linux
>        compiler: gcc
> +    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
> +      os: linux
> +      compiler: gcc
>      - env: SSLLIB="openssl"
>        os: linux
>        compiler: clang
> +    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
> +      os: linux
> +      compiler: clang
>      - env: SSLLIB="mbedtls"
>        os: linux
>        compiler: gcc
> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> index c5c1188..9cc1858 100755
> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -82,7 +82,7 @@ download_openssl () {
>  build_openssl_linux () {
>      (
>          cd "openssl-${OPENSSL_VERSION}/"
> -        ./config shared --openssldir="${PREFIX}" -DPURIFY
> +        ./config shared --prefix="${PREFIX}" --openssldir="${PREFIX}" -DPURIFY
>          make all install_sw
>      )
>  }
> @@ -91,7 +91,7 @@ build_openssl_osx () {
>      (
>          cd "openssl-${OPENSSL_VERSION}/"
>          ./Configure darwin64-x86_64-cc shared \
> -            --openssldir="${PREFIX}" -DPURIFY
> +            --prefix="${PREFIX}" --openssldir="${PREFIX}" -DPURIFY
>          make depend all install_sw
>      )
>  }
> @@ -107,7 +107,7 @@ build_openssl_mingw () {
>          fi
>  
>          ./Configure --cross-compile-prefix=${CHOST}- shared \
> -           ${TARGET} no-multilib no-capieng --openssldir="${PREFIX}" -static-libgcc
> +           ${TARGET} no-multilib no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}" -static-libgcc
>          make install
>      )
>  }
> 

Good idea, good patch.  ACK.

-Steffan

