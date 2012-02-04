Date: Sat, 4 Feb 2012 15:32:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120204143214.GU13929@...1296...>
References: <1328361373-18901-1-git-send-email-dejong@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <1328361373-18901-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Minor code cleanup: cleaned up error
	handling in verify_cert.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 04, 2012 at 02:16:13PM +0100, Adriaan de Jong wrote:
> Removed done label and cleaned up return values.

Boah, that code was ugly...

ACK!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTy1BbqkuBuNlUUl1AQLAzgP/Zr8vZVjqqmMs9s4YELzoApEKvN1k+/uk
O7y3gQA933CRg7C3yfjZpurABvxTWmyBrQMrdmSShJ7+D+xb9j5jbl3ePGR6ZM8T
cO2zoer44pu2pi3A2qb0Ze6y/w5ck9Z/kz61FO2QTxBtX8Y6u1XzZVFoz7pQ2iKS
+loTAFPg1eA=
=nZy5
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--

