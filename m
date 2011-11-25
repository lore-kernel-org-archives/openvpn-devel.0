Date: Fri, 25 Nov 2011 16:32:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111125153226.GX8496@...1296...>
References: <20111125083853.GU8496@...1296...>
	<1322218679-4946-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f9Z9yV3RCGllhmgZ"
Content-Disposition: inline
In-Reply-To: <1322218679-4946-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix bug after removing Linux 2.2
	support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

--f9Z9yV3RCGllhmgZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 25, 2011 at 11:57:59AM +0100, David Sommerseth wrote:
> This patch changes the msg() declarations to use the M_FATAL *) flag,
> which will halt the execution of the program in these error sitauations.
> As the program will really halt, the return declarations was also removed.

ACK.

These really are fatal errors and there is no use in going on.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--f9Z9yV3RCGllhmgZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTs+1CqkuBuNlUUl1AQIGGAQApgU8log6alPJ7VfCVaDKCS+CpR3ipmu0
/TS1E+btOBYmWpNBHtxhptALX4WABhI1if7VLH8spAGp3qjoDviayaozue0zcaCP
2mCLGdW3dHslatQu6gH5TZ1rCBB1Ms115x8AvCqcVM/EZu8VY4+Jylc7MXek+HQj
E842K+6XJZo=
=fTQs
-----END PGP SIGNATURE-----

--f9Z9yV3RCGllhmgZ--

