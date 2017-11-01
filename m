References: <1509291288.3116.14.camel@...2316...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <062b01dd-305c-8635-1b05-540e6cffe838@...1856...>
Date: Wed, 1 Nov 2017 19:33:52 +0100
MIME-Version: 1.0
In-Reply-To: <1509291288.3116.14.camel@...2316...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] autoconf: Fix engine checks for openssl
 1.1
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

On 29-10-17 16:34, James Bottomley wrote:
> In openssl 1.1, ENGINE_cleanup became a #define instead of a function
> (because it's no longer needed as engines are self cleaning).  Update
> the autoconf.ac script to check for ENGINE_cleanup as a declaration to
> avoid falsely underfinig HAVE_OPENSSL_ENGINE in openssl 1.1+

Typo in "underfinig", but that should be fixable when applying the patch.

> Signed-off-by: James Bottomley <James.Bottomley@...2316...>
> ---
>  configure.ac | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 6f59baef..45aa5017 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -899,6 +899,13 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  		,
>  		[have_openssl_engine="no"; break]
>  	)
> +	if test "${have_openssl_engine}" = "no"; then
> +		AC_CHECK_DECL( [ENGINE_cleanup], [have_openssl_engine="yes"],,
> +			[[
> +				#include <openssl/engine.h>
> +			]]
> +		)
> +	fi
>  	if test "${have_openssl_engine}" = "yes"; then
>  		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
>  	fi
> 

Change looks good, and does what it says on the tin.  ACK.

-Steffan

