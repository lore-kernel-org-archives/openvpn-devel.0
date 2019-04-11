Date: Thu, 11 Apr 2019 18:02:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190411160250.GK31008@...1296...>
References: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
 <7dd77ddb-c187-fc8f-96ba-3c8c75fd1c70@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NXxBKFTfdeXlAk+N"
Content-Disposition: inline
In-Reply-To: <7dd77ddb-c187-fc8f-96ba-3c8c75fd1c70@...515...>
Subject: Re: [Openvpn-devel] Tap-windows6 9.23.1 pre-release installer for
 Windows 10
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--NXxBKFTfdeXlAk+N
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 07, 2019 at 11:26:24AM +0300, Samuli Sepp=E4nen wrote:
> Windows 10 version of tap-windows6 9.23.1 is available here:
>=20
> http://build.openvpn.net/downloads/snapshots/tap-windows6-9.23.1/windows10
>=20
> The Windows 10 version is completely untested but it "should work" on
> x86, x64 and probably even arm64.

I have packaged these .zip files into a "proper" .zip container=20
for all architectures ("which has the files in the places where
build-snapshot wants them"), and then built a nsis installer using
the standard methods.

Installation on a Win64 VM (which started up as a Win7 VM, so might
or might not behave differently from a "from scratch" install) proceeded
normally, but took about 2 minutes at the "installing TAP driver" point
until the "it has a signature from OpenVPN Inc!" popped up.

It worked as well... :-)


Unfortunately, it claims to be "TAP-Windows Driver Version 9.21", and
also the Windows driver version dialog shows "9.0.0.21".  Mmmmh.


So, next test: on top of this install, I ran your=20
"tap-windows-9.23.1-I601-Windows10.exe" installer from the "windows10/"
directory.  It installs just fine, except that SmartScreen complains
about "unsigned installer" - but the driver went in just fine.

*This* one nicely identifies as "9.23.1.601" in the driver config
dialogue (plus, it also installs just fine), and also in OpenVPN

Thu Apr 11 17:59:43 2019 open_tun
Thu Apr 11 17:59:43 2019 TAP-WIN32 device [Ethernet 2] opened: \\.\Global\{=
2C061B3D-7D08-4B89-B463-9301F1D14AEB}.tap
Thu Apr 11 17:59:43 2019 TAP-Windows Driver Version 9.23=20

and it seems to work.


... so, without more scientific testing, it seems that your signature
and the .exe installer works at least on one Win10 machine, but the=20
individual .zip files do not contain the 9.23.1 build but something
else...

Can you please verify what went into the "tap-windows6-amd64-9.23.1-..."
zip bundles, and possibly even have your system build a build-generic
compatible all-architecture .zip bundle to continue installer testing?

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

--NXxBKFTfdeXlAk+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcr2UpAAoJEB2Cnv7KVigSB0gMAJbRfp8weSlDI9pwSKPKMZGa
so1Wj5gw0djCUXzbIDxv/joMoQSbNjGkToCknkgzN3NFsOr44LpWXVaeYr4vazqB
q8WSE3C6jAcT9oO0+R0lhEolGUOVzthFUAb7HzjMpvWLMP5zHZB4xIQFvDxEOJIV
VoNC8RbmKtmUb5BuwDr7EXeZSb1I3mLe8BAdOhKPlvaDsQYe0j28xyCSlgDdNWNF
xaXNcC0gNA9TrAANAVbIpNFae55hjNU9Ij0CETfa13dsudWQeluUSMwmwYwKKJlU
uO91RY0D1+XYrKJnxmfesudIbj74FB0VG1qWeQ8u/6Wj8P652Rjs/oqKENCTgDJQ
Df1MtNGgIVJ6w1GkMlvs0tHskfDjdqjaYj3zx/y7kxPiCkjDNz8f7cZexG9qTX+T
6gl62g9HznLohOsnt4BghFCy7qX9sNl8QB1de03gZgwWF9X6WviwbJTdlgUx0Wad
Msl3Qo6PB4UvG4JY2QLA7PvxoZPNp3AK9lDqoHKHLg==
=TmsG
-----END PGP SIGNATURE-----

--NXxBKFTfdeXlAk+N--

