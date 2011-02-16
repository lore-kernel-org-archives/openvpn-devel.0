Message-ID: <20110216035924.26449.qmail@...1287...>
Date: Wed, 16 Feb 2011 04:59:24 +0100
From: Peter Stuge <peter@...1287...>
References: <4D53FD4B.8050302@...515...> <4D540B3B.5040602@...1147...>
	<4D54F653.4040809@...515...>
	<20110211224046.GP13740@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <20110211224046.GP13740@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-rc Windows installer ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gert Doering wrote:
> On Fri, Feb 11, 2011 at 10:41:55AM +0200, Samuli Sepp=C3=A4nen wrote:
> > The older TAP driver probably works fine for the 2.2 branch. However, it
> > won't work properly in 2.3, which will contain IPv6 support.=20
>=20
> It will just not do IPv6, but the code in tun.c checks for this, and
> will print a warning so users can see why IPv6 is not working.=20=20
>=20
> It won't explode or break IPv4.

So OpenVPN must not hard depend on the new driver, and can then
continue to work on w2k. Great news!


//Peter

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFNW0uchR3Q0dhIfEgRAsCwAJ4rFXvfZbVPveCxSFt716L8e8HgeQCg4+/C
bT4Iu/cXf0pg8qRLdgURWKE=
=4IvQ
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

