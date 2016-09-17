MIME-Version: 1.0
In-Reply-To: <1474109679-4982-1-git-send-email-chipitsine@...277...>
References: <1474109679-4982-1-git-send-email-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 17 Sep 2016 13:17:15 +0200
Message-ID: <CAA1AbxKesOCWi2gD6D9nOYVFB2ZyNzYnQsP-NNjWbzPGdG6SPg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] enable "--disable-crypto" build
	configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 17 September 2016 at 12:54, Ilya Shipitsin <chipitsine@...277...> wrote:
> ---
>  .travis.yml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 452c48e..369db97 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -51,10 +51,6 @@ matrix:
>        os: osx
>        osx_image: xcode7.3
>        compiler: clang
> -  allow_failures:
> -    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto"
> -      os: linux
> -      compiler: clang
>    exclude:
>      - compiler: gcc
>
> --
> 2.5.5

Thanks.  The patch is good, so ACK.

But the commit messages should describe why this change is needed.  In
this case:

Previously, 'make test' failed for --disable-crypto builds.  Since
that is not fixed, we should no longer accept --disable-crypto builds
to fail 'make test' on travis.

Could you please include such descriptions in future patches?

-Steffan

