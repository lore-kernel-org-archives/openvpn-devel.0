Date: Wed, 15 Jul 2020 14:21:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200715122139.GP1431@...1296...>
References: <20200715113132.22754-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5L959PrSMZFrcmRe"
Content-Disposition: inline
In-Reply-To: <20200715113132.22754-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix environment variables for
 p2mp-assigned IPv6 addresses.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--5L959PrSMZFrcmRe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 15, 2020 at 01:31:32PM +0200, Gert Doering wrote:
> commit a8f8b926718 introduces $ENV{ifconfig_pool_local_ip6} and
> $ENV{ifconfig_pool_remote_ip6}, but instead of properly setting them,
> the code overwrites the IPv4 variables, $ENV{ifconfig_pool_remote}
> and $ENV{ifconfig_pool_local}.
>=20
> Trivial fix.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>

And while the fix looks trivially right, it isn't... setenv_in6_addr()
calls setenv_sockaddr() which does

	openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix);
	getnameinfo(&addr->addr.sa, sizeof(struct sockaddr_in6),
		    buf, sizeof(buf), NULL, 0, NI_NUMERICHOST);

so with the patch, I end up with

ifconfig_pool_local_ip6_ip6=3Dfd00:abcd:204:5::1
ifconfig_pool_remote_ip6_ip6=3Dfd00:abcd:204:5::2

seems the original code is not easy to understand, but correct.

So, NACK.

Taking "talking to myself" to new levels :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5L959PrSMZFrcmRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDvTTAAoJEB2Cnv7KVigSB+cL/iyrgDwBq0QC1/a2a3WXegge
DhWfRyhZNEwAknDINcQ/IQYzJtROUNxECQIXP2bVfNydE00BbJ7nzDBrMs727o0o
2UDIG9qcJ2PsWCgMHEQRUkJDKUfKO9aAsCf5J+DwyyHECs3SF+fiNHiSJXj2jn9E
XgAvK6NEWIWSspDn0duu7Yzrjbl1nzGMw2n6fkVp+SHzi4oVBJRFFq1lymWaA0w9
zfE8pBfnG56yQNFlJh8fDPVrS01mJuG+LEXLA72nQn3WKHxihDY2QpxwxgQpXT7Q
sldi8OMMf/FmRLgbyrAPNcQWLY57u3NBQrQ2vCxt0Igc9p0Jaj1GTLf7ZvbU6Lnq
BaCAMxEisPBp005SfrShh/ylwrqrXhO+tLtwgVLmh3ViJd9fO24M2Oagt+2jEriE
qNtDDHaHm4kddVXD5Ntc0834BaTqVhEbQV/J6+8CO3fhm0sYN+mYiuC5F2jaHBLY
2gwbMoehVs1N5NQ/hkdMEikmjFxYW279WvI3OcmkKw==
=m4Ue
-----END PGP SIGNATURE-----

--5L959PrSMZFrcmRe--

