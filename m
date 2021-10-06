Date: Wed, 6 Oct 2021 19:27:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YV3cZ1kNpMCJSA/r@...1296...>
References: <20211006090709.200-1-lstipakov@...277...>
 <CAFHpkQEfuk3+C5FL4st5GXxU0RNiYGH=dnDuVgyGUXdonRFepg@...278...>
 <CAGyAFMUWgLyW5PsoNT+ezQtA4x7W2vG4NUFSmbRR9FHDGH36HA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p9HNGhNd5zA7jI0U"
Content-Disposition: inline
In-Reply-To: <CAGyAFMUWgLyW5PsoNT+ezQtA4x7W2vG4NUFSmbRR9FHDGH36HA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix loading PKCS12 files on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: ???????? ?????????????? <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p9HNGhNd5zA7jI0U
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 06, 2021 at 03:40:55PM +0300, Lev Stipakov wrote:
> > Does that mean that CFG and Spectre protection are already included?
>=20
> Those are merged into the "master" branch, but not into "released". We
> could probably include those into the next 2.5 release? Otherwise
> they'll be part of 2.6.

"You tell me".

It was not relevant before as we did not build 2.5 with MSVC (except
for ARM).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--p9HNGhNd5zA7jI0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhXdxnAAoJEB2Cnv7KVigStXkL/0PvreYphoB9uIHKqy6nsKyH
0IwcFcVNj16CWgeYgn4QCZemRlkT7ndIhA79sMQZjGN/NUrL2cazDgo8EYNUboCy
eWh/rPRpJfd9zwTgSt8dMFJvewP4R7ZjzDWapfI0CzaKNxpaS5BeiFIX1yeIm1/Q
csvsor4j6IjLlYnL386efjVeGjcq8FCT1624CEZHJmOQCHskk4OvJqh1lCUhFlJb
WJ0TpAvG997vEQcO99OleLzoCAT+S0n96sqmzjMfNPDSDZ+CoPG3qGAnPTRcX+lF
zOI4v149Y7cWf3OwUxadMcuIrpErfEuulkQiuaU64An8a4v7V/+ajsFxeoedV+70
MOxIBXR6huPcP0XXmlBG2dE1U137HbKH1/NmHM/SNDOM7AgHrBGUYaph//ZHsByV
C8pAWaGy6+G5gcJIvOU+HTbU2ak1kksAzpD00wkvT3a7IVV2LI34i69ccM7UdEZs
UetAkNqYCP4rCJvbyDrrXtRPWwzzEdMnqdcfI+dC/g==
=t7VH
-----END PGP SIGNATURE-----

--p9HNGhNd5zA7jI0U--

