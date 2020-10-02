References: <20200927233224.2859-1-themiron@...2010...>
 <20201001225319.25125-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <23a5b4be-f488-058f-7005-19073db14813@...1227...>
Date: Fri, 2 Oct 2020 10:39:32 +0200
MIME-Version: 1.0
In-Reply-To: <20201001225319.25125-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RvUFOetNvhgQdv2uGf25PMCxfhqgAsbD8"
Subject: Re: [Openvpn-devel] [PATCH v3] Speedup TCP remote hosts connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RvUFOetNvhgQdv2uGf25PMCxfhqgAsbD8
Content-Type: multipart/mixed; boundary="SxW5Cvx8eJZsNHxzDB963ZpwIRR1nEyVZ"

--SxW5Cvx8eJZsNHxzDB963ZpwIRR1nEyVZ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 02.10.20 um 00:53 schrieb Vladislav Grishenko:
> For non-blocking TCP/Unix connection, OpenVPN checks was it established in
> loop and if not - sleeps or handles management for next one second. Since
> the first check is made right after the connection attempt, it will likely
> be always unsuccessful, causing redundant wait for one or more seconds:
>=20
>     00:00:00.667607 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) =3D 0
>     00:00:00.667713 connect(5, {...}, 16) =3D -1 EINPROGRESS (Operation n=
ow in progress)
>     00:00:00.667832 poll([{fd=3D5, events=3DPOLLOUT}], 1, 0) =3D 0 (Timeo=
ut)
>     00:00:00.667954 nanosleep({tv_sec=3D1, tv_nsec=3D0}, 0x7fff52450270) =
=3D 0
>     00:00:01.668608 poll([{fd=3D5, events=3DPOLLOUT}], 1, 0) =3D 1 ([{fd=
=3D5, revents=3DPOLLOUT}])
>=20
> After this patch openvpn_connect() will perform blocking wait for connect=
ion
> establishment (if possible) and just check for management events once in =
one
> second (if management enabled) w/o sleep. This speedups TCP/Unix connecti=
on
> establishment and provides almost real connection time that can be used f=
or
> detection of the fastest remote server in subsequent patches:
>=20
>     00:00:00.790510 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) =3D 0
>     00:00:00.790616 connect(5, {...}, 16) =3D -1 EINPROGRESS (Operation n=
ow in progress)
>     00:00:00.790877 poll([{fd=3D5, events=3DPOLLOUT}], 1, 1000) =3D 0 (Ti=
meout)
>     00:00:01.792880 poll([{fd=3D5, events=3DPOLLOUT}], 1, 1000) =3D 1 ([{=
fd=3D5, revents=3DPOLLOUT}])
>=20
> Or, with management interface enabled:
>=20
>     00:00:00.906421 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) =3D 0
>     00:00:00.906527 connect(6, {...}, 16) =3D -1 EINPROGRESS (Operation n=
ow in progress)
>     00:00:00.906779 poll([{fd=3D6, events=3DPOLLOUT}], 1, 1000) =3D 0 (Ti=
meout)
>     00:00:01.910418 poll([{fd=3D3, events=3DPOLLIN|POLLPRI}], 1, 0) =3D 0=
 (Timeout)
>     00:00:01.911365 poll([{fd=3D6, events=3DPOLLOUT}], 1, 1000) =3D 0 ([{=
fd=3D6, revents=3DPOLLOUT}])
>=20
> v2: cosmetics, decrease connection_timeout to avoid wait more than it
> v3: teach management_sleep() to handle zero timeout and reject negative
>     use 1s timeout for connection and 0s timeout for management events

I like this version much more. It doesn't add extra complexity.

Acked-By: Arne Schwabe <arne@...1227...>



--SxW5Cvx8eJZsNHxzDB963ZpwIRR1nEyVZ--

--RvUFOetNvhgQdv2uGf25PMCxfhqgAsbD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9250QACgkQFRhsZwKx
RFTpGg//UrScVJOS15aAakb6+aAOLP8Sviq8UM3fe5h2Qw0rzGUuVb+EbGMPcJaT
GtBikz493oL//y+EuUKTNsLjZqz2QGB8Gsq6ckR/8RaGyW+2alKGAKCE6przd7IF
uYN2hZGYPopWFV0ZzC8WFOaw7A5JSot+aldfV4/yg4MX+1qOZlxdR+RVEtnhl+fI
4BHM4HBeepVgYgKShMmPM9hql+ARyqoz/ghMGRAsQSH1TJeLPw2wxWK8Y5RlATbG
1hn2jGfuWH2jC5UqaONrXkd65xDf7MXSushV3G0ZQ4mtxPW0FEIYeO2GB4uNfS6k
QftOdKVFdv+uWXyLRB9ur7yUnj3wyDRFXdXgz3b2qSTcFdEIIsfc8gfnOt3wgknY
v3Zgrm3d/FcQnfokyaiPWdC01F86gCs/Wo9Fou/qIpD/Zyfoz1ov9+/GLrtkMnYP
19VikQLwDvlfUMAFVL1/HNVpuL/erCSSOToGqpDJzApTkQewbyemL+0UOyOsb375
0rIMUB2xyO/3COV79TvkHalTPHVIAuRzY6emNN04nSdPQQO0eIuuGgSUwhfkiOri
sy0O/60WEftuXg/UwcRw1HykTaIsRtGXhM+uP1IZ57Ym/O5b0wSGuCb1js1wTXkq
OCW40ungcUxhXP7bWziumYxBVKEa+Pw4ecwsVjqrDqvxKT1bwlo=
=RJnz
-----END PGP SIGNATURE-----

--RvUFOetNvhgQdv2uGf25PMCxfhqgAsbD8--

