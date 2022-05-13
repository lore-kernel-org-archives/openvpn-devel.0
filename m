Date: Fri, 13 May 2022 09:14:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yn4FRQx826Q/ReZh@...1296...>
References: <20220512121429.2096164-1-arne@...1227...>
 <20220512121429.2096164-8-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fmNy+9vjdxHe1g7n"
Content-Disposition: inline
In-Reply-To: <20220512121429.2096164-8-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 7/7] Remove dependency on BF-CBC
 existance from test_ncp
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--fmNy+9vjdxHe1g7n
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 12, 2022 at 02:14:29PM +0200, Arne Schwabe wrote:
> The test_check_ncp_ciphers_list test assumed that BF-CBC is always
> available, which is no longer the case with OpenSSL 3.0. Rewrite the
> test to not rely on BF-CBC to be available.

This should be a cherry-pick from c07f95f3cacd, but "something went
wrong"

>  static void
> @@ -57,6 +58,11 @@ test_check_ncp_ciphers_list(void **state)
>=20=20
>      assert_string_equal(mutate_ncp_cipher_list(aes_ciphers, &gc), aes_ci=
phers);
>=20=20
> +    if (have_chacha && have_blowfish)
> +    {
> +        assert_string_equal(mutate_ncp_cipher_list(aes_chacha, &gc), aes=
_chacha);
> +    }

In c07f95f3cacd, the first if() is only "if (have_chacha)", and that
seems to make more sense since that test does not depend on BF...

> +
>      if (have_chacha && have_blowfish)
>      {

... only this one does...

can I have a 7/7 v2, please? :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fmNy+9vjdxHe1g7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJifgVEAAoJEB2Cnv7KVigSQawL/1n6jMN2StaCghXY8AO8m6n+
7UAj1UtqZtKLSO+QyIRho04e7a+yjam9peBKgc5Ia0J6g0Pyu+886X7NKZ4xpkF2
irwe6LSz7E9D9Q4cBgS7VtowuJYCEa7BljQKW6RYtnO8BOESs7M407H8kkHfMsLj
bQsF76gZvtG+nV+bGiXogEUzsWzRPKqXfM4/bX7OmVFBRwPZgscgKUcVpwXLqOG8
IAw3fNtDbGB1yGlr09NHJGGs36OI76zjw1I8i+UZg1EVZOpDXb7JRRxonSGyGw/j
JmVuPc0e9k4oGg73AE+vkZSu9KtAz3ea+Lriwm+gOdx7PbAzBucBxdsexyXUfaY+
ZMPDxTxrIhzgWCtWX6sqMIFnjI5veNT5g9zf7MIHi5dmnBe7w4666HSAuVe6lTMY
Ks/v27WlvZC8c420HDb6fmlrGah8nbVTqjxShNylYxjzs070io/cYKuIJZI8LCaq
hZ1V7yMm11rP9ue5DLcTZX2qDKIzcQGxciZGzPhcMw==
=oM2w
-----END PGP SIGNATURE-----

--fmNy+9vjdxHe1g7n--

