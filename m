Date: Tue, 14 Feb 2023 15:44:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+ueSYlv/eGGi2pn@...1296...>
References: <20230128223421.2207802-3-selva.nair@...277...>
 <202302141400.31EE0XkI023101@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="imk3JK6KltS7M/fe"
Content-Disposition: inline
In-Reply-To: <202302141400.31EE0XkI023101@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: cyryptapi.c: log the
 selected certificate's name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--imk3JK6KltS7M/fe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 14, 2023 at 03:00:33PM +0100, Gert Doering wrote:
> The 3 new gc_free() are a bit ugly, but unavoidable without either=20
> having "gc_free() in the middle of the function" (which we don't do) or
> restructure more & add "ret =3D 1 ; goto end" code...  so it is what it i=
s.

I did have a vague dislike for these gc_free(), but it turns out that
one of them is actually *wrong*...

https://github.com/OpenVPN/openvpn/actions/runs/4174551447/jobs/7228274450

cryptoapi.c: In function `SSL_CTX_use_CryptoAPI_certificate':
426
cryptoapi.c:1072:13: error: incompatible type for argument 1 of `gc_free'
427
 1072 |     gc_free(gc);
428
      |             ^~
429
      |             |
430
      |             struct gc_arena
431
In file included from cryptoapi.c:52:
432
buffer.h:1019:26: note: expected `struct gc_arena *' but argument is of typ=
e `struct gc_arena'
433
 1019 | gc_free(struct gc_arena *a)
434
      |         ~~~~~~~~~~~~~~~~~^


Sorry for not spotting this before merging - my MinGW build did not
excercise the "right" code paths.

This is in the "no HAVE_XKEY_PROVIDER" branch, and I build with 3.0.7,
so the test build never saw this.

Seems I need to merge the "remove pre-3.0 support" patch quickly, so
this becomes moot ;-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--imk3JK6KltS7M/fe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj655JAAoJEB2Cnv7KVigSQTsL/iOTHOlrrc+D1/pD3Ow3Q1mp
zsbrAueWzQMkaneQGUe7Gr5ivmOuE5daI6j87iYWeiA2mCUk+TZqteuC3sRexOLh
vFIZavZqrfEmsFNsZtsON314zXQgUS167SSvRHcHJvdJ5IvhKEWW4+zYn1ElNg3Z
kwMg1ZZ9VMg+K2HxVza3zy/PMz/aSDYDzetuzCl1f/1YKot0+1Vhq4xFslwvNs9z
JG6EzSw/H3UDGId462wIasBa/vhDzo4dNbgRYL/LWKXQZwsSpJVya1d3tcqud1Hs
IQM2p1pPmfm9e0XpUHbyiQMF4ERPdjW7FrqKMJ4Un4Yr5RzW0rpxq+hq0D+bpFUs
p2pRL+6VG3Sig3ddZL3HcM8VUQj0ffI7hl+ob4G8jMM1EYoVhlSIsarx7OoiUvmh
QjvfcjnmxRD81AXIOQ1ChdtKMwi60u8cGHKTQEcGBU++BDANEhnq6kUtsnWVmHFV
aKRgTKuQuTA/Tvj3N4onh2Laqm9ni/xA4uFs6iNGrw==
=40uO
-----END PGP SIGNATURE-----

--imk3JK6KltS7M/fe--

