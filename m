Date: Wed, 10 Jun 2020 15:02:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200610130254.GZ1431@...1296...>
References: <20180725195040.27560-1-kkane@...2393...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aXPeqnC4ASnowlfh"
Content-Disposition: inline
In-Reply-To: <20180725195040.27560-1-kkane@...2393...>
Subject: Re: [Openvpn-devel] [PATCH v2] [openvpn-build] Install/uninstall
 dialer DLL as part of Windows installer operation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kevin Kane <kkane@...2393...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--aXPeqnC4ASnowlfh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 25, 2018 at 07:51:03PM +0000, Kevin Kane via Openvpn-devel wrot=
e:
> Signed-off-by: Kevin Kane <kkane@...2393...>
> ---
>  windows-nsis/openvpn.nsi | 4 ++++
>  1 file changed, 4 insertions(+)

I'm trying to clean up "dangling" OpenVPN stuff while in the run-down to
2.5 code freeze.

Came across your patchset to make OpenVPN a proper "dial-on demand" VPN
(if I remember right).

Was this ever finished into something mergeable?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aXPeqnC4ASnowlfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe4Nn9AAoJEB2Cnv7KVigSlPUL/RVVg1pagsO0j8mHX0XVW02v
IAoRTK9XqQOW16HrMV6sOfoKW/ncuRJWQXsnIll23nfucsDcRqsbj81D5J94OJhC
nXD/Cgj7LZw5Me8nMiPIxfTujGNxA+Y9RbHycchQ+ARIvvlHNV/6Dy0vg5TfIXTv
289o1YmjIS03hmG/zRGxLOb7itZVd3868JaNazO9HAcRxrBSQHNqsL1Df+3QFToU
+h+1A0Z8b0mQIjCioyzQesalKtpUtSxuT0Y1E1SYGl7K2tvxfWDBv+DTSlNpgYeF
PMzrgJISPjlHjkqxYN8Nva2FlBqoYY8R39CAC2keSIVQVwv8PiVl0MJ/x61bGETB
tZxPkyBVccJflum+PlsMn+mA7oNOZH8JrcPwWwdBomclz3VsdmwoXmtPs9yMe/5m
Lxh1TwXfgo0bZ70Ev1xniZpK7NcC1nEs+zGQdGNeLz7OQxRI19X78Djqt/3/IhFK
jJqKQGhglx6RIVyt0l9cxadh77F+rJNQ7pNtJTGfjw==
=XRQY
-----END PGP SIGNATURE-----

--aXPeqnC4ASnowlfh--

