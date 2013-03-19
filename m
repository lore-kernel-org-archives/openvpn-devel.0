From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 19 Mar 2013 11:27:15 +0100
Message-ID: <3973366.5Qu7FHKKCl@...1526...>
In-Reply-To: <1363624652-7001-2-git-send-email-steffan.karger@...1435...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-2-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Monday 18 March 2013 17:37:28 steffan.karger@...1435... wrote:
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8592955..9766742 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -827,7 +827,11 @@ init_options (struct options *o, const bool init_gc)
>    o->server_poll_timeout = 0;
>  #endif
>  #ifdef ENABLE_CRYPTO
> +#ifdef ENABLE_CRYPTO_POLARSSL
> +  o->ciphername = "BLOWFISH-CBC";
> +#else
>    o->ciphername = "BF-CBC";
> +#endif
>    o->ciphername_defined = true;
>    o->authname = "SHA1";
>    o->authname_defined = true;

Couldn't this be done better with the functionality in 4/5?

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


