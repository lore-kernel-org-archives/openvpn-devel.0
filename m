Date: Sun, 19 Jan 2020 18:16:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200119171603.GI1431@...1296...>
References: <20191110231018.30621-1-steffan@...1856...>
 <c297e78a-7e0a-dd6a-bc79-69fe297a8e67@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s3R87C3fwYeCSZ0b"
Content-Disposition: inline
In-Reply-To: <c297e78a-7e0a-dd6a-bc79-69fe297a8e67@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: add RFC 5705 keying material
 exporter support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--s3R87C3fwYeCSZ0b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 11, 2019 at 02:12:04PM +0100, Arne Schwabe wrote:
> Am 11.11.19 um 00:10 schrieb Steffan Karger:
> > Since mbed TLS 2.18, mbed TLS can also implement RFC 5705. As a first
> > step towards using the keying material exporter as a method to generate
> > key material for the data channel, implement the
> > --keying-material-exporter function we already have for OpenSSL also for
> > mbed TLS builds.

I tried to apply this patch today, since I have such a nice ACK on it.

Applying to "master" went smooth, but the resulting code does not
build for me:

../../../openvpn/src/openvpn/ssl_mbedtls.c:91:41: error: 'mbedtls_x509_crt_=
profile_suiteb' undeclared (first use in this function); did you mean 'open=
vpn_x509_crt_profile_suiteb'?
   91 | #define openvpn_x509_crt_profile_suiteb mbedtls_x509_crt_profile_su=
iteb;
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~

this is on Gentoo linux, with Gentoo-provided "mbedtls-2.19.1" (so,=20
should qualify as "2.18 or higher") and gcc 9.2.0.


Looking closer, I can see that current "git master" does not compile
on this system either, with the same error message.  Seems I should=20
run local tests with mbedtls more often, especially after updating...

mbedtls 2.12.0 on the other Gentoo system (the t_server buildslave, which
actually builds 2 times a week against mbedtls) works, as does mbedtls
2.16.3 on on FreeBSD.

So it seems this is something the mbedtls people broke in 2.19?=20=20

(And, for the record, anything newer than 2.12 is masked in gentoo, I=20
just unmasked "give me the latest!" at some point in the past so got=20
the fun today...)

Steffan, this will bite you anyway, some day :-) - can you have a look?


(I'll proceed to merge the patch...)


... awww... I think I might have found the underlying issue, trying to
understand the MBEDTLS_VERSION_NUMBER convention...

I see you check for "MBEDTLS_VERSION_NUMBER >=3D 0x02120000", the comment=20
says "from 2.18 up", and the thing Gentoo calls "2.19.1" installs a=20
version.h which claims=20

version.h:#define MBEDTLS_VERSION_NUMBER         0x02110000
version.h:#define MBEDTLS_VERSION_STRING         "2.17.0"

... but the tarball has the proper defines.  WTF...

Awww...

Gentoo's "mbedtls 2.19.1" also installs "mbedcrypto 2.0.0", which *also*
installs a mbedtls/version.h - and that one is the "2.17.0" one which
ends up in the filesystem.  This might be considered a bug in the
.ebuild file, but I find it amazingly silly to have two packages
who both have a "mbedtls/version.h"...

Ceterum censeo: mbedtls has looked long and hard at LibreSSL version
numbering and decided "we can do this in more exciting ways"...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--s3R87C3fwYeCSZ0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeJI7SAAoJEB2Cnv7KVigSE/8MAJ86Dws4goKQVOLAFB3yOTFn
eWvFfEVBLFJ4MUgYorjNWX3La6zgJayQdtCH11ssCztYlbUncFxebb9KSlmiSKZO
3QFeS5tg9HAZzmw6lyLsvAA4j5zWx7O6HXlXWKWxnpr9GRsrtGHRrHvKXjU38SiF
+idwPhb3zjSpWxn1xCknl3CiiyKeAMkMH4eiCuyLHDqor9JBY+38vs6Pamq/MvFs
eAUaEKKwDa8l4zYIImq0Cxj3KxDSI4m8yNhANYhqQVw6pRL1RNQ/gZX5LXJdIj0/
ErFWPXuRq4ANT+qt0tvFr711xwAEXMuFLhvIFVvDKP/7mLtz5jDIEXkoU6WhHZAN
7IFmOlmWvLuV9TcUT7r5yWYHSIrzKBgkaZth2mr5TfJI+Dhr/9PVg91LfOwl8grk
zZfedxpEebhigzaXzu4sS93n7aszyFYAXbrlrGNGOabEnJsBN++BWuRZZUYHwEMt
AjlsXV1G7V5Wj8Qbn7713uHmoQsmxYsyTjesR2Ervg==
=iRqd
-----END PGP SIGNATURE-----

--s3R87C3fwYeCSZ0b--

