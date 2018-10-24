References: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
 <1540306288-23847-1-git-send-email-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ec38d493-7b31-4f29-6877-bf0af7712e0c@...2181...>
Date: Wed, 24 Oct 2018 18:22:09 +0800
MIME-Version: 1.0
In-Reply-To: <1540306288-23847-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5nqNp0QgTIeNDhjzydLLBy7VVzughUOKE"
Subject: Re: [Openvpn-devel] [PATCH] Wrap openvpn_swprintf into Windows
 define
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5nqNp0QgTIeNDhjzydLLBy7VVzughUOKE
Content-Type: multipart/mixed; boundary="ydnUBeKAdZDLZYnY9jJ9zOuanIrOjq23x";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lstipakov@...277...>
Message-ID: <ec38d493-7b31-4f29-6877-bf0af7712e0c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Wrap openvpn_swprintf into Windows define
References: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
 <1540306288-23847-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1540306288-23847-1-git-send-email-lstipakov@...277...>

--ydnUBeKAdZDLZYnY9jJ9zOuanIrOjq23x
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/10/18 22:51, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> Commit 43a5a4f3b4e411419639c195fee8a76495fdc88e added
> vswprintf() call which turned to me missing in OpenBSD 4.9.
>=20
> Since that call is inside openvpn_swprintf() function which
> is only used by Windows, wrap that function info #ifdef _WIN32.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>

This patch introduces another ifdef, but it is enclosing a whole
function to prevent it from being compiled on non-windows platforms,
therefore I consider it "acceptable" for the time being.

This patch fixes building openvpn on OpenBSD <=3D 4.9 (maybe this info
should be added to the commit message).

Other than that:

Acked-by: Antonio Quartulli <antonio@...515...>


--=20
Antonio Quartulli


--ydnUBeKAdZDLZYnY9jJ9zOuanIrOjq23x--

--5nqNp0QgTIeNDhjzydLLBy7VVzughUOKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlvQR9EACgkQ9FVsWUWD
Dm2Qsg/+NU1S1NHtiFeQXQSl3mdGp/1VIP8kwYDbxX4YKkkUOLFyEsGrD1zKT7xr
6C8javoXzFo/nij1NOLhjndOQTh5YhByKnr9suoqus6OGgAA+CzcUZfY324yEvpN
TbY5l9O1EzXoO8j0LCKcxt1sBJu17REeh6fDCKgAS3kidrLh35kvvM4EfcWll2dF
feKkNZ+KFs8PxY5Qd9yRnQYnjPLa0kVGpoeR4w1CJ7S7KG5j9dF6ERn7AnPZDH8E
svN4nHMz+GP0VNi0mDLM++Xujst/uNfVPAmM5LhUUaA1EqspvocE5vUygWCFqAq3
OFKTWXOqhGNjMAQ2JVmR8NHJ3OyioX9vOBlaHQadf1kawTT690Tis1II+SLRIT3Z
rlYdKtE9aH+cspj2ODH6yLi8dMN+QNs9nAUfqQ10zs7cB7NEKosemmjHVizPfjTH
w92a0jIRydDgVPcyZ4McMpa1JHpEh36FbO4bdlpMEn7r7rygFanOJS3WaHIeiV+d
a4CHnwCk9JNG5glNpK745trLIuHVNvfkn3mKo5VB55Ty5GWrflFmoVAYqQB+KQ8v
TJEugM2bfKdiELD42KB2l9m0vhhT4xKDdhs7GKjvS5t98R+wTL9KRvsAYY/wTz8L
VvtiPnF2Y6P/83kLCRtsY+ATxi6O1Qc9IYFWKSsjfEs+CuseM9o=
=vy+r
-----END PGP SIGNATURE-----

--5nqNp0QgTIeNDhjzydLLBy7VVzughUOKE--

