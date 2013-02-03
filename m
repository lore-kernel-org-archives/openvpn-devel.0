Date: Sun, 3 Feb 2013 12:50:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130203115051.GN953@...1296...>
References: <510D3B74.3060007@...1114...>
	<1359889951-3369-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <1359889951-3369-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove dead code path and putenv
	functionality
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

--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sun, Feb 03, 2013 at 12:12:31PM +0100, Arne Schwabe wrote:
> The construct_name_value function call will always fail so this code path=
 is never used. Since we now always have a valid environment in static_cont=
ext->c2.es it is better to have a ASSERT(es) than to call this code patch.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

After some discussion, we (Gert, David, Arne) agreed to do it this way (ACK=
!)

 - *if* we reach this point with es=3D=3DNULL it's a bug, and we should
   assert-crash in a way that makes it obvious where the real problem
   is, and not "3 levels down in the buffer code"

 - the offending code path was in the Android branch and does not affect
   the "git openvpn" - but if we have more offending code, we want to
   known, instead of silently ignoring it.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUQ5PG6kuBuNlUUl1AQLjoQQAmjlzRplpN8XzXV1Sq56t1lm8Qp3yOH7I
N7LYII9eG2rGIbpJAx8I7sTeINO9NHMQKoJuFvmjlrXGPYOu4VarPglFS3qyB9Qz
//3+I2w/ZXGXIKqDieFg6PC3Kxx88RHlclkviJ51O8isjKSLdiWLKQ3Tq6lRgWHW
BPoLU2f/PTQ=
=m5+4
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

