Date: Wed, 12 Feb 2014 16:38:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140212153804.GN16637@...1296...>
References: <52FB8539.6050501@...1867...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TJq7xrFHmAmabYhN"
Content-Disposition: inline
In-Reply-To: <52FB8539.6050501@...1867...>
Subject: Re: [Openvpn-devel] ios tun api
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matej Gregr <igregr@...1867...>
Cc: openvpn-devel@lists.sourceforge.net

--TJq7xrFHmAmabYhN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Wed, Feb 12, 2014 at 03:29:13PM +0100, Matej Gregr wrote:
> I am looking for information about unofficial tun api for IOS.=20

The problem is that API information is only available under NDA, so=20
"the open source openvpn people" actually don't know anything specific.

OpenVPN 3 has a module that can access the API, as OpenVPN tech (the
commercial arm of OpenVPN) has signed the NDA with Apple - but this
leads to "there is an OpenVPN binary for iOS in the store, but the=20
source code that uses the API must not be made publically available=20
either".

So - most of us don't really know anything, and the few that do are not
permitted to talk about it.  Sorry about that - you'll have to talk to
Apple (but I don't even know who would be a good contact, they are very
secretive about things).

Or just use the VPN API on Android.  It's publically documented :-) (and
pretty broken in 4.4, but at least, open source...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TJq7xrFHmAmabYhN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUvuVXKkuBuNlUUl1AQKxdAP/RHLw4oMz3IuL3Jn3tXERWIhHkeT87pA8
YEqTXlFCHxpM4mR/bDuBZ4GjjSXwUpqK8JapsFNYSy2iR0aVh2KcqNWUXMl5LuJ0
6Oui7ghkXRw35TnCy6YR1nYk2ktN8wMCuRadq81SUfI6TKS7fxns501v2tOcgfkr
kzRAT0Vudn0=
=3DtU
-----END PGP SIGNATURE-----

--TJq7xrFHmAmabYhN--

