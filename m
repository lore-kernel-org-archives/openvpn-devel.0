Date: Thu, 10 Apr 2014 10:15:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140410081524.GK16637@...1296...>
References: <20140409232527.GA3061@...1890...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ke9YV3RCe64GoSnw"
Content-Disposition: inline
In-Reply-To: <20140409232527.GA3061@...1890...>
Subject: Re: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cedric <cedric+openvpn@...1891...>
Cc: openvpn-devel@lists.sourceforge.net

--ke9YV3RCe64GoSnw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Thu, Apr 10, 2014 at 01:25:27AM +0200, Cedric wrote:
> I get an error on latest release 2.3.3 (and previous ones), on windows 8.=
1.

How I hate windows...  the very same netsh call is working perfectly fine
on XP, Vista, Win7 (no idea about 8, won't touch that).

As I have *so* no time to test on all these windows versions - could=20
someone verify for me that the "netsh int ipv6 delete..." call will
work fine with "store=3Dactive" on all the older platforms as well?  Then
I could do a 2.3.4 with that change fairly quickly...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ke9YV3RCe64GoSnw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0ZTHKkuBuNlUUl1AQIzwwP/eiN2zQzrBoIKGD8R/oSDvO1wlintaWI4
RJjQ51B4tov3xFOlISoFLttLwoVUThUjv1yuYOKAKwCL8r2v/uN5K72Y8e+P8Ebo
2OL5+9seGvKjfoKyqzfUx2VJtj8RUuyCB2jamCds3ovT5X/3LurTDFmiwht48d59
ANdfioJvC5E=
=OhND
-----END PGP SIGNATURE-----

--ke9YV3RCe64GoSnw--

