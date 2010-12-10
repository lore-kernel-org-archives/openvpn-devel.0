Message-ID: <20101210062512.17827.qmail@...1287...>
Date: Fri, 10 Dec 2010 07:25:12 +0100
From: Peter Stuge <peter@...1287...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C5F@...1436...>
MIME-Version: 1.0
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C5F@...1436...>
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview [7/8]
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
Content-Description: 07_polarssl_addition.patch.gz
> Add PolarSSL support to OpenVPN

> +++ b/configure.ac	Wed Dec 08 12:35:42 2010 +0100
> @@ -273,14 +273,16 @@
>  )
>  
>  AC_ARG_WITH([ssl-type],
> -   [  --with-ssl-type=TYPE  Build with the given SSL library, TYPE = openssl ],
> +   [  --with-ssl-type=TYPE  Build with the given SSL library, TYPE = openssl or polarssl ],
>     [case "${withval}" in 
>          openssl) SSL_LIB=openssl ;;
> +        polarssl) SSL_LIB=polarssl ;;
>          *) AC_MSG_ERROR([bad value ${withval} for --with-ssl-type]) ;;
>     esac],
>     [SSL_LIB="openssl"]
>  )
>  AM_CONDITIONAL([USE_OPENSSL], [test x$SSL_LIB = xopenssl])
> +AM_CONDITIONAL([USE_POLARSSL], [test x$SSL_LIB = xpolarssl])

Again, I think --with-polarssl may be more common.


//Peter

