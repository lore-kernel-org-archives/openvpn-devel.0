Date: Fri, 11 Nov 2016 08:58:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161111075846.GY28918@...1296...>
References: <1478609729-25222-5-git-send-email-samuli@...515...>
	<1478613043-27033-1-git-send-email-samuli@...515...>
	<68076cb3-b018-28c7-0776-85f8a7212e38@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOApBOWN8PWHaZPG"
Content-Disposition: inline
In-Reply-To: <68076cb3-b018-28c7-0776-85f8a7212e38@...277...>
Subject: Re: [Openvpn-devel] [PATCHv2 4/4] Allow passing extra arguments to
 fping/fping6 in t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--OOApBOWN8PWHaZPG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 11, 2016 at 12:25:49AM +0000, debbie10t wrote:
> On 08/11/16 13:50, samuli@...515... wrote:
> > From: Samuli Sepp=E4nen <samuli@...515...>
>=20
> > +	$cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist >>$LOGDI=
R/$SUF:fping.out 2>&1
>=20
> This allows $FPING_EXTRA_ARGS to take precedence over previous arguments
>=20
> eg: $FPING_EXTRA_ARGS =3D "-C 1000 -p 1000 -i 1000"

Right, which was the point of "v2" :-) - it's a good way to shoot your
own foot, but this is an "expert mode knob".

> This does not:
> $cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist=20
> $LOGDIR/$SUF:fping.out 2>&1

Right, which was v1.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OOApBOWN8PWHaZPG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCV6NqkuBuNlUUl1AQK/EwP+I+AEWce+QQfdKzbF0wBSlloVU+qoi1NG
vlYcOIVnf5WUDf6yKbwphJ1hWVp3CbDqVEhFZNM48EqgGtskeHHu7WJvfLkqyT2G
mWwQzkhlxrWye70/C0q6+fCzpbCTK04nrlutwv/0X2vCTK3mr9ktdGTe4rMSV3zu
EfjXFQc21GI=
=NgYY
-----END PGP SIGNATURE-----

--OOApBOWN8PWHaZPG--

