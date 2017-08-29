Date: Tue, 29 Aug 2017 21:16:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170829191638.GZ70062@...1296...>
References: <20170824133305.25604-1-a@...2181...>
 <20170824191848.GH70062@...1296...>
 <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>
 <f9727fce-bda2-e21d-c944-22b5b28f7629@...2181...>
 <6e449f4b-271a-f738-7ee9-f9120ed0e714@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XLbFcQSK8m6qgUdZ"
Content-Disposition: inline
In-Reply-To: <6e449f4b-271a-f738-7ee9-f9120ed0e714@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Antonio Quartulli <a@...2181...>, David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

--XLbFcQSK8m6qgUdZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 29, 2017 at 06:19:21PM +0200, Jan Just Keijser wrote:
> my biggest complaint about the so-called modern $() notation is that it=20
> clashes/confuses the heck out of me when using proper variable usage,=20
> e.g. I find
>    output=3D`${SOME_COMMAND} ${SOME_ARGS}`
> much better readable than
>    output=3D$(${SOME_COMMAND} ${SOME_ARGS})
>=20
> especially since you are allowed to **NEST** $() strings, IIRC. Things li=
ke
>=20
>    output=3D$(${cmd} $(${cmd2}))
>=20
> work, and in my view, thank god that you cannot do that using backtics ;)

well, yes, what you say :-)=20

(but I thought this was just my old age showing... having learned shell
scripting on a SCO Unix box, with only a *true* bourne shell installed,
no korn shell, no bash...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XLbFcQSK8m6qgUdZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZpb2VAAoJEB2Cnv7KVigSPVoMAITqb3bRlY81JOG9omVSw34e
oilv0LnUleZy9AVX1X67B98amTBl7zlYTEmX2hoI33LZJDIAGkjBWxHvFDcKe5Db
fZLmKM6/dPNlFN5Pp6tpgZ6xLariZX/T3O/kFhIJQd9pDEX/xQ7hTByACnmuxos9
HUztcYchtL+13usXXhGHIUBFMqE/Gr5cB92wtdW6CSBP+kgbCTTJCJiCxm42d4nT
TIoZECVgkLZX1jiGaSieaGaMlisiW1UicTifa55UlW/ser1XSFenhfKHo1PsOFxL
b/GDBEMGzq3/VAwcE79+q5mtMRc7fPPJeJgSwTxrutKJF6JCPaLtyxriRI44W2Px
xPX1ZVBCDZ9W2rdL0LXTkfpItyv18JAap5pKPcGcwRSNNSx9K+5dK7pktbUbBeXW
OVNZo6Wsa4kLq6djp0e6sFrsGEuAEYdcYwha4EtNoyloO9cxOE/mSqoZoU6j07mf
znVjrF30NeXoJ6JaVhIcVKLi3hQuV7vH10o/v+N+jA==
=8KQQ
-----END PGP SIGNATURE-----

--XLbFcQSK8m6qgUdZ--

