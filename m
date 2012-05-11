Date: Fri, 11 May 2012 21:22:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120511192237.GB1359@...1296...>
References: <CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AD6@...1436...>
	<4FAB8EEE.8020607@...1114...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D08@...1436...>
	<CAOazyz1u-WhMYD5VykW2nzLyJzWr8-8wJ3pqwCMBwqggkpbLiA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D3E@...1436...>
	<CAOazyz30FaAPsha7hyD9cAwvRWkq_4i9Cme0mFJDpX0VdSb7=w@...278...>
	<4FABDBF7.406@...1114...>
	<CAP+U6tK5a-QFW1+=B-6AOTa3nqHheETs9mSuLMGmUQ5WS+c3vw@...278...>
	<4FAC3C2C.7020504@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MXx7bYznQPnb5eTe"
Content-Disposition: inline
In-Reply-To: <4FAC3C2C.7020504@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--MXx7bYznQPnb5eTe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 11, 2012 at 12:07:40AM +0200, Arne Schwabe wrote:
> * Openvpn for Android is the first platform which does allow non CIDR
> routes (I think). In my port I print a warning in the GUI if I encounter
> something stupid like 10.0.0.0 netmask 255.0.255.0. The same goes the
> netmask of the ifconfig command.

I don't think we can really support that anyway - the IETF has deprecated=20
this sort of netmasks in RFC1519 (introduction of CIDR, section 4.2), and=20
all major operating systems do not support it anymore.

So the server side would not be able to handle that, unless running
on Android as well...

I'm not sure whether the openvpn code currently enforces it, but I
*am* sure that it will explode on Linux and FreeBSD as soon as you=20
try to actually ifconfig/route such networks.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MXx7bYznQPnb5eTe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT61m/akuBuNlUUl1AQJzJwP/U3RPOWzL/1CUNhiGHi1bd/9UYRSwv4EW
6RJ1vFW7PCm9CtVGQJ3wk/W6gsRKMVleH7oVt19QJucX4x9QZVMbNYGO2Zg7DmzR
NOeLs/ycRRF3meQSX65Dnrxw7Tz9vR3etp5l/a+ZMLCRc8fcyJS1sP9fDbGuQgzc
UYr3lLe9Ukk=
=ZWuN
-----END PGP SIGNATURE-----

--MXx7bYznQPnb5eTe--

