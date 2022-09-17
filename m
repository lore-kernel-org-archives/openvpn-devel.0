Date: Sat, 17 Sep 2022 14:37:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyW/n82ircKgjsFR@...1296...>
References: <20220914185937.31423-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1FTwVXsXT4ltzAIU"
Content-Disposition: inline
In-Reply-To: <20220914185937.31423-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] auth-user-pass: add support for
 inline credentials
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--1FTwVXsXT4ltzAIU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 14, 2022 at 08:59:36PM +0200, Antonio Quartulli wrote:
>  #ifdef ENABLE_MANAGEMENT
> -        auth_user_pass_setup(c->options.auth_user_pass_file, &c->options=
.sc_info);
> +        auth_user_pass_setup(c->options.auth_user_pass_file,
> +                             c->options.auth_user_pass_file,
> +                             &c->options.sc_info);
>  #else
> -        auth_user_pass_setup(c->options.auth_user_pass_file, NULL);
> +        auth_user_pass_setup(c->options.auth_user_pass_file,
> +                             c->options.auth_user_pass_file, NULL);
>  #endif

This does not look like it would work...  the second "..._pass_file"
arguments wants to be "..._inline", no?


> @@ -2165,9 +2174,12 @@ key_method_2_write(struct buffer *buf, struct tls_=
multi *multi, struct tls_sessi
>      if (auth_user_pass_enabled || (auth_token.token_defined && auth_toke=
n.defined))
>      {
>  #ifdef ENABLE_MANAGEMENT
> -        auth_user_pass_setup(session->opt->auth_user_pass_file, session-=
>opt->sci);
> +        auth_user_pass_setup(session->opt->auth_user_pass_file,
> +                             session->opt->auth_user_pass_file_inline,
> +                             session->opt->sci);
>  #else
> -        auth_user_pass_setup(session->opt->auth_user_pass_file, NULL);
> +        auth_user_pass_setup(session->opt->auth_user_pass_file,
> +                             session->opt->auth_user_pass_file_inline, N=
ULL);
>  #endif

This one is better :-)

This aside, the change is surprisingly simple.  Seems proxy-user-pass did
the grunt work for us...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1FTwVXsXT4ltzAIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJb+fAAoJEB2Cnv7KVigSZ5kL/02zqrQR1UOrAut4lXOcO3D0
X377InBFCKRj8gZ3ERzoByKGYV1HhT/K1wEg6R78O07QIkotZhY5+mA9tGLvbviM
R5YQ7FSgL31pNvRhH1Y7FUPhET1FAPbvgxRJCV85JEnmZK3W2Tl48VTAMXUH5iob
zWVvGSrVGlXxoDu2pM1nZMWxN9JDvFYxZLugMagYeyzcdzh9X1KvB/fgJgcgs40j
QHrhZvIhd72182m+JA6ImrsyADthph0/JD2+sbrJGA7C0vziNpA9ufrFC4u8zqAZ
8YtdZHFvbXrDrnlXz6hotg4Cxt7Gx1kyyubAv1fxP6h8BIZZfqKGiX1p0p6jiDvB
Rp90v9LKKDVToW8wbUSRRliUmdNv6qACkvsJYUCGGTlTZVaIirBBfDyOWAQmpVPk
DlokLZw068/SaSFL7vE+t4X47N0bBWn7F/DMMomPmwhPRnoHiKnLCcS0nzGudiXo
w7ve2aengckkmX2Y/HNRhQz0M/M6TtiRUg/a8Ljzyg==
=oNlj
-----END PGP SIGNATURE-----

--1FTwVXsXT4ltzAIU--

