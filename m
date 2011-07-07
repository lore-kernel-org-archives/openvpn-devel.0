Message-ID: <4E1599C7.8050809@...68...>
Date: Thu, 07 Jul 2011 13:34:31 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1310023632-30830-1-git-send-email-dejong@...1435...>
	<1310026791-5268-1-git-send-email-dejong@...1435...>
In-Reply-To: <1310026791-5268-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Further improvements to plugin support:
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 07.07.2011 10:19, schrieb Adriaan de Jong:
>  - Renamed struct entries to explicitly show them as disabled
>  - Added a warning if USE_SSL is enabled, but neither ssl_verify_openssl.h or ssl_verify_polarssl.h is included
>  - If neither of those files is included, disable ssl support for a plugin including openvpn-plugin.h

This arrived later, but does address my earlier concern.

>  #else
> -  int current_cert_depth; /* Unused, for compatibility purposes only */
> -  void *current_cert; /* Unused, for compatibility purposes only */
> +  int __current_cert_depth_disabled; /* Unused, for compatibility purposes only */
> +  void *__current_cert_disabled; /* Unused, for compatibility purposes only */
>  #endif
>  };
>  
> diff --git a/plugin.c b/plugin.c
> index 331671c..dc581a4 100644
> --- a/plugin.c
> +++ b/plugin.c
> @@ -379,8 +379,8 @@ plugin_call_item (const struct plugin *p,
>  						    .current_cert_depth = (current_cert ? certdepth : -1),
>  						    .current_cert = current_cert
>  #else
> -						    .current_cert_depth = -1,
> -						    .current_cert = NULL
> +						    .__current_cert_depth_disabled = -1,
> +						    .__current_cert_disabled = NULL
>  #endif


