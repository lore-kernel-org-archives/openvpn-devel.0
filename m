References: <1487874133-28780-1-git-send-email-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <8b5e5f96-a198-dcb9-66cc-d1969743d801@...1856...>
Date: Sat, 25 Feb 2017 17:10:12 +0100
MIME-Version: 1.0
In-Reply-To: <1487874133-28780-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add "make distcheck" to test
 scenario
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

Hi,

On 23-02-17 19:22, Ilya Shipitsin wrote:
> in rare cases openvpn is built from tarball, it happens during "installer build"
> process. "make distcheck" helps to prevent problems during such builds.
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index a68374a..6ebfa39 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -79,6 +79,7 @@ script:
>    - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH}"; fi
>    - autoreconf -vi
>    - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} || (cat config.log && exit 1)
> +  - make distcheck > build.log 2>&1 || (cat build.log && exit 1)
>    - make -j$JOBS
>    - src/openvpn/openvpn --version || true
>    - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi
> 

Running 'make distcheck' from travis is a good idea.  But, I think it
should be done *after* 'make check'.  Futhermore, it would be nice to
only do this for one of the configurations, to keep our travis runs as
lightweight as possible (saves devs some waiting time, saves travis
energy/capacity).

-Steffan

