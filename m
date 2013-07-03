Date: Wed, 3 Jul 2013 21:05:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130703190546.GO2778@...1296...>
References: <20130620180244.GV20843@...1296...>
	<1371753560-23939-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QOa9dl9wYIBIim/b"
Content-Disposition: inline
In-Reply-To: <1371753560-23939-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH v3] plugin: Extend the plug-in v3 API to
	identify the SSL implementation used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--QOa9dl9wYIBIim/b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
On Thu, Jun 20, 2013 at 08:39:20PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> OpenVPN would segfault unexpectedly if it would be compiled against Polar=
SSL
> and the plug-in would expect OpenSSL, or vice-versa.  This segfault would
> not appear before the plug-in would try to access functions which would
> be available if the plug-in and OpenVPN uses the same SSL implementation.
>=20
> This patch adds a member to the plug-in initialisation function, which
> identifies the SSL implementation.

I already ACKed that, but merging & testing, I found that when you
compile with --disable-ssl, the plugin functions would be passed "0"
as SSLAPI, by pure coincidence (macro not being defined at all, which
seems to be legal in a struct init and maps to 0).

So could you do a v4 that has SSLAPI_NONE in the ovpnSSLAPI and sets that
if neither OpenSSL nor PolarSSL is active?

thanks :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QOa9dl9wYIBIim/b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUdR2CqkuBuNlUUl1AQLRogQAsLDyVtx9tcsEhLOaHP5hKbwetFNB7e6e
/Fgk3Wwq5Wf8MjiXsyPUE/YfUhCtOeD3rKypXIUrvKugoGUEXKd/urj+a05Phnqu
cCYMuo+ESYVq8+q7fCA93PR6zJP6taHJgXnM4yj17nLRL+TDeEz5Ho/RDJ/sfG0a
2Bp1D5y0+wU=
=a8jw
-----END PGP SIGNATURE-----

--QOa9dl9wYIBIim/b--

