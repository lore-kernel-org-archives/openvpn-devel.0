From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 19 Mar 2013 11:38:44 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B8F531FC@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-2-git-send-email-steffan.karger@...1435...>
	<3973366.5Qu7FHKKCl@...1526...>
In-Reply-To: <3973366.5Qu7FHKKCl@...1526...>
Content-Language: en-US
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
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Sure. There's two options here: remove it from 1/5 and 'break' BF-CBC betwe=
en 1/5 and 4/5 (although BF wasn't supported by polar before 1.2 anyway), o=
r revert these changes in 4/5. I'd go for first option, since it delivers c=
leaner patches. If no one objects, I'll send an updated patch this afternoo=
n.

-Steffan

-----Original Message-----
From: Heiko Hund [mailto:heiko.hund@...1489...]=20
Sent: dinsdag 19 maart 2013 11:27
To: openvpn-devel@lists.sourceforge.net
Cc: Steffan Karger
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support

On Monday 18 March 2013 17:37:28 steffan.karger@...1435... wrote:
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index=20
> 8592955..9766742 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -827,7 +827,11 @@ init_options (struct options *o, const bool init_gc)
>    o->server_poll_timeout =3D 0;
>  #endif
>  #ifdef ENABLE_CRYPTO
> +#ifdef ENABLE_CRYPTO_POLARSSL
> +  o->ciphername =3D "BLOWFISH-CBC";
> +#else
>    o->ciphername =3D "BF-CBC";
> +#endif
>    o->ciphername_defined =3D true;
>    o->authname =3D "SHA1";
>    o->authname_defined =3D true;

Couldn't this be done better with the functionality in 4/5?

Heiko
--
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200 SOPHO=
S NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


