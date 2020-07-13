Date: Mon, 13 Jul 2020 08:12:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713061211.GL1431@...1296...>
References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <bfe83365-35a7-efb8-b243-0aa3178e6e6f@...1823...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tnpIl01xSPNY70xa"
Content-Disposition: inline
In-Reply-To: <bfe83365-35a7-efb8-b243-0aa3178e6e6f@...1823...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: dm <dm@...1823...>
Cc: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--tnpIl01xSPNY70xa
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 13, 2020 at 10:07:38AM +0400, dm wrote:
> Forgot to add info from server console, last messages=A0 are:
>=20
> 2020-07-13 10:04:41 us=3D435946 10.1.1.17:53148 WARNING: 'version' is use=
d=20
> inconsistently, local=3D'version V4', remote=3D'version V0 UNDEF'
> 2020-07-13 10:04:41 us=3D435976 10.1.1.17:53148 WARNING: 'dev-type' is=20
> present in local config but missing in remote config, local=3D'dev-type t=
un'

Yeah, it's "no OCC and no NCP".  Should be easy to reproduce here.

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tnpIl01xSPNY70xa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfC/s6AAoJEB2Cnv7KVigSq/4L/3mzvLsibBjDeRYNcLbQD6AV
FbRmjUkNrXbanx2PvPAwsVUR3UpHqTLOf0N7KJUC+kjzTFYjQkBIyxSsT8lMOYTU
3nwGCoDe2kka8h2BC0F0GpZewpGaGUkSblfGwpINljhi/TiEHMmyi0Y+4qhMm8RF
yW9PbEZP3mycRAN5GPuYd6e5P+U5Oxo9VnJnJzeqL/SBFtRBRqsFhe+Gyi08rKz8
nCoKys1Biet1DQiZUxAxYBh2kUJRk++nESUIQ5+xapymUkU0TynZURfY4xRAxk85
mgvtRiiUh49FCwtatKy/S0t700HSyoPyXpldL5qkEJ3H/yTCFpnv935+WJ9OymZ9
qXeoYe7+uVRlhEZ29oKpVl1o1NAmnfR+VhyBI0NFSFc91wgiAW83Ffk59JObOhMV
Yjpa6If/lAVWjXEbFCwS0OReUjVrqJkgwp4CJb6YmRBKo5M15Z4NpNEf9xCIV5fj
wTz0SINGxOJZkAjPYyFr/x7UEaz3Vzffs2QS7ah2qA==
=yDjC
-----END PGP SIGNATURE-----

--tnpIl01xSPNY70xa--

