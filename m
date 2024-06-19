Date: Wed, 19 Jun 2024 12:44:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZnK2pHWV0wuQ_GEc@...1296...>
References: <20240619103004.56460-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="l0Ay6Hickmn7kZAz"
Content-Disposition: inline
In-Reply-To: <20240619103004.56460-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Properly handle null bytes and
 invalid characters in control messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>, Reynir Bj?rnsson <reynir@...2756...>

--l0Ay6Hickmn7kZAz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 19, 2024 at 12:30:04PM +0200, Gert Doering wrote:
> From: Arne Schwabe <arne@...1227...>
>=20
> This makes OpenVPN more picky in accepting control message in two aspects:
> - Characters are checked in the whole buffer and not until the first
>   NUL byte
> - if the message contains invalid characters, we no longer continue
>   evaluating a fixed up version of the message but rather stop
>   processing it completely.
[..]
> CVE: 2024-5594

So, for the record - this patch was discussed and reviewed "in private"
on the security@...515... list, because it was seen as having security
implications.

2.6.11 release will happen today or tomorrow, so I'm posting this patch
to the public list now for transparency, and will proceed with testing
and merging.

The security impact is fairly moderate - namely, a malicious peer can
send (hand crafted) control channel messages that mess up logging(!) on
the other side.  No breach of crypto, leak of information, or remote code
execution.  But still an annoyance to be fixed and properly documented.

Thanks, Reynir, for reading our sources with so much passion for details :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--l0Ay6Hickmn7kZAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmcrakAAoJEB2Cnv7KVigShSsL/3/UiCLH6AxCDvX/PQYHetYS
g/VvwVio6wqD1Vv9kI17+N7rhffQWK40eSVccIUHFUiAr2tmXg4gSTQP9IVXK9DM
lFny1AelWrcGIN0OwpOgw1jzHNxo+FedItrjncVEUF+Qnl2RqSYMsHqry0sMiiZM
Jwam2QD+sK5bBX1WMy5j2rTbczY4VIw9ld7FmDdKDIld/HFE1OnVXWbr4wHHsF3G
2tvXDlTEuu+YnE7uXthm/8DEV63M/anArFjy+uurJc/6ks1czcnsIVGWMHYUsP2I
5LsqwUZiSf0i0IUdPuqrvH6hwhTxtCN+GzDWYcEGabtthoZceNB/6aNXa3/YT4AY
GYa6474ngw3RYAJTc8Yd0cCUDuhgP7tEl08LPiVH4HwPonPZGSTGSBYjxJVpcpK4
KDGJuZHCZbYV5kAntNjKzhujX0qrXWp3CcuKQyf1hi28w8V0zSy2d2tiQuoy6sxs
eo7yDnhtaL+vVRFPnuAVEbt5mLYn+3LwZHjZ5oKrEg==
=+zY2
-----END PGP SIGNATURE-----

--l0Ay6Hickmn7kZAz--

