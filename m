Message-ID: <54909E85.8040705@...1856...>
Date: Tue, 16 Dec 2014 22:05:09 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1418303015.31745.78.camel@...1866...>
In-Reply-To: <1418303015.31745.78.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] pkcs11: Load p11-kit-proxy.so module by
 default
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

ACK. Using smartcards really improves secuirty, but pkcs11 can have a
steep learning curve. Making it easier for users is a good thing.

-Steffan

On 11-12-14 14:03, David Woodhouse wrote:
> If the user specifies --pkcs11-id or --pkcs-id-management but neglects
> to explicitly provide a --pkcs11-provider argument, and if the system
> has p11-kit installed, then load the p11-kit proxy module so that the
> system-configured tokens are available.
> 
> Trac: 490
> Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
> ---
>  configure.ac          |  7 +++++++
>  doc/openvpn.8         | 10 ++++++++++
>  src/openvpn/options.c |  9 +++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index ddaa2b2..b549452 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1139,6 +1139,13 @@ if test "${enable_pkcs11}" = "yes"; then
>  	OPTIONAL_PKCS11_HELPER_CFLAGS="${PKCS11_HELPER_CFLAGS}"
>  	OPTIONAL_PKCS11_HELPER_LIBS="${PKCS11_HELPER_LIBS}"
>  	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
> +	PKG_CHECK_MODULES(
> +		[P11KIT],
> +		[p11-kit-1],
> +		[proxy_module="`$PKG_CONFIG --variable=proxy_module p11-kit-1`"
> +		 AC_DEFINE_UNQUOTED([DEFAULT_PKCS11_MODULE], "${proxy_module}", [p11-kit proxy])],
> +		[]
> +	)
>  fi
>  
>  if test "${enable_pedantic}" = "yes"; then
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 532eda5..0bdea1f 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4393,6 +4393,16 @@ This option can be used instead of
>  .B \-\-cert, \-\-key,
>  and
>  .B \-\-pkcs12.
> +
> +If p11-kit is present on the system, its
> +.B p11-kit-proxy.so
> +module will be loaded by default if either the
> +.B \-\-pkcs11\-id
> +or
> +.B \-\-pkcs11\-id\-management
> +options are specified without
> +.B \-\-pkcs11\-provider
> +being given.
>  .\"*********************************************************
>  .TP
>  .B \-\-pkcs11-private-mode mode...
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index f0091c2..b33eb4a 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2447,6 +2447,15 @@ options_postprocess_mutate_invariant (struct options *options)
>  #endif
>      }
>  #endif
> +
> +#ifdef DEFAULT_PKCS11_MODULE
> +  /* If p11-kit is present on the system then load its p11-kit-proxy.so
> +     by default if the user asks for PKCS#11 without otherwise specifying
> +     the module to use. */
> +  if (!options->pkcs11_providers[0] &&
> +      (options->pkcs11_id || options->pkcs11_id_management))
> +    options->pkcs11_providers[0] = DEFAULT_PKCS11_MODULE;
> +#endif
>  }
>  
>  static void
> 
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

