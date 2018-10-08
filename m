Date: Mon, 8 Oct 2018 20:37:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181008183739.GW962@...1296...>
References: <20181008181618.8976-1-arne@...1227...>
 <20181008181618.8976-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aV+nM5O4EiZgYTzs"
Content-Disposition: inline
In-Reply-To: <20181008181618.8976-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Remove AUTO_USERID feature
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

--aV+nM5O4EiZgYTzs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 08, 2018 at 08:16:16PM +0200, Arne Schwabe wrote:
> There is no user facing way to enable this feature and way that feature
> works (username build from MAC of primary net device) is questionable.
>=20
> It also does not compile anymore.

Feature-ACK, but the patch itself puzzles me.

> @@ -455,51 +455,6 @@ get_auth_challenge(const char *auth_challenge, struc=
t gc_arena *gc)
>=20=20
>  #endif /* ifdef ENABLE_MANAGEMENT */
>=20=20
> -#if AUTO_USERID
[..]
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 0a947c6e..5a136d69 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -410,9 +410,6 @@ auth_user_pass_setup(const char *auth_file, const str=
uct static_challenge_info *
>      auth_user_pass_enabled =3D true;
>      if (!auth_user_pass.defined && !auth_token.defined)
>      {
> -#if AUTO_USERID
> -        get_user_pass_auto_userid(&auth_user_pass, auth_file);
> -#else
>  #ifdef ENABLE_MANAGEMENT

These hunks have "ENABLE_MANAGEMENT" in the context, while all my branches
(2.3, 2.4, master) have "ENABLE_CLIENT_CR" here.

This is not really needed to remove the (questionable) feature - and I can
just adjust the patch on the fly - but I wonder where these are coming=20
from in your tree, and whether I missed (or messed up) something...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aV+nM5O4EiZgYTzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbu6PyAAoJEB2Cnv7KVigSQXwL/0/Q/FL136MKe4ZhQH++QdCj
iKO0QEBV9IHwzUGJoHe7Kt8UzWf6eUDwV/gcSEnRzJFSzMHI6o6Un/G1VwHrHFiR
xH9JjDXMzcGzrW8X1vUSdya1VnRmWXFmMLtpDP/I0HYB+DR8uqWgX1iWspcKxOcP
0cw2a2uyEsEqABhS2WbDdEqF7FEJhHGrllQsxXzxKYDOE88v01J5urzbXcGY/Coy
RO8NQy1w36JaaOGxmF6Mo6N/Gbd1i866bDKC0CXvpMSSJkNAmUF0IxobkqIzcbfZ
NFNJBBMfkfFF5a/118uV5Lh2HXMN8P5eODBbRl4EtRGQoUiy4oQrQWzUcfw7bCl+
wncoqwKnlmyN2jJRS/Mp9x5Ct0j0UUHmVOQ0FFtqdBl+RkSBkbzuwuwi96SC+IxF
CA9jSIlF4K2tRbKjeF+UEIxudv/NV/cXTjJl38PclQRIBALirVOx9fPX8c+6iLnk
aJKcQfb7arf5krVwi9RPNqZeLu8D5QS93Jh7BLdTrA==
=LLuJ
-----END PGP SIGNATURE-----

--aV+nM5O4EiZgYTzs--

