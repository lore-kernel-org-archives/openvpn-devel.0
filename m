References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<1470956309-31268-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bc3d4efd-e116-5f02-b72d-85fafce26399@...2080...>
Date: Fri, 12 Aug 2016 16:46:38 +0200
MIME-Version: 1.0
In-Reply-To: <1470956309-31268-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid format specifier %zu for Windows
 compatibility
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/08/16 00:58, Selva Nair wrote:
> - Replace %zu by %u and cast the size_t variable to (unsigned int).
> The cast should be safe as in all instances the number involved is
> small.
>=20
> Note: mingw64 targets msvcrt.dll runtime that doesn't support %zu
> and print "zu" instead of the number. With -Wformat the compiler=20
> does warn that z is an unknown conversion type.
>=20
> v2: Cast to (unsigned int) instead of (int).
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...> ---=20
> src/openvpn/crypto.c      |    4 ++-- src/openvpn/options.c     |
> 4 ++-- src/openvpn/ssl_mbedtls.c |    4 ++-- 3 files changed, 6
> insertions(+), 6 deletions(-)

ACK.

I've double checked that all places converted from %zu to %u are do
only the size_t type (which on at least Linux map to unsigned int -
sorry, don't have Windows handy).  But given that these values are
mostly MTU, crypto packet overhead length or crypto key length
related, they shouldn't easily overrun (that would be quite a special
network packet or crypto key).

Just done a simple build on my Linux box (again, sorry, no cross
compiler handy) ... but, last famous words: This change looks sane and
safe.

I'll need to update my git ack-am scripts slightly now that gmane web
is currently dead.  But I'll commit it asap.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlet4U4ACgkQDC186MBRfrpohwCfS6auj2tZvjunstoCp9unaUDc
OKgAni/nqugO2abrUHLaZrqeHGlx8O95
=3DDYTu
-----END PGP SIGNATURE-----

