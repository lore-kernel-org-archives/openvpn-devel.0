Date: Wed, 14 Dec 2011 19:27:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111214182700.GX18948@...1296...>
References: <1323882919-2145-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPxI8paQBs33t8dK"
Content-Disposition: inline
In-Reply-To: <1323882919-2145-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix compiling with --disable-crypto
	and/or --disable-ssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--PPxI8paQBs33t8dK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 14, 2011 at 06:15:19PM +0100, David Sommerseth wrote:
> The checks introduced in commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1
> didn't properly remove checks if crypto or SSL was disabled at compile ti=
me.

ACK.  Nasty #idef's, good that we have Buildbot to tell us :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PPxI8paQBs33t8dK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTujqdKkuBuNlUUl1AQI4UQP/ey13BCYCrzYdHq00drAwnKRKhSyrjqjl
fEYJoT72WHngnOKNWTWwd0sBdmBzIf9uoHe816GFBC+XCFFPZu31HaOHw2qiUXhw
JRTsosYfEAODiVeTuMcGBN18Vilae2dcS0ArPH/PjxrU3PoDqUCeyXTBW9IgnNCZ
9Pe40jzN7Pc=
=Vs7B
-----END PGP SIGNATURE-----

--PPxI8paQBs33t8dK--

