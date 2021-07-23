Date: Fri, 23 Jul 2021 08:40:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YPpkRcqhj/QAjfyi@...1296...>
References: <20210722162409.231265-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tGEK6tP9zhdw1kye"
Content-Disposition: inline
In-Reply-To: <20210722162409.231265-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix OpenVPN querying user/password if
 auth-token with user expires
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--tGEK6tP9zhdw1kye
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 22, 2021 at 06:24:09PM +0200, Arne Schwabe wrote:
> @@ -3116,6 +3117,7 @@ do_init_crypto_tls(struct context *c, const unsigne=
d int flags)
>      to.auth_token_generate =3D options->auth_token_generate;
>      to.auth_token_lifetime =3D options->auth_token_lifetime;
>      to.auth_token_call_auth =3D options->auth_token_call_auth;
> +    to.auth_token_user_common_name =3D options->auth_token_user_common_n=
ame;
>      to.auth_token_key =3D c->c1.ks.auth_token_key;
>=20=20
>      to.x509_track =3D options->x509_track;

That hunk looks unrelated...?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tGEK6tP9zhdw1kye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg+mREAAoJEB2Cnv7KVigS9DML/jn1oHZofccf1/ECLZQx7Gih
/H4SsYe8gE0Bn6Q25BddvaInH75zhp4lhkmNFQN9YapXO9+B3dsNPbcJS+W6a6Kw
dr48BDDvRUrQeljvCLszswPLbtKEUhPaYawqzmyrOM/a6nuhXG0eMmIYTd/Gqold
HozdoufO62Hm00GmC1OcPes3Mpvp+grkXPerp0dwGRVPI+CiIY0PK1lrilXB2zlQ
lAoTDrcKOjy8STDQFkZGrIMz3vVamn22PKHKqpPDciX4bYCPVWCchg8scdsXVwD7
0Yam5rE8QtMW1pW50N7YLI75qg9dAlfIrj5DWVe9H3QSatk6iR5+cpRaFpc8anJw
AKCzdPWnXFxVYEvIQxTyBh1Bsi8gVncx/vRuyffnlJ7Ig84EabPRqfzxZM4fnDaA
d9vbp6+4hyZIVbFnGDUISrhqZuTlXedt1cIdJp1sM8WLBKH+V0PtWAykeQWCQSlC
46DV7BI3LmCev9pCy+6aatxgfbhQGoOAhYN/+cLIcA==
=U6Kd
-----END PGP SIGNATURE-----

--tGEK6tP9zhdw1kye--

