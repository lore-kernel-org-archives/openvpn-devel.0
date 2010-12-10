Message-ID: <20101210062338.17649.qmail@...1287...>
Date: Fri, 10 Dec 2010 07:23:37 +0100
From: Peter Stuge <peter@...1287...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C53@...1436...>
MIME-Version: 1.0
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C53@...1436...>
Subject: Re: [Openvpn-devel] [Patch] OpenVPN OpenSSL Crypto
	Separation	Preview [2/8]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Adriaan de Jong wrote:
Content-Description: 02_openssl_crypto_separation.patch.gz
> Separate OpenSSL specific code
> 
> diff -r 228dee8676bf Makefile.am
> --- a/Makefile.am	Wed Aug 11 14:37:00 2010 +0200
> +++ b/Makefile.am	Wed Dec 08 11:49:46 2010 +0100
> @@ -74,18 +74,18 @@
>  	INSTALL-win32.txt
>  
>  openvpn_SOURCES = \
> -        base64.c base64.h \
> +	base64.c base64.h \

Please make all whitespace changes in a separate patch.

> +++ b/configure.ac	Wed Dec 08 11:49:46 2010 +0100
..
> @@ -272,6 +272,16 @@
>     [MEMCHECK="$withval"]
>  )
>  
> +AC_ARG_WITH([ssl-type],
> +   [  --with-ssl-type=TYPE  Build with the given SSL library, TYPE = openssl ],
> +   [case "${withval}" in 
> +        openssl) SSL_LIB=openssl ;;
> +        *) AC_MSG_ERROR([bad value ${withval} for --with-ssl-type]) ;;
> +   esac],
> +   [SSL_LIB="openssl"]
> +)
> +AM_CONDITIONAL([USE_OPENSSL], [test x$SSL_LIB = xopenssl])
> +

I think --with-openssl is the common way.


//Peter

