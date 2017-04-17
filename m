References: <20170413172609.29093-1-davids@...515...>
	<20170417090156.5218-1-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3eb7511d-c2c5-cb12-f95f-e4a6b4649b5e@...1856...>
Date: Mon, 17 Apr 2017 22:36:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170417090156.5218-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix broken ./configure on systems
 without openssl.pc
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
On 17-04-17 11:01, David Sommerseth wrote:
> [..]
> 
> We should anyway in this case have a better check of OpenSSL version
> available.  So in the case pkg-config fails, it will run an additional
> test looking for the OpenSSL version number in the opensslv.h header
> file and check against that version number.

Content-wise this looks good, but two remarks:

> @@ -861,12 +861,34 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  			[OPENSSL],
>  			[libcrypto >= 1.0.1, libssl >= 1.0.1],
>  	                [have_openssl="yes"],
> -			[AC_MSG_ERROR([Minimum supported OpenSSL version is 1.0.1])]
> +			[] # If this fails, we will do another test next
>  		)
>  
>  		OPENSSL_LIBS=${OPENSSL_LIBS:--lssl -lcrypto}
>  	fi

I think this OPENSSL_LIBS default can go now, since it is set below if
needed.

> +        # If pkgconfig check failed or OPENSSL_CFLAGS/OPENSSL_LIBS env vars
> +        # are used, check the version directly in the OpenSSL include file
> +        if test "${have_openssl}" != "yes"; then
> +           AC_MSG_CHECKING([additionally if OpenSSL is available and version >= 1.0.1])
> +	   AC_COMPILE_IFELSE(
> +		[AC_LANG_PROGRAM(
> +			[[
> +#include <openssl/opensslv.h>
> +			]],
> +			[[
> +/*           Version encoding: MNNFFPPS - see opensslv.h for details */
> +#if OPENSSL_VERSION_NUMBER < 0x10001000L
> +#error OpenSSL too old
> +#endif
> +			]]
> +		)],
> +		[AC_MSG_RESULT([ok])],
> +		[AC_MSG_ERROR([OpenSSL version too old])]
> +	   )
> +           OPENSSL_LIBS=${OPENSSL_LIBS:--lssl -lcrypto}
> +        fi

Tabs and spaces are mixed here.  The surrounding lines seem to be
tabs-only.  (This bites me each time I edit configure.ac too...)

-Steffan

