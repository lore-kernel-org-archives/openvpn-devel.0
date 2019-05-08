References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-2-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <2525fdbf-651d-2dd2-c438-297a96bfc887@...1227...>
Date: Wed, 8 May 2019 16:36:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181219050118.6568-2-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GK5WXNnd6K0Hu04Wgh73BacPVDKVfWzOj"
Subject: Re: [Openvpn-devel] [PATCH v3 1/7] implement networking API for
 iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GK5WXNnd6K0Hu04Wgh73BacPVDKVfWzOj
Content-Type: multipart/mixed; boundary="7UIsEvkc1AfpXAilPpbao2AHJTnarxJk9";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2525fdbf-651d-2dd2-c438-297a96bfc887@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/7] implement networking API for
 iproute2
References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-2-a@...2181...>
In-Reply-To: <20181219050118.6568-2-a@...2181...>

--7UIsEvkc1AfpXAilPpbao2AHJTnarxJk9
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.12.18 um 06:01 schrieb Antonio Quartulli:
> iproute2 is the first user of the new networking API and
> its one of the two currently supported functionalities on
> Linux (the other being net-tools).
>=20
> This patch simply copies the current code from tun.c/route.c
> to networking_ip.c without introducing any funcional
> change to the code.

Should be networking_iproute2.c in the commit message too.

Otherise:

Acked-By: Arne Schwabe <arne@...1227...>


--7UIsEvkc1AfpXAilPpbao2AHJTnarxJk9--

--GK5WXNnd6K0Hu04Wgh73BacPVDKVfWzOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzS6YIACgkQFRhsZwKx
RFTDUxAAjLfl2O6H7mkaz9WkFLhjOWe7Xe54x9hFqnqPwhUONkMByUUB9uD19HY+
O+b9Trz5b4C6thrQcQCMUuC0v4BOHKcLkcsUEEou8PVuaGZOlJEJThIysQG7yW05
ZIzDVKvV5TlOAU3pAEOorhEf59MDP3IaTxRCleEDOmtdgKcA9jV/3v8Eo7yu3CxL
PJo/O9fPVlZ90CnQ1yYDz/yUneLuWwjuPF4yi7TSa3ZI5q7JXuGKirxJYLorhdaQ
5rXvDz/cX6EyMTTkm5beeBgkHQdSIoK5ZVGF6GBx0zS2FBsczUsal/tlVODUZADM
4e4GuzKihP+lVzaeC48CgzP0qdJYJi5g3AZtX03g7uVhAyIg1kKJZ1f/8VOo9iX7
1jLfV9tze1GphN07bXCUsbvzpJGLeTRg1cGhOxLdMD5z1KTYsnGmGT51uHUSWNgA
yFwmmrDUQMs8bAbbgrTQyneq5yVE2cxqej1VysQ29esLZUsmtWwxIlNIZeVWpMwU
O5x6KTB4EUW5kyVfYBiYay6+i/Pmvtg/GV6gG0S1BpnKtY+UJ6IsxEfm4U7kvxVJ
lv9O95jxgFNUqOPQenYPZjv3dWLciN2p2KdxJkFB1c7YZbADaNICTqiRZYgM6TPE
rNjVB96CyabKmFC32W3cFzyj9B7GxwzuXVri2tebDsFmS+7fHfY=
=ozWm
-----END PGP SIGNATURE-----

--GK5WXNnd6K0Hu04Wgh73BacPVDKVfWzOj--

