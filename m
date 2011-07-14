Date: Thu, 14 Jul 2011 12:02:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110714100259.GE8496@...1296...>
References: <1CED409804E2164C8104F9E623B08B90126C7D303D@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R4+EwJQA1QUEuvQX"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B90126C7D303D@...1436...>
Subject: Re: [Openvpn-devel] Minor issue in master git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--R4+EwJQA1QUEuvQX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 14, 2011 at 11:54:26AM +0200, Adriaan de Jong wrote:
> There's a minor annoyance in the master git tree, which rears its head on=
 Windows. Both the TODO.IPv6 and README.IPv6 have a little brother  called =
*.ipv6 (note the capitalisation). On Windows, this is the same filename.
>=20
> Could someone closer to the subject merge/rename these files (I'm not ent=
irely sure what needs to be done here?)

Why can't folks just use reasonable file systems...?

More seriously: well, thanks for reminding me.  One of these file sets
is from me ("IPv6 payload patch") the other half is from JJO ("IPv6
transport patch"), and I had intended to merge them already weeks ago...

"Soon!"

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--R4+EwJQA1QUEuvQX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTh6+06kuBuNlUUl1AQLYJQP/cVywhNC2PdSUMheXFOAuziOuFgge95gG
Up0+gHNfnEm2Pp+B5HbH75TYcyNi5TStTiLxp0Y5NknnRLnYNiyy3ZfPOouXryp4
zLpH7cqKVxp+MRMXjyh4vA1RjYe3CIbwCuzdwgw/Fnc8Fbi66nZh07shGJzHVDip
clONonCw3AQ=
=/46t
-----END PGP SIGNATURE-----

--R4+EwJQA1QUEuvQX--

