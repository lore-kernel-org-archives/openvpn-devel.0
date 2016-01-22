Date: Fri, 22 Jan 2016 19:40:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160122184057.GA24952@...1296...>
References: <DUB128-W60F62990DBFD2EC2BC4D0ECAC30@...512...>
	<56A1F97C.6090104@...1147...>
	<DUB128-W764F41588D1CF8492B79BFCAC40@...512...>
	<56A23EDA.3030304@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DGlGf2de1haeuwCK"
Content-Disposition: inline
In-Reply-To: <56A23EDA.3030304@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] TLS Warning: no data channel
	send key available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Dreetjeh D <dreetjeh@...160...>, openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--DGlGf2de1haeuwCK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

copying in the -devel list, as I see some portability patch coming...


On Fri, Jan 22, 2016 at 03:38:18PM +0100, Jan Just Keijser wrote:
> crypto_adjust_frame_parameters: Adjusting frame parameters for crypto by=
=20
> zu bytes
>=20
> "by zu bytes" ?!?!?!? Can you try it without compression?

sounds like someone used %zu in printf() and the C library in question
doesn't understand that...

crypto.c:  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %=
zu bytes",

we used that in two places

crypto.c:  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %=
zu bytes",
ssl_polarssl.c:      openvpn_snprintf (s2, sizeof (s2), ", %zu bit key", pk=
_get_size(&cert->pk));

... stackoverflow claims this is the right thing to do for a size_t

http://stackoverflow.com/questions/15610053/correct-printf-format-specifier=
-for-size-t-zu-or-iu
http://stackoverflow.com/questions/2524611/how-can-one-print-a-size-t-varia=
ble-portably-using-the-printf-family

... but that this is C99 and Visual Studio 2010 does not support it - so
maybe it's not so much the "Visual Studio" bits but the C runtime on=20
Windows - thus, this code misprints in the windows binary...

Someone else should test that :-) - and then we might want to convert
the line in question to use %u and add an (unsigned int) cast.

(I seem to remember having discussions with Syzzer about %zu, and I did
recommend to do the casting back then already - but that was a different
part of the code)

As far as the original issue goes: that is just an informational message
and not printing this should be totally harmless.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DGlGf2de1haeuwCK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqJ3uakuBuNlUUl1AQKgmwP+MxGh9FPwiwbh+ODTK1ybD1NGiUJn0fIK
j07BJLo3ykzGcDkyBQGls5rse7iBaQ7eR1SoGKUT1OkFTlfPpaAMaDztGQ9OTGT+
yjSPatgkYoDT9M/iAj693WsKxvQ/CN0dqENfAf1jUDcv1NADl25MKtkOwofaPg6W
hmfelBR1NhE=
=EUqE
-----END PGP SIGNATURE-----

--DGlGf2de1haeuwCK--

