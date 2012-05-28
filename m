Date: Mon, 28 May 2012 09:52:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120528075212.GW1161@...1296...>
References: <20120527202737.GV1161@...1296...>
	<CAOazyz0LD6ykOFcxcRTvu95Sjkzcsg2+FxT7514Ki3+QW9Dbsw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TdMwOTenGjBWB1uY"
Content-Disposition: inline
In-Reply-To: <CAOazyz0LD6ykOFcxcRTvu95Sjkzcsg2+FxT7514Ki3+QW9Dbsw@...278...>
Subject: Re: [Openvpn-devel] build revolution lost t_client test?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--TdMwOTenGjBWB1uY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Sun, May 27, 2012 at 11:36:57PM +0300, Alon Bar-Lev wrote:
> t_client.sh requires root/sudo privileges.
> "make check" should not assume any special privilege.
> Because of this it is removed from "make check".
> You can still run this by hand or we can add special target such as
> "make root-check" or similar.

There was agreement by the developers to *have* this, and no explicit
agreement to *remove* it - you got an ACK for the patch, but I'm fairly
sure that it was not made clear that you removed t_client.sh functionality
while moving stuff around, because otherwise you would have seen NAKs.

If someone wants to run it as non-root, RUN_SUDO can be defined in=20
t_client.rc, and for someone having no provileges at all, you can just
leave off t_client.rc, and it will skip these tests with no adverse
effects.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TdMwOTenGjBWB1uY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8MurKkuBuNlUUl1AQI+IgP/fZtTuGNqbggr/+wOpPPgO+wZ37JUSKU5
wSqfVxu2xRaE/Bmlc2Ttg6FAO7ZzG6vI/DlxlFnAmSJc8D/qY+ToaeDVtktB/RXM
dRW3wRflPcZtQID4wmwElmjt7rWXHwSHJu2rOTC47wgOQIGraDvMsm/0lDESUHil
bGHABN1Quzo=
=nO0f
-----END PGP SIGNATURE-----

--TdMwOTenGjBWB1uY--

