Date: Sun, 20 Dec 2020 21:48:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201220204812.GV976@...1296...>
References: <20201215173950.26596-1-domagoj@...2540...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nZXg2M4iSwlWfAyw"
Content-Disposition: inline
In-Reply-To: <20201215173950.26596-1-domagoj@...2540...>
Subject: Re: [Openvpn-devel] [PATCH] Remove 1 second delay before running
 netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel@lists.sourceforge.net

--nZXg2M4iSwlWfAyw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2020 at 06:39:50PM +0100, Domagoj Pensa wrote:
> When running various netsh commands before each 1 second sleep is added.
> As more netsh commands are run, especially for Wintun adapters, that can
> add to a noticable delayed connecting time.
>=20
> This should be safe. No problems were found in tests and all netsh
> commands executed properly with delay removed. Also, no delays are used
> in a similar code in interactive service and netsh command executions
> are guarded with a semaphore.

This is... interesting.  The offending sleep(1) was added there by
james, 15 years ago, in commit a9c802b2a (imported from SVN)

That commit basically split the "sleep(5) after each try" into
"sleep(1) before and sleep(4) after", so possibly it was needed=20
before the very first netsh call...

The change itself is not commented in the commit message, so we=20
can only guess

commit a9c802b2a3f77f2b906e22f582681cdec0790c32
Author: James Yonan <james@...515...>
Date:   Thu Dec 22 18:09:40 2005 +0000

    --ip-win32 adaptive is now the default.
    --ip-win32 netsh (or --ip-win32 adaptive when in netsh
    mode) can now set DNS/WINS addresses on the TAP-Win32
    adapter.



Lev: do you have a particular opinion on this change?  You do more
testing with wintun...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nZXg2M4iSwlWfAyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf37iLAAoJEB2Cnv7KVigSIXcL/3tIT2HqqvSFqUHH5ZToKi4b
FQ2v9h8duvrRyYK9pF2Xntd3utzU4DwHyyAapx14qlYF4N3y9mRmoti4jRmKwWYo
LyS9PYAMNAFAAY+RI8k2z7pACZDUfu5IzuyrJF4zP5vSInP1lP4Qx7V5fjplZI3p
rWbefVMdHMpHkR2a0ysa73Isyo4jOxYG+YffThK6ND1oCONfHWE461sdP+vDlPJX
3Kf57oiJN1FSWt1u8r8lqMf5WLPgGw7W/VXe+T1a/czs2+khV3ZDzrDykcDdSxdp
aFq+yw7IxcuEJR54CxgbxQpHo7y0LM+ffQmSYOo+GVAcyRFL/+5FuYj8CIV09Bo+
8VT60x0xDDNH+2EW9q+ojv5aY1ZvlOQ79YGS3sdNxsgBkP4on8Kgz8SPhx2l9hqn
nUS7qtLaeS/qPBq2iLU7dOs4jbmA4g6G94tN/UsSH+ZJliKMxBaSa5MDQ7DgzGYy
i7HU/B/wz0ItmYbAPCPXVV8UTQaYgehxr/lm14rXxQ==
=/xF5
-----END PGP SIGNATURE-----

--nZXg2M4iSwlWfAyw--

