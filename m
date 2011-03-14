Date: Mon, 14 Mar 2011 09:38:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110314083845.GL9835@...1296...>
References: <20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
	<20110313142200.GJ9835@...1296...>
	<20110313160421.3004.qmail@...1287...>
	<20110313173833.GK9835@...1296...>
	<20110313231620.12432.qmail@...1287...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
Content-Disposition: inline
In-Reply-To: <20110313231620.12432.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--7kW37LRKoI6fR2de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 14, 2011 at 12:16:20AM +0100, Peter Stuge wrote:
> > - or try to understand why this is needed in the first place :-) - I st=
ill
> >   don't understand why not binding to anything + --multihome isn't work=
ing
>=20
> Third time: Multiple openvpn daemons on different interfaces and same
> port.

That's one possible use case, but not how I understood Federico.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTX3UFakuBuNlUUl1AQJO9wP/Wfx8y5hYi7jldKNLHSp3fniCDRa3cWAY
z+Xx2gVrksmU9+Ze+rvH+RfFW87HSN++eeGSbobMGksPQ7ijmFghp2LA+ikptJ23
ilvB7BQiUk790cZnUcYqXfZOI0bftxQVD4AM9YmZ377kcsBgmHCoqWD5bgVxcmLr
GpNSRpYett4=
=gmCU
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--

