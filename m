References: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2c05c5bf-5b7c-5965-2cb9-48b9647df45c@...2181...>
Date: Fri, 23 Feb 2018 17:17:22 +0800
MIME-Version: 1.0
In-Reply-To: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FdZTD7eUkBLot5hP7KJK92CJYAJOE8z7D"
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: don't use API deprecated in
 mbed 2.7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FdZTD7eUkBLot5hP7KJK92CJYAJOE8z7D
Content-Type: multipart/mixed; boundary="zLpMvsVZZkVVMJcw0Z98UZx4zupHYuCiV";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2c05c5bf-5b7c-5965-2cb9-48b9647df45c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: don't use API deprecated in mbed
 2.7
References: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>

--zLpMvsVZZkVVMJcw0Z98UZx4zupHYuCiV
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/02/18 20:22, Steffan Karger wrote:
> -        mbedtls_sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
> +        if (0 !=3D md_full(sha256_kt, cert->tbs.p, cert->tbs.len, sha256=
_hash))

Why not using mbedtls_sha256_ret() since we are already in
mbedtls-specific code here?
Any advantage in using a wrapper for another wrapper? :-P

(mbedtls_sha256_ret() is also the suggested replacement for
mbedtls_sha256())


Moreover, SHA256 is statically selected, therefore using
mbedtls_sha256_ret() would also avoid the md_kt_t local variable.

> +        {
> +            msg(M_WARN, "WARNING: failed to personalise random");
> +        }
> +

Since we now have a reason for the failure, may it make sense to print a
proper description based on the return value? (even though I think
mbedtls_sha256_ret() can't really return something different from 0)

>          if (0 !=3D memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_ha=
sh)))
>          {
>              mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
>=20


Cheers,

--=20
Antonio Quartulli


--zLpMvsVZZkVVMJcw0Z98UZx4zupHYuCiV--

--FdZTD7eUkBLot5hP7KJK92CJYAJOE8z7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlqP3CIACgkQB6U8WA7y
zXSBtxAAvxklf++OzpR4LyKDVIezj8Lf+wUEv2NLdHjTEk2ZL5NoXgnubIi96Zjq
cAov4kjnXCTDP4fuaW3HIFQk8ch4mZJyRrUF8B7b877qTyC0ZNz4rwhQTopPqMNQ
w9vYQ5LBAMdkY00bXv2/BtikWYdwGepnNsTtPvmh4mVNFw2/6coOZTqXr66BQ7uF
dPRbKlp+7Nu3X3mRj340rGofneAaBTm8bwcR+nx4NPge6J9XH23TOFNmW8VI8Rk0
YQF4auC62xFiKj6CSERnyg0CFNeAQkzzbKBRwxaIE/jIOo+Q6HRRyXh8QfHewhjK
t26xXNjAnWaONKVgA97Y19/czxVoHPuecZ6Rwciic4NyaiEy/71U+1sIUXwj4jhE
qMsH6XMcQzjTb02Gv0ZZ/7736+2G4YOEuGcEK5qrDLYSTo+fEDR48Naoanuz4sAr
6aY31R3NXQATAgM7wztAvcQUy5EFu1L9bXq4s6LUuC8hHralIEJrGXfl0QEmsjgK
BHJK2duE1igTLrAjMdW7dFk8ON1KGvt5GYtNbtpEf6vLewcPYzLG0pdm9yjlpj9g
R2rKYthuueekTHt1YFqIobm66/dDr4tVver5ltCcd+cgSEsVQyPtSg4IHG7IQjpP
1NZo6qi2fKGqPL654QLTaSOtVBKKRBJgXLqhQC8eajmCs6lnsJs=
=Hl+D
-----END PGP SIGNATURE-----

--FdZTD7eUkBLot5hP7KJK92CJYAJOE8z7D--

