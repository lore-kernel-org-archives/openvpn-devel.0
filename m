Date: Tue, 9 Sep 2014 22:20:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140909202044.GJ1118@...1296...>
References: <1410283573-17933-1-git-send-email-openvpn.list@...1114...>
	<1410283573-17933-2-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V1nQ7g5Otmh+S4jv"
Content-Disposition: inline
In-Reply-To: <1410283573-17933-2-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Don't try to use
	systemd-ask-password if it is not available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--V1nQ7g5Otmh+S4jv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Tue, Sep 09, 2014 at 07:26:12PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> If the SYSTEMD_ASK_PASSWORD_PATH executable cannot be found, we
> don't consider systemd as running.
>=20
> [v2 - Don't clean up white-space]

ACK, useful functionality, code looks good.

Not tested, no systemd here :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--V1nQ7g5Otmh+S4jv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVA9hHKkuBuNlUUl1AQIyPAP+PIoWkW3srKHdBx3Q7v0qRhs9/VpCLZth
hu3G1zzKq4IMySAyOpicUGl3flpfD9WngfYL9Reqjqs/t+mt2EbcOqz1yQsIVAqa
jqJb2J+Kiy4YocZ8Pd2UpoyRsyQ4QSgpzUwJAbGAA3SUbAGlLQ49xdeR02IcS0FZ
WNouX4Vj67c=
=O1z6
-----END PGP SIGNATURE-----

--V1nQ7g5Otmh+S4jv--

