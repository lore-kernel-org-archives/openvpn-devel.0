Date: Thu, 11 Oct 2018 13:23:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181011112317.GF962@...1296...>
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
 <20181010185023.GD962@...1296...>
 <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8V/AXrYGldrj4WKF"
Content-Disposition: inline
In-Reply-To: <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--8V/AXrYGldrj4WKF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 11, 2018 at 01:40:16PM +0300, Lev Stipakov wrote:
> > Since crypto_overhead and crypto_max_overhead() are both size_t, and
> > frame_add_to_extra_frame() is declared to take an "unsigned int" now,
> > this cast should not be necessary.
>=20
>=20
> Visual Studio disagrees. Without explicit cast I got
>=20
> > warning C4267: 'function': conversion from 'size_t' to 'const unsigned
> int', possible loss of data
>=20
> https://docs.microsoft.com/fi-fi/cpp/error-messages/compiler-warnings/com=
piler-warning-level-3-c4267?view=3Dvs-2017
>=20
>=20
> 'var' : conversion from 'size_t' to 'type', possible loss of data
> The compiler detected a conversion from size_t to a smaller type.

So, maybe "crypto_overhead" and "crypto_max_overhead()" should be
changed to be just "int" here...?

For something which has a numeric value between "10-ish" and "100" (maybe),
using a 64bit integer initially and then adding casts because we want
to work with 32bit integers later on and not be warned about it sounds
like the wrong way to tackle this...

I know that Steffan likes using size_t for "things that have a size"
but I find it a bit questionable here :-)


> > Unnecessary casts hide bugs and hurt my eyes...
>=20
> OTOH this is level 3 warning, which we have over 500. Since we'll probably
> change level warning to 2 and
> GCC doesn't complain, I'll remove it.

I'm all for fixing compiler warnings, but I hate silencing warnings with
casts that serve no purpose but "silence warning".  If we can fix it
for real, so the compiler has nothing to warn about, this is way better.

(It might not always be possible, like const/no-const mismatch on some
API functions, or struct sockaddr* madness on the socket API)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8V/AXrYGldrj4WKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbvzKlAAoJEB2Cnv7KVigSpisL/1yc/7K8oOnE9qwkr2Qw2kVL
P/IKtLM1ci+7nG4/SPyuOGbT9Ht00LSWnsnAnsrRnwI8egKz/GwlVaDkquHsb1C0
BYDcKP36cvCJcVFaXAH8ZCp1831+oEV8LKs0OxN+NLDcVDbkbBMxTDw53UEw0SZQ
X0RZRymIUeWz1ImunYzbDokqcnu01n23nQvV1Dg0b2a5CV8xndQbjB2MX7b9p3zT
PiUFG12whq7o3TXa5EetdApzfGANX9muGdI+V27eErvS5fhDZ1pw1dgGf+ctWrVe
CJOd0IBfll2q3+D3GzkC7jzB7NRzmivv9DtKEgckXI5KrriZDchy/HhZvdF4tSe7
eAbGwKON0yRwdvi3+XUPSrdN/fRrFPpW/hEvYN0O0G+94kZIlQBg4y0q6Q+V2cY+
FX76qClRHRUPagKgxuwgRuMQPUbGdpRj9AcusiW/cp7JOeQLcZVjQMerv5RoWXjt
6qEtgorV9jJn/jASFhZ0rgi+l3BuWPxAq6QzwU1N7g==
=xley
-----END PGP SIGNATURE-----

--8V/AXrYGldrj4WKF--

