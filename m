Date: Fri, 22 Jun 2018 11:39:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180622093917.GH57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="L+CNnuwY89phXYPb"
Content-Disposition: inline
In-Reply-To: <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--L+CNnuwY89phXYPb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Fri, Jun 22, 2018 at 03:27:02PM +0800, Antonio Quartulli wrote:
> The failure is reported as:
>=20
> TUN: adding address failed using service: The parameter is incorrect.
> [status=3D87 if_index=3D42]

This is surprising.  I initially assumed that this is related to IPv4,
but we do not even use the service for IPv4 today...

This *might* trigger something that the iservice logs to the windows
event log - so it might be worth having a look :-)

gert

PS: as a side note - with XP and Vista dropped, we might consider ripping
out every win32-api besides IPAPI and iservice, for 2.5...

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--L+CNnuwY89phXYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbLMPFAAoJEB2Cnv7KVigSaGgMAJ6YL92+HHP1FzGlmFD9cLsA
G5bHiO+4NQn/usL/12SckoQzPPBnSGasn5zpjz/elmVyZBBxwXU+0dC4v3bRM99X
znIW8411iUzN6l74BzvZNTjlyyuckAleKdQJFPaX+K/Cklk1vIo5+hJCi/ReA2gB
TQ6YxUFJHiukVQR1PSuJSkK0xEXMtMWkqGyTJ2BWIbaNYMRXl6LpdlnixDVdRpMA
6ZVR/oWJsFK+Y5ndNIqrdBldHDbm5on8wD7pNtWHXCKNoU9vjlB+pWBVK9ctSYTZ
XjGZ6KqQBiYBg2/ArzjQwZ+4k5ZJLTLaLX4WQeeWA0Ckeef6WbMkLtKGXoWA+tXY
ns2PlK4yG3yS9RnR5I89qGg6wvvSZE2AwRq0Cbv2+pav+LhG1kWICFmtsdOTJrsP
hRMDzpsdWGy0INd2S3ACwaf7OVo17/iQZE1Hu2Flm2Y0MIm5WcFqrkywm0Z3sYeB
bv3e9Ljf4M0x6Hzfge8Jj97xsT44iD3d96ltcXmp9A==
=Ksws
-----END PGP SIGNATURE-----

--L+CNnuwY89phXYPb--

