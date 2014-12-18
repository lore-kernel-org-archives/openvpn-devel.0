Message-ID: <5492CA9E.3030700@...1435...>
Date: Thu, 18 Dec 2014 13:37:50 +0100
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <1418303015.31745.78.camel@...1866...>	
	<1418304072.31745.80.camel@...1866...> <5490A1C9.6@...1856...>	
	<1418808296.15146.256.camel@...1866...>
	<54915304.7070204@...1435...>	
	<1418812605.15146.263.camel@...1866...>
	<1418905506.21260.6.camel@...1866...>
In-Reply-To: <1418905506.21260.6.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH 2 v3] Make 'provider' option to
 --show-pkcs11-ids optional where p11-kit is present
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@...1866...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

ACK. Thanks for supplying and updating the patch!

-Steffan

On 12/18/2014 01:25 PM, David Woodhouse wrote:
> Trac: 490 Signed-off-by: David Woodhouse
> <David.Woodhouse@...753...> --- v2: Nicer error message if no
> provider given when there's no default. v3: Get the usage messages
> the right way round (s/ifndef/ifdef).
> 
> I did look at cleaning it up to stop looking at p[2] even when
> p[1] isn't set, but it makes it somewhat more complicated for no
> *real* benefit. So unless someone really objects, I'll leave it as
> it is.
> 
> doc/openvpn.8         |  8 +++++++- src/openvpn/options.c | 30
> ++++++++++++++++++++++++++++-- 2 files changed, 35 insertions(+), 3
> deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8 index 0bdea1f..49183ee
> 100644 --- a/doc/openvpn.8 +++ b/doc/openvpn.8 @@ -5490,11 +5490,17
> @@ adapter list. .SS PKCS#11 Standalone Options: 
> .\"********************************************************* .TP 
> -.B \-\-show-pkcs11-ids provider [cert_private] +.B
> \-\-show-pkcs11-ids [provider] [cert_private] (Standalone) Show
> PKCS#11 token object list. Specify cert_private as 1 if
> certificates are stored as private objects.
> 
> +If p11-kit is present on the system, the +.B provider +argument is
> optional; if omitted the default +.B p11-kit-proxy.so +module will
> be queried. + .B \-\-verb option can be used BEFORE this option to
> produce debugging information. 
> .\"********************************************************* diff
> --git a/src/openvpn/options.c b/src/openvpn/options.c index
> b33eb4a..226b203 100644 --- a/src/openvpn/options.c +++
> b/src/openvpn/options.c @@ -738,7 +738,11 @@ static const char
> usage_message[] = #ifdef ENABLE_PKCS11 "\n" "PKCS#11 standalone
> options:\n" -  "--show-pkcs11-ids provider [cert_private] : Show
> PKCS#11 available ids.\n" +#ifdef DEFAULT_PKCS11_MODULE +
> "--show-pkcs11-ids [provider] [cert_private] : Show PKCS#11
> available ids.\n" +#else +  "--show-pkcs11-ids provider
> [cert_private] : Show PKCS#11 available ids.\n" +#endif "
> --verb option can be added *BEFORE* this.\n" #endif				/*
> ENABLE_PKCS11 */ "\n" @@ -6935,11 +6939,33 @@ add_option (struct
> options *options, #endif /* ENABLE_SSL */ #endif /* ENABLE_CRYPTO
> */ #ifdef ENABLE_PKCS11 -  else if (streq (p[0], "show-pkcs11-ids")
> && p[1]) +  else if (streq (p[0], "show-pkcs11-ids") +	   ) { char
> *provider =  p[1]; bool cert_private = (p[2] == NULL ? false : (
> atoi (p[2]) != 0 ));
> 
> +#ifdef DEFAULT_PKCS11_MODULE +      if (!provider) +	provider =
> DEFAULT_PKCS11_MODULE; +      else if (!p[2]) { +	char *endp =
> NULL; +	int i = strtol(provider, &endp, 10); + +	if (*endp == 0) { 
> +	  /* There was one argument, and it was purely numeric. +
> Interpret it as the cert_private argument */ +	  provider =
> DEFAULT_PKCS11_MODULE; +	  cert_private = i; +	} +      } +#else +
> if (!provider) +	{ +	  msg (msglevel, "--show-pkcs11-ids requires a
> provider parameter"); +            goto err; +	} +#endif 
> VERIFY_PERMISSION (OPT_P_GENERAL);
> 
> set_debug_level (options->verbosity, SDL_CONSTRAIN);
> 


