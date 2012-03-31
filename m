Date: Sat, 31 Mar 2012 21:28:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120331192849.GX1359@...1296...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-4-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/zsoNCA59QYBHZ5b"
Content-Disposition: inline
In-Reply-To: <1333012602-5419-4-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] cleanup: avoid using ~0 - netmask
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--/zsoNCA59QYBHZ5b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 29, 2012 at 11:16:41AM +0200, Alon Bar-Lev wrote:
> Use IPV4_NETMASK_HOST constant.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>

ACK on this one, to start with.  Thanks.

The others I'm just looking into, but need to read a bit more code
around to see whether I fully understand what that code is doing
(it "looks harmless enough", but signed/unsigned issues tend to do that)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--/zsoNCA59QYBHZ5b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3da8akuBuNlUUl1AQJkWAQAi7twn49ivVfZTc2LpzBQKiP9/MOBn98s
x/p4Zrz+Y3QcrHzSA/Fwj7wIEcrg48kgy83Vm2lBqshOOU6LkWAHGRyTiEZoizHR
ycyllX7iYJdJb+LAxbx2TWNR90teoDANEILp05InQeCgdMqQagWGtME3kklOf0hF
TLJ2GtHQYl4=
=xeQY
-----END PGP SIGNATURE-----

--/zsoNCA59QYBHZ5b--

