Message-ID: <5e877862-457b-7241-f9fd-086adb9fe518@...2181...>
Date: Sun, 3 Sep 2023 20:15:05 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230903142947.20906-1-orbea@...2744...>
 <c0ecc754-7dda-313f-8cd2-047ebd1ae8cd@...2181...>
 <20230903091721.4a810beb@...2745...> <20230903095545.0f6d9d03@...2745...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230903095545.0f6d9d03@...2745...>
Subject: Re: [Openvpn-devel] [PATCH] configure: disable engines if
 OPENSSL_NO_ENGINE is defined
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
To: orbea <orbea@...2744...>, openvpn-devel@lists.sourceforge.net

Hi,

On 03/09/2023 18:55, orbea wrote:
> Here is a patch that preserves the version check and adds a second
> check for OPENSSL_NO_ENGINE which seems to also be useful for BoringSSL.
> 

I prefer this version, but I'll let other chime in.
On top of that I think we may need a proper v2 PATCH having no extra 
body, as I am not sure your message can be properly parsed by git-am.

Cheers,

>  From d6700ec0f5af2522bb4eb136d3760f5b1445c9d1 Mon Sep 17 00:00:00 2001
> From: orbea <orbea@...2744...>
> Date: Sat, 2 Sep 2023 23:06:22 -0700
> Subject: [PATCH] configure: disable engines if OPENSSL_NO_ENGINE is defined
> 
> Starting with LibreSSL 3.8.1 the engines have been removed which causes
> the OpenVPN build to fail. This can be solved during configure by
> checking if OPENSSL_NO_ENGINE is defined in opensslconf.h.
> ---
>   configure.ac | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 2f65cbd5..1adfb9d4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -927,11 +927,17 @@ if test "${with_crypto_library}" = "openssl"; then
>   				    [AC_LANG_PROGRAM(
>   					    [[
>   	    #include <openssl/opensslv.h>
> +	    #include <openssl/opensslconf.h>
>   					    ]],
>   					    [[
>   	    /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
>   	    #if OPENSSL_VERSION_NUMBER >= 0x30000000L
> -	    #error Engine supported disabled by default in OpenSSL 3.0+
> +	    #error Engine support disabled by default in OpenSSL 3.0+
> +	    #endif
> +
> +	    /*	     BoringSSL and LibreSSL >= 3.8.1 removed engine support */
> +	    #ifdef OPENSSL_NO_ENGINE
> +	    #error Engine support disabled by default in openssl/opensslconf.h
>   	    #endif
>   					    ]]
>   				    )],

-- 
Antonio Quartulli

