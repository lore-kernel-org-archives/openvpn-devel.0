References: <20180527190057.3488-1-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <944d4c57-7862-ed0e-619c-71c8c4998a02@...1856...>
Date: Sat, 23 Jun 2018 08:02:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180527190057.3488-1-chipitsine@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] travis-ci: cleanup, refactor,
 upgrade ssl libraries
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

On 27-05-18 21:00, Ilya Shipitsin wrote:
> Both "compiler" and "exclude" are redundant, so remove them.
> Add openssl-1.0.1u to build matrix. Enable explicit apt update
> (it was disabled by default in travis-ci).
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> 
> --
> v2: Add openssl-1.0.1u to build matrix (thanks to Steffan Karger),
> Add explicit apt-get update (it was disabled by default in travis-ci)
> ---
> ---
>  .travis.yml | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 51645924..216f0a04 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -5,9 +5,6 @@ os: linux
>  
>  language: c
>  
> -compiler:
> -  - gcc
> -
>  env:
>    global:
>      - JOBS=3
> @@ -15,10 +12,10 @@ env:
>      - TAP_WINDOWS_VERSION=9.21.2
>      - LZO_VERSION=2.10
>      - PKCS11_HELPER_VERSION=1.22
> -    - MBEDTLS_VERSION="2.5.1"
> +    - MBEDTLS_VERSION="2.8.0"
>      - MBEDTLS_CFLAGS="-I${PREFIX}/include"
>      - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
> -    - OPENSSL_VERSION="1.0.2l"
> +    - OPENSSL_VERSION="1.0.2o"
>      - OPENSSL_CFLAGS="-I${PREFIX}/include"
>      - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
>      # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
> @@ -30,13 +27,16 @@ matrix:
>      - env: SSLLIB="openssl" RUN_COVERITY="1"
>        os: linux
>        compiler: gcc
> -    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
> +    - env: SSLLIB="openssl" OPENSSL_VERSION="1.0.1u"
> +      os: linux
> +      compiler: gcc
> +    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
>        os: linux
>        compiler: gcc
>      - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
>        os: linux
>        compiler: clang
> -    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
> +    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
>        os: linux
>        compiler: clang
>      - env: SSLLIB="mbedtls"
> @@ -65,11 +65,10 @@ matrix:
>      - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small"
>        os: linux
>        compiler: clang
> -  exclude:
> -    - compiler: gcc
>  
>  addons:
>    apt:
> +    update: true
>      packages:
>        - liblzo2-dev
>        - libpam0g-dev
> 

Thanks.  This looks good to me.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

