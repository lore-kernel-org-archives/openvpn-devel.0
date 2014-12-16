Message-ID: <5490A1C9.6@...1856...>
Date: Tue, 16 Dec 2014 22:19:05 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1418303015.31745.78.camel@...1866...>
	<1418304072.31745.80.camel@...1866...>
In-Reply-To: <1418304072.31745.80.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH 2] Make 'provider' option to
 --show-pkcs11-ids optional where p11-kit is present
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi David,

Feature-ACK, but a small remark:

On 11-12-14 14:21, David Woodhouse wrote:
> @@ -6935,11 +6935,30 @@ add_option (struct options *options,
>  #endif /* ENABLE_SSL */
>  #endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_PKCS11
> -  else if (streq (p[0], "show-pkcs11-ids") && p[1])
> +  else if (streq (p[0], "show-pkcs11-ids")
> +#ifndef DEFAULT_PKCS11_MODULE
> +	   && p[1]
> +#endif
> +	   )

Since this makes a '--show-pkcs11-ids' without the module argument valid
for some openvpn builds, I think it is nicer to give a proper error
message to the user. E.g. something like:

    #ifndef DEFAULT_PKCS11_MODULE
	if (!p[1])
	  {
	    msg (msglevel, "--show-pkcs11-ids requires a module parameter");
	    goto err;
	  }
    #endif

Regards,
-Steffan

