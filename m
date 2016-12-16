References: <20161216163218.25449-1-jm@...1926...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <81545911-8680-4725-19ac-22cf94ffe4c3@...1435...>
Date: Fri, 16 Dec 2016 18:03:32 +0100
MIME-Version: 1.0
In-Reply-To: <20161216163218.25449-1-jm@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Fix implicit declarations when
 HAVE_OPENSSL_ENGINE is unset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 16-12-16 17:32, Julien Muchembled wrote:
> This fixes a regression in commit 8e95e20913:
> on amd64, an implicit declaration of ERR_error_string leads to segfaults
> if the returned pointer does not fit in an 'int'.
> 
> Trac: #792
> 
> Signed-off-by: Julien Muchembled <jm@...1926...>
> ---
> This patch is for the 2.3 branch. In the master branch,
> crypto_openssl.c already includes these files.
> 
>  src/openvpn/crypto_openssl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 7b1ac6c..fe22044 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -45,6 +45,8 @@
>  #include <openssl/objects.h>
>  #include <openssl/evp.h>
>  #include <openssl/des.h>
> +#include <openssl/err.h>
> +#include <openssl/rand.h>
>  
>  /*
>   * Check for key size creepage.
> 

ACK, fix is clearly correct.

Though there must be more then just 'on amd64' to make this break - this
code has run an a *lot* of amd64 systems and this is the first breakage
report.  (Of course that doesn't mean in any way that we shouldn't fix
it, I'm just curious.)

-Steffan

