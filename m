Date: Thu, 23 Oct 2014 21:28:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141023192811.GU396@...1296...>
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIUK9dbftDTPhBGO"
Content-Disposition: inline
In-Reply-To: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
Subject: Re: [Openvpn-devel] man page and options.c contradict
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Reinoud Koornstra <reinoudkoornstra@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--oIUK9dbftDTPhBGO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 23, 2014 at 01:24:45PM -0600, Reinoud Koornstra wrote:
> The idea in my case is to have a point-to-point connection where both hos=
ts
> listen on port 443 tcp instead of port 1194 udp to setup the point-to-poi=
nt
> connection.

If both listen, who calls out?  In TCP mode, you need to decide who opens
the tcp session (tcp-client) and who listens (tcp-server).

In UDP mode, the socket is not "connected" so you can just send packets
when you feel like it, without having to establish a connection first.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oIUK9dbftDTPhBGO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVElWyqkuBuNlUUl1AQI8CAP+IbCcztIWOV4cDMuXE1+/V0wBH12nSFI6
7RSukzgbO6qi5NH3+8FUjZ4YQfiakgQ7ROSBB2wMLwEgMsev2cDrY1UlkluzouEO
9LYeCZCps6ojOEtH4ydZHEd0kRutQCcqkxmIOcFFb55kXhXiANe9oG4Iv9VIK+1L
1OPb/+TeSs4=
=Og0i
-----END PGP SIGNATURE-----

--oIUK9dbftDTPhBGO--

