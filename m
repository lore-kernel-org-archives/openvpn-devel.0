Date: Sat, 11 Jun 2016 17:14:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160611151413.GS62247@...1296...>
References: <1442309019-7586-9-git-send-email-arne@...1227...>
	<1444919912-4432-1-git-send-email-arne@...1227...>
	<20160611121010.GR62247@...1296...>
	<0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Content-Disposition: inline
In-Reply-To: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
Subject: Re: [Openvpn-devel] [PATCH V2] Remove http-proxy-timeout,
 socks timeout and set default of server-poll-timeout to 120s
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 11, 2016 at 04:29:27PM +0200, Arne Schwabe wrote:
> Am 11.06.16 um 14:10 schrieb Gert Doering:
> > This check "c2.tls_multi" - is this a short form for "we're not a=20
> > peer-to-peer session"?=20=20
> >=20
> > Other parts of the code seem to check "we have --pull or we have=20
> > --mode server", so I wonder if we should make this somewhat more
> > uninform.  Eventually... :-)
>=20
> Actually tls session server session. Aka everything but server in p2mp
> mode.

Uh, what, "server session" or "everything but server"?  Now I'm totally
confused.

> I will send a v3 shortly.

Seen it, thanks.  Will have a go at it later.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1wqxakuBuNlUUl1AQK2igQAruka6C4hGFNsayJrLPfohusqwa2izaka
/sireXA/msu95jy15QWcUIhtNSDyMy3kKaGowVSxceDp2oJ4ISHQzjrYDS1pReGg
4KLsYO5iUwGJTVceilb6EbodTWnWVzk2gsB69wfPM+r1yjRyYp8kmjhSJydULoeO
V+45wm7DBps=
=QVGm
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--

