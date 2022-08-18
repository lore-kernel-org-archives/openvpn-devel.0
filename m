Date: Thu, 18 Aug 2022 07:52:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv3TgJOqYyyz9LcE@...1296...>
References: <20220818001358.175361-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6wyAztf2uMeIVhja"
Content-Disposition: inline
In-Reply-To: <20220818001358.175361-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] close_tun: print interface type
 consistently in message
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

--6wyAztf2uMeIVhja
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 18, 2022 at 02:13:58AM +0200, Antonio Quartulli wrote:
> When closing the tunnel interface we know if we were using DCO or not.
> for this reason we can customize the closing message and make it
> consistent with the opening one.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/init.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index e8335c53..92c4cab9 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1921,7 +1921,15 @@ do_open_tun(struct context *c)
>  static void
>  do_close_tun_simple(struct context *c)
>  {
> -    msg(D_CLOSE, "Closing TUN/TAP interface");
> +    if (dco_enabled(&c->options))
> +    {
> +        msg(D_CLOSE, "Closing DCO interface");
> +    }
> +    else
> +    {
> +        msg(D_CLOSE, "Closing TUN/TAP interface");
> +    }

I find this is a bit excessive in lines of code...=20=20

If we really want this, I think we should do

 +    msg(D_CLOSE, "Closing %s interface",
          dco_enabled(&c->options)? "DCO": "TUN/TAP");

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6wyAztf2uMeIVhja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/dOAAAoJEB2Cnv7KVigSLiwL/1r1BiDExNMZ1FX8nRmrc4Ju
ayK3aPGI7ze0Mrfy7lqZvWIU847Ya6EBFFQTAP9IgZrk3ZKGp7eR/FxlCWk5vkAe
Lyo7d0bjpDedrXhI2rLyZ7sRYkdlVGLuULsR8yOgMEus8txiJB+Bm9OuurqEEHQD
i4SGBrCt3+IXaK+4WzZCBEyCeGsW5Wo9T8p7wa5CWqDVHlOJbRYQFCghy7r8OYk4
hay5fQ5zXFzfNXFKtFMCsQ7BBSYSnrkLeB6R3UgyZImZTNftPibix2/S06hV0VIc
owBnAEJGcKcMN2ESTjVEiKTaeHVOevc8Y5vJ/U9jsHSwvgtmgWGDD9yOor1Zx59h
h2mWSmamOsXO/GuekgOSb+WK1r6VIi0hRnma2rg4AzIdXHPLtjXpcEypiGflVPVz
7AreeoziWpOOkzgVj1GTDK8f+XGa0K0yaaA6xv2jNwqKO1MitQ5YGBoEra0i25pl
gDS7SY3+ufqMSmCCRucKZJ5IDr9suUHBe24drjo/lw==
=8wmU
-----END PGP SIGNATURE-----

--6wyAztf2uMeIVhja--

