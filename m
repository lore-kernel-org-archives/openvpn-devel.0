Message-ID: <20110313160421.3004.qmail@...1287...>
Date: Sun, 13 Mar 2011 17:04:21 +0100
From: Peter Stuge <peter@...1287...>
References: <4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
	<20110313142200.GJ9835@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20110313142200.GJ9835@...1296...>
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

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gert Doering wrote:
> > Changing startup scripts or wrapping openvpn is one way. But I would
> > probably drive everything from the DHCP client instead.
>=20
> udhcp can notify components if the IP address of a PPP(!) interface
> changes?
>=20
> "No DHCP involved on PPP links".

Was this for PPP? Sorry then, I completely overlooked that! I'm
fortunate to not have to deal with many PPP links now, but I have,
and pppd of course /etc/ppp/ip-up and -down where the same info about
(de/re)config is available as in the udhcpc script.


//Peter

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFNfOsFhR3Q0dhIfEgRAthMAJ983yumc/GCe4ZL3TPxpm/cjdrTggCfXRFT
R4t7dF5A/L/1fKprlTL++2U=
=FVv0
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

