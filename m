References: <20190311133620.18278-1-chipitsine@...277...>
 <20190311133620.18278-3-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <78164a3d-8d05-f7f4-d696-5b61a486d9c0@...1856...>
Date: Sun, 17 Mar 2019 09:54:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190311133620.18278-3-chipitsine@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/3] travis-ci: change trusty image to
 xenial
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

On 11-03-19 14:36, chipitsine@...277... wrote:
> From: Ilya Shipitsin <chipitsine@...277...>
> 
> Ubuntu Trusty reaches End of Life on April 30, 2019
> Let us switch to xenial. Also, it simplifies mingw builds.
> We do not need to add xenial mingw manually anymore
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  .travis.yml           | 9 ++-------
>  .travis/build-deps.sh | 9 ---------
>  2 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 428131ec..bf46b14c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,5 +1,5 @@
>  sudo: required
> -dist: trusty
> +dist: xenial
>  
>  os: linux
>  
> @@ -75,12 +75,7 @@ matrix:
>  addons:
>    apt:
>      update: true
> -    packages:
> -      - liblzo2-dev
> -      - libpam0g-dev
> -      - liblz4-dev
> -      - linux-libc-dev
> -      - man2html
> +    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64]
>  
>  cache:
>    directories:
> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> index 96a030cc..391b35ef 100755
> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -130,15 +130,6 @@ build_openssl () {
>      fi
>  }
>  
> -if [ ! -z ${CHOST+x} ]; then
> -      #
> -      # openvpn requires at least mingw-gcc-4.9, which is available at xenial repo
> -      #
> -      sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu xenial main universe"
> -      sudo apt-get update
> -      sudo apt-get -y install dpkg mingw-w64
> -fi
> -
>  # Download and build crypto lib
>  if [ "${SSLLIB}" = "openssl" ]; then
>      download_openssl
> 

Makes sense. (Too bad travis is so slow to roll out newer Ubuntu versions.)

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

