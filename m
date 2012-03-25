Date: Sun, 25 Mar 2012 13:15:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120325111517.GI1359@...1296...>
References: <1332616557-15727-1-git-send-email-alon.barlev@...277...>
	<CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
	<CAP+U6tKTRJ8ybhd9xgyZrj0vDXPFAk+=r=Ai46sUjDsio3bsgw@...278...>
	<CAOazyz1odoeRyG5UxvsNehdwWdUpJ+kJmuiaoiLD8T-Ht7nTcw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WFYXJKyHTUiGqOmp"
Content-Disposition: inline
In-Reply-To: <CAOazyz1odoeRyG5UxvsNehdwWdUpJ+kJmuiaoiLD8T-Ht7nTcw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: rename bool->obool
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

--WFYXJKyHTUiGqOmp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 25, 2012 at 01:10:45PM +0200, Alon Bar-Lev wrote:
> However the flags modifications from [1] should be merged anyway, I
> will submit a patch.
>=20
> What do you think?
>=20
> Thanks,
> Alon.
>=20
> [1] https://297854.bugs.gentoo.org/attachment.cgi?id=3D214304

I strongly support that.  This really is used as a bitfield, and not as
a boolean, and should not be labled "bool" (and this is independent from
the bool/obool/stdbool discussion).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WFYXJKyHTUiGqOmp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT27+RakuBuNlUUl1AQJ5owP/anNFb0giNtMTwg2dCSEcb1KcQDrIuyCQ
yc+8xwn4A3STd4OwAskoXUCaiV5oLHA8ATR2HLSjVw0NgsthQoMRTT4w5OQR7C8N
Ny/EdBX282D07FZaqfQm7qEWHJpIdoo7cqVvUYV/XV5ub4+6wiwKGcARNA5cQ6LN
1IQj+8EE3Gw=
=I3tO
-----END PGP SIGNATURE-----

--WFYXJKyHTUiGqOmp--

