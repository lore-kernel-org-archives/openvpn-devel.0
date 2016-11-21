Date: Mon, 21 Nov 2016 20:54:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161121195429.GS28918@...1296...>
References: <CAFHpkQFdwy++P48HOOAeEO8fKr8uc6y-en0z73JtoOMO1c4q7Q@...278...>
	<20161116183502.GK28918@...1296...>
	<CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
	<CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iMU/nSpl9Pdc6PQZ"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--iMU/nSpl9Pdc6PQZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 22, 2016 at 12:51:21AM +0500, ???????? ?????????????? wrote:
> > I tend to de-couple this - what about a second checkbox "launch gui now=
"?
>=20
> I like the approach of starting services:
>=20
> https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn=
.nsi#L540
>=20
> if there's a service, ok, start it, why to ask user ?

We do *not* want to start openvpnserv2 or legacy openvpnserv unless
explicitely told - but we need the interactive service.  Quite a bit
of difference.

> the same with gui. if user selected to launch it automatically, why wait
> for reboot ?

"Choice"?  Admin might be installing a laptop but a user will use openvpn
later on...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iMU/nSpl9Pdc6PQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDNQ9KkuBuNlUUl1AQKkowP+NXPqRgoFaaeFSrQYIgDrgSqDCVRbHDx0
DXAD9tpJTOTOv2uuvGXHvPQkeiIJq0E0UW6Wipzicq3fVBBn2M7rkTPFScEN09rD
+XdXV+GHgdIW6TwkpQMle+fnPJe01QNfmXaPcMD12zUJlyDldJczW5zVNg7njZPM
6XIqvEYF6HI=
=RGu4
-----END PGP SIGNATURE-----

--iMU/nSpl9Pdc6PQZ--

