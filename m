Date: Mon, 21 Jan 2013 14:23:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130121132330.GA22465@...1296...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
	<1358411009-2350-4-git-send-email-steffan.karger@...1435...>
	<50FBEC82.2050503@...68...>
	<1CED409804E2164C8104F9E623B08B90133FB458E5@...1436...>
	<20130121102317.GV22465@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ne8SEKon5qflbTg/"
Content-Disposition: inline
In-Reply-To: <20130121102317.GV22465@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Ne8SEKon5qflbTg/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

just for the sake of those not following the discussion on IRC...

On Mon, Jan 21, 2013 at 11:23:17AM +0100, Gert Doering wrote:
> I'm more concernced about maintainability of the OpenVPN code base, and
> having more #ifdef in there is not the way forward.

... we have now come to some sort of conclusion on this:

 - 2.3.x will support PolarSSL 1.1 and 1.2, to help people building OpenVPN
         with PolarSSL on distributions that ship 1.1

 - 2.4.x will drop support for PolarSSL 1.1, to simplify the code

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ne8SEKon5qflbTg/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUP1BUqkuBuNlUUl1AQKhLgQAhK0adbo12SBQbV1JKo8Njr+/MiAsTx7F
I8qJiBKDEcquIsA0h5YA82+X64sif/t96vW+5f7+a8jDyhkb39y0+DPG91pQtAQM
m59GnohrBdutKyJHwvwc2vFhARauBEwxbwNBBYnVTQWPh/X4Y6sAL3RT/0QwbPSD
LoSiMJdBLms=
=i17t
-----END PGP SIGNATURE-----

--Ne8SEKon5qflbTg/--

