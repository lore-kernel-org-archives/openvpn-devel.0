Date: Sat, 26 Apr 2014 11:44:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140426094453.GC16637@...1296...>
References: <1398452943-18426-1-git-send-email-gert@...1296...>
	<535B6F81.8030005@...1790...> <535B762A.8050200@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6eZmXbBP9Km6HxFR"
Content-Disposition: inline
In-Reply-To: <535B762A.8050200@...1790...>
Subject: Re: [Openvpn-devel] [PATCH] Rewrite manpage section about
	--multihome
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--6eZmXbBP9Km6HxFR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 26, 2014 at 11:02:34AM +0200, Tore Anderson wrote:
> * Tore Anderson
> > The patches will eventually make it into the previous LTS release
> > 12.04 =ABPrecise=BB too, as part of the upcoming 12.04.5 point release
> > (expected in August).
>=20
> Just a little followup here to clarify in case you decide to add this
> info to the documentation.

I'm not sure if I really want to go there.  It is a lot of details, for
one specific Linux variant, while the manage is also read by people on
other Linux variants, or even (gasp!) non-Linux users.

You're right, of course, about the 3.15 bit.  So maybe change this to:

-----------------------------------------------------------
Note 2: if you do an IPv6+IPv4 dual-stack bind on a Linux machine with
multiple IPv4 address, connections to IPv4 addresses will not work
right on kernels before 3.15, due to missing kernel support for the
IPv4-mapped case (some distributions have ported this to earlier kernel
versions, though).
-----------------------------------------------------------

I'm happy to put your detailed text into the trac ticket, though, so=20
someone finding "it does not work!" and looking into trac can find them.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6eZmXbBP9Km6HxFR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1uAFakuBuNlUUl1AQKD9wP/Ub49CEm4KurNWA0duk1V3jriWQ52PYXW
5lusnloH/qyxNzN5qM2jD8CoDTbkX7KnBDkMGL41CWCQ2+boolV3gqiYVxP/mTRP
eyKy6xazyTn3/3xYaB01NxdDVUCWoEgV60M/Aa1R/wW7kJnRyB0P9jwnJvRdDGU7
4uEeO4mD47M=
=4ImA
-----END PGP SIGNATURE-----

--6eZmXbBP9Km6HxFR--

