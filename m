Date: Fri, 9 Feb 2024 17:35:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZcZUXE8meobH-Nve@...1296...>
References: <20240209155109.110542-1-juliusz@...2525...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QeFaTiO4G0zF6GRy"
Content-Disposition: inline
In-Reply-To: <20240209155109.110542-1-juliusz@...2525...>
Subject: Re: [Openvpn-devel] [PATCH] wolfssl: include "ssl.h" by
 "src/openvpn/ssl.h"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

--QeFaTiO4G0zF6GRy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 09, 2024 at 04:51:09PM +0100, Juliusz Sosinowicz wrote:
> Including "ssl.h" conflicts with the wolfSSL ssl.h header file. The inclu=
de/wolfssl directory is included before openvpn/src. include/wolfssl needs =
to be included so that openvpn can pick up wolfSSL compatibility headers in=
stead of OpenSSL headers without changing the paths.

NAK.

All our local includes are included without path, so we're not starting
"full path" for a single include now.

If this conflicts with WolfSSL, I'd be willing to consider a Makefile
patch that puts WolfSSL includes behind openvpn/src (so our ssl.h is
picked first).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QeFaTiO4G0zF6GRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlxlRcAAoJEB2Cnv7KVigS1oUMALB8H+KcddfDCTAGtT5RLrFI
sC/tMrir1RCp7p+a0Nb7Orx8ioQODwG4qNMoqbUNyAWttOAtbwph23jC4EFnVEmy
pRwBRpEQHyyFBXBJiznFmgbGG3bKm6KhVLrxmDCoy8o0AmuqVRvB7JRWd+3abB+0
GtKTfUil8AE/xIzRN/AUR7xdb+NpJtuoS5leCVqD2UjdtzK5ZpRxnWtUcloXylPF
aC58jt0BHKqKSKziU2yjN4a43Lv++6s6wAeVgMan+Y8t0jujQKzWemwWr5oWh4Hb
bRY/TPYCbx/BN1+Q2/qbZHKtFC9oIJc8UbjdMqMsSxCNL2jtYtbpM8SGNv6HNT3i
pBi3s+TsB4n7t2gr5ipoR6pfS6mIa6oAFr2zDKKkMQ7kyU2lVV+5rwM+GqHakwu7
sG6YE7tq/wsDB+puDxTGhmDkC0UMlT3Tc5VaFsOSHSiRU675pzHZzwMF7znSjtok
XZlMfefVrfnRRA3Pq3XTnS/Ks1ICHNoBE/B9nPlf1g==
=L4NO
-----END PGP SIGNATURE-----

--QeFaTiO4G0zF6GRy--

