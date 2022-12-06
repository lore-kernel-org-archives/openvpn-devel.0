Date: Tue, 6 Dec 2022 17:19:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y49rj2dL4+OYvjNO@...1296...>
References: <20221206133647.954724-1-arne@...1227...>
 <202212061554.2B6Fscpj021683@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H1pRVJ/UEJKtKaIB"
Content-Disposition: inline
In-Reply-To: <202212061554.2B6Fscpj021683@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix connection cookie not
 including address and fix endianness in test
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

--H1pRVJ/UEJKtKaIB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 06, 2022 at 04:54:38PM +0100, Gert Doering wrote:
> I have not server-tested this, as it "should not" make a difference,
> and Arne did test this on s390.  The full server tests will run
> tonight, though.

I *should* have, as that would have caught the fact that this patch
breaks pkt_testdriver on Linux, no matter if OpenSSL or mbedTLS

[ RUN      ] test_calc_session_id_hmac_static
[  ERROR   ] --- difference at offset 0 0xffffff84 0xffffff8b
difference at offset 1 0x73 0xffffffeb
difference at offset 2 0x52 0x3d
difference at offset 3 0x2b 0x20
difference at offset 4 0x5b 0x14
difference at offset 5 0xffffffa9 0x53
difference at offset 6 0x2a 0xffffffbe
difference at offset 7 0x70 0x0a
8 bytes of 0x7ffe60967bd0 and 0x7ffe60967bc8 differ
[   LINE   ] --- test_pkt.c:492: error: Failure!
[  FAILED  ] test_calc_session_id_hmac_static
...
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 9 test(s) run.
[  PASSED  ] 8 test(s).
[  FAILED  ] 1 test(s), listed below:
[  FAILED  ] test_calc_session_id_hmac_static

 1 FAILED TEST(S)
FAIL: pkt_testdriver

this is not specific to OpenSSL (1.1.1*) or mbedTLS, but seems to
be "a Linux thing", so I assume it's something related to sockaddr
(as this patch fixes the switch/case to actually look at the IPv4 addr)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--H1pRVJ/UEJKtKaIB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjj2uPAAoJEB2Cnv7KVigSADMMAIt5yhi4oPf+Ww1BQrh+g8rm
nbJpPKwFuPoSlaOErFJz9AbhmOMFrUyLED3pSD3JOZdrfV5Js50qo+UcTKvRi68W
WlsV05ZTvo7WcUw1IFr+QIjV2KSB+vSptZK/AT9p7IcFftiLisMUAPBBM7VFnuct
T8P89XIc8quo2EhhiaLLX6C1yr5V2uDVV80Po/Kt/fLF5gx/Bh4cLjW2r1OKwjfG
rZGI8Wdwf365ZEH7uCSPTvXKFWwbeahbN0DXCk/wipLlQRfmKhs9DlKzUZ0wHaqQ
zU8O7HBSxcpcteWig8wljp+D9C1YyjIRicEjHjcnW5A8VMCjKZj3YsPN8zH0sB+r
FU9bhenRIDIwhCqMkI797DVtU60vHkO6wZkqiCCNCtPULW/OK+WJDgGKceaRldQz
4DZCjbLK0Rjx4UgK1en69EDsDutw2Dr8MXjYIM3frbMNusZ1FNM8hofF1n+HvsCe
35udt8troebnbG1Rw4f+v7TAdakSCGxhwmr71Jw/GA==
=LO4C
-----END PGP SIGNATURE-----

--H1pRVJ/UEJKtKaIB--

