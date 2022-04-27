Date: Wed, 27 Apr 2022 18:43:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ymlys4bx/rIfg3/5@...1296...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-8-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="X87dydupRSGM8/G+"
Content-Disposition: inline
In-Reply-To: <20220422142953.3805364-8-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 17/28] Implement constructing a control
 channel reset client as standalone fucntion
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--X87dydupRSGM8/G+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 22, 2022 at 04:29:42PM +0200, Arne Schwabe wrote:
> This implement creating a reset packet without needing to setup a full co=
ntrol
> session.

I was about to merge this, with "it has a unit test, so what could
go wrong".

But...

[ RUN      ] test_generate_reset_packet_plain
[       OK ] test_generate_reset_packet_plain
[ RUN      ] test_generate_reset_packet_tls_auth
[  ERROR   ] --- ASSERT: buf_write(&buf, &net_pid, sizeof(net_pid))
[   LINE   ] --- ../../../src/openvpn/ssl_pkt.c:425: error: Failure!
[  FAILED  ] test_generate_reset_packet_tls_auth

Gentoo/OpenSSL 1.1.1n build

[  ERROR   ] --- ASSERT:=20
[   LINE   ] --- ../../../../openvpn/src/openvpn/ssl_pkt.c:425: error: Fail=
ure!
[  FAILED  ] test_generate_reset_packet_tls_auth

Gentoo/mbedTLS build (with --enable-small, thus, no message)

[  ERROR   ] --- ASSERT: buf_write(&buf, &net_pid, sizeof(net_pid))
[   LINE   ] --- ../../../../openvpn/src/openvpn/ssl_pkt.c:425: error: Fail=
ure!
[  FAILED  ] test_generate_reset_packet_tls_auth

FreeBSD/OpenSSL 1.1.1l build


Could you have a look?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--X87dydupRSGM8/G+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiaXKzAAoJEB2Cnv7KVigS5A4MALIaqtvUg+sVlCkOWou7ZAP6
j7601qgJXTwJ5DBZ0BUrNitS9H0hCR6isrif1mVEAwANWnO7Sutg19frQsxyaZ5B
O66TbKhka9Fd1SD2xURff80IG3JXTsG56eRSrb0w2JorI5D6GEYhHTn/8o8+1dT2
FXhPdqCJow17yAJWfYTb0jIdvun47VB8qWL9ZuHhmDc61qfuvfVNZxY+E/6Ll2gi
7lYEUCxpXf5m+af0nI+awJOJVmnwHYuDI+Kvo7SLFBmXgPcs0ZwtmNyciEEtmw6t
TaNf2JK1wn48LjdKTSKLfpyqODatu42USG8i2BJj5O9xswfcV6COR6VIgAMCNtir
iKBg6JHpDJ64lXrri/tqZvaZEMjX9fhT7FVIeMi72IPxsoOFkhjSEXpfEcI6OaW7
5aZGAk2i65OU9iHe2yiqwg+e+45yr73Pnk2vHhgMBzhgFYA/XYmZerSVe8MwFymY
KHW1HD80BndNI0l+37OItZIfKMJt0r4uLjZXN6Ws9w==
=YqrO
-----END PGP SIGNATURE-----

--X87dydupRSGM8/G+--

