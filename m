From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Small slash patch
In-Reply-To: <0c1201c51386$cef07e20$0600000a@...139...>
Message-ID: <Pine.LNX.4.58.0502151103330.13676@...41...>
References: <0c1201c51386$cef07e20$0600000a@...139...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Feb 15 10:06:21 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Gisle Vanem <giva@...258...>
Cc: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

On Tue, 15 Feb 2005, Gisle Vanem wrote:

> Using '\' in #include<> messes up the dependency generation (gcc -MM ..).
> Or at least MingW's make doesn't like it. So could you please use Unix slashes.
> 
> --- CVS-latest\cryptoapi.c      Sun Nov 28 18:22:01 2004
> +++ cryptoapi.c Sun Jan 23 09:31:06 2005
> @@ -32,8 +32,8 @@
>  #include <stdio.h>
>  #include <ctype.h>
>  #include <assert.h>
> -#include <openssl\ssl.h>
> -#include <openssl\err.h>
> +#include <openssl/ssl.h>
> +#include <openssl/err.h>
> 
>  #ifdef __MINGW32_VERSION
>  /* MinGW w32api is incomplete when it comes to CryptoAPI, as per version 3.1

Ok, I'll merge that.

James


