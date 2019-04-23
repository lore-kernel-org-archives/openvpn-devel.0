Date: Tue, 23 Apr 2019 17:56:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190423155655.GU31008@...1296...>
References: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
 <CAKuzo_i3xee94jgGBZFgcpXkU5eZuQrbrVO09+Fbp7ApX1rn2Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="42/8TDB0GUY6FXEm"
Content-Disposition: inline
In-Reply-To: <CAKuzo_i3xee94jgGBZFgcpXkU5eZuQrbrVO09+Fbp7ApX1rn2Q@...278...>
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 installers with tap-windows6
 and other componets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--42/8TDB0GUY6FXEm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 23, 2019 at 11:50:28AM -0400, Selva Nair wrote:
> On further tests, one issue is that tapinstall.exe now depends on
> VCRUNTIME140.dll which is not present in stock Windows. Probably
> that's what causes the failure.

Sorry for that time bomb.  Samuli found the reason today (build
defaults to "dynamic linking" now) and has fixed it.  New installers
coming up RSN...

13:04 <@mattock1> more visual studio project tuning I guess
13:24 <@mattock1> <UseOfMfc>Static</UseOfMfc> seems to resolve the issue
13:35 <@mattock1> yes, looks good, quadruples tapinstall.exe size to 400k
...
13:57 <@mattock1> all tapinstall.exe architectures statically linked based =
on=20
                  4x size :)
...
14:53 <@mattock1> smoke-testing on windows 7 is a pass, and windows 10 look=
s as=20
                  good so far
14:53 <@mattock1> I may just dare do a release today


"we'll see"... ;-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--42/8TDB0GUY6FXEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcvzXGAAoJEB2Cnv7KVigSIDIL/1WfTVS47c1uTez75zAY/Fj/
VHNm7lQB7ettXUj5r8A9s1OKLLlcfF0dvmTTtZaSYmLIaYiB/ic+o0PU5bMaWoYm
MepX9ha1bMqzbDn8BX/Rna0yr+EecXjHoGsyzaK+GTBgVX55PUWIiJuYRx8XYywM
+r6jAK+7ka0f4kyLWC6Vw2Lb3Z1QkksIxvZPfP2fV49iWYsAXVGQt1lGq7uDmJX3
yaNOAxcJ0WdFDwckkoafXNFE7tH9JHHM8gpPx8Lg9T1n5HeeiDtI4sQ/RVTYnD7b
vTBWb4tQUFLJb3JWDortFQj+MEUbUUeIQpET2cnQ0z7iy3wXU/m9iocRBznX2R7f
hgPWZX/WNnMduQM+Ajcp5DocoXs8p/58Q2P5ieX9TaiwbDnV+NOwC/2HQeyudT5v
GnLp8NaJoknbBNAa+rprkCFyNiMjfmhdeAp4qMRS2+r41Uw8i+xgaUsyTuegH+ty
SylPEQYGmfHbUZr4OHR/cWt7/NTZLxyzq3viUwoQEA==
=NQXV
-----END PGP SIGNATURE-----

--42/8TDB0GUY6FXEm--

