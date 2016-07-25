Date: Mon, 25 Jul 2016 22:04:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160725200452.GE78279@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hjg+pC/5+IEur/Yc"
Content-Disposition: inline
Subject: [Openvpn-devel] use of --cipher with no arguments?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--Hjg+pC/5+IEur/Yc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

has anyone ever used "--cipher" without an argument?  If yes, what is the
intended usage?  It sort of "tells openvpn we want crypto!" but does not
go into detail about it...

Normally, this would just be a random weird option, but I ran across

  --cipher none --cipher

which first tells openvpn "nah, we do not want anything!" and sets
a pointer to NULL, and then tells openvpn "but please *do* use the
ciphers already setup!", which core dumps.

This is not remotely exploitable, so not a *security* issue, but a bit
stupid nonetheless - so I propose we just throw out "--cipher" with
no arguments (--cipher none, or --cipher bf-cbc would, of course,=20
continue to work).

Anyone having a good argument against it?  JJK, do you happen to know
what this is about?

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Hjg+pC/5+IEur/Yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV5Zw46kuBuNlUUl1AQKV2wP9E5rRgw2P2ZvTwGkAhUBNIrsTEsnlpc8c
NfCpFW+rFrUsj7kTslcVgDZmmhBE5TsOYLceECIqI/cWjFpotvXQvsfpSir/TrYf
kgHiP8W6nvCVfn5FSjSq6WCDnSDnNG5GGPYUTYjeOjOJ/ssHLfCX/aR6oR3DFApq
4QxOq2apIE8=
=emX4
-----END PGP SIGNATURE-----

--Hjg+pC/5+IEur/Yc--

