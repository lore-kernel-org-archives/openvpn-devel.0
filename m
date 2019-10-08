Date: Tue, 8 Oct 2019 14:42:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20191008124217.GI40538@...1296...>
References: <1570537606-29323-1-git-send-email-lstipakov@...277...>
 <393dce92-d103-03a3-a7a7-46c00df40087@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+svXpSx+RSEd8UhP"
Content-Disposition: inline
In-Reply-To: <393dce92-d103-03a3-a7a7-46c00df40087@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] push.c: fix Visual Studio build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

--+svXpSx+RSEd8UhP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 08, 2019 at 02:36:28PM +0200, Arne Schwabe wrote:
> I thought we had those in other places. But I guess I was wrong.

We do, but never with {}.

Our "new style with C99" seems to be "go away from CLEAR() for
local structs", so this is a step back.

Assigning {0} should be fine with MSVC - we use this in lots of=20
other places and it does not fail.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+svXpSx+RSEd8UhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdnIQoAAoJEB2Cnv7KVigS68gL/RfFJN8HmxsC1g1wv3xqW79S
SjxrYxFshSaesBFD9ktB7Xpf3AHnCch/xfAoviZg3JKmX86RjGi86NsfzUABX6fA
bRFCukPk+pWXAVUH21HZTAbz09dUcEZOsR8xQXXqiDJPvhjbcM2oFVyzUCznreFc
y/oCJHLGnZAhTyXRlU5gJ/Ee1XJnxrShFTtUiBEpDlLhqJL92JHy0OJ+MqGOPe6z
lKOAtBYYnIFg098/BigeWc+xp9G6Deq/QI3y+Uyj9BmpfryKPneM9Z52wWlaINWm
AS7qA6VNGGtVtPCCqSf8o5uFGquIFAmknALa5AKtTZUzHMzRFYNoHOis0mnol6YJ
w99r6glqKVgWGf/UhT714oiLb2lFHq5lnOXKhunpGWE0+qw+PgtutvBVY+4Qw4a2
ScXvoDT0GIDSMu5Ewq0GAThmlN6ivVBCMMdsbRBTC4zYjXkIES3rxDGYqSxGlVpj
3Jr6WhP1AMusGqpH4PFExICZOJ5zuWRP4KIW4cWIbg==
=1XfT
-----END PGP SIGNATURE-----

--+svXpSx+RSEd8UhP--

