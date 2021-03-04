References: <20200907160224.18670-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <81be869e-6c16-d8f8-c42b-e0e493b1a010@...2080...>
Date: Thu, 4 Mar 2021 22:06:12 +0100
MIME-Version: 1.0
In-Reply-To: <20200907160224.18670-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xwiEfk1amadQx1DHTP47f0O63LONYPg1l"
Subject: Re: [Openvpn-devel] [PATCH] Cleanup print_details and add
 signature/ED certificate print
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xwiEfk1amadQx1DHTP47f0O63LONYPg1l
Content-Type: multipart/mixed; boundary="ARM778z29uv7KtdbHqsJa5cqTw2wZ2Urc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <81be869e-6c16-d8f8-c42b-e0e493b1a010@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Cleanup print_details and add
 signature/ED certificate print
References: <20200907160224.18670-1-arne@...1227...>
In-Reply-To: <20200907160224.18670-1-arne@...1227...>

--ARM778z29uv7KtdbHqsJa5cqTw2wZ2Urc
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/09/2020 18:02, Arne Schwabe wrote:
> This commit cleans up the logic in the function a bit. It also makes it
> more clear the the details printed in the second part of the message are
> details about the peer certificate and not the TLS connection as such.
> Also print the signature algorithm as this might help to identify
> peer certificate that still use SHA1.
>=20
> The new format with for TLS 1.3 and an EC certificate.
>=20
> Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer cer=
tificate: 384 bit EC, curve secp384r1, signature: ecdsa-with-SHA256
>=20
> Using the more generic OpenSSL functions also allows use to correctly
> print details about ED certificates:
>=20
> Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer cer=
tificate: 253 bit ED25519, signature: ED25519
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/ssl_openssl.c | 118 +++++++++++++++++++++++++-------------
>   1 file changed, 78 insertions(+), 40 deletions(-)

I have tested this lightly with both EC and non-EC certificates, and can
confirm the behaviour from the commit message.  My setup used a server
config with a classic RSA certificate while the client used an EC
certificate; both from the same CA (RSA based).

=3D=3D WITHOUT this patch =3D=3D
SRV (non-ec): Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA3=
84, 384 bit EC, curve: secp384r1
CLT (ec):     Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA3=
84, 2048 bit RSA

=3D=3D WITH this patch =3D=3D
SRV (non-ec): Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA3=
84, peer certificate: 384 bit EC, curve secp384r1, signature: RSA-SHA256
CLT (ec):     Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA3=
84, peer certificate: 2048 bit RSA, signature: RSA-SHA256



I have also looked at the code a bit, and it looks reasonable but has a
few minor things which might could be fixed before the final ACK.



> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index f52c7c39..c602c625 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -2031,6 +2031,80 @@ key_state_read_plaintext(struct key_state_ssl *ks_=
ssl, struct buffer *buf,
>       return ret;
>   }
>=20=20=20
> +/**
> + * Print human readable information about the certifcate into buf
> + * @param cert      the certificate being used
> + * @param buf       output buffer
> + * @param buflen    output buffer length
> + */
> +static void
> +print_cert_details(X509 *cert, char *buf, size_t buflen)
> +{
> +    const char *curve =3D "";
> +    const char *type =3D "(error getting type)";
> +    EVP_PKEY *pkey =3D X509_get_pubkey(cert);
> +
> +    if (pkey =3D=3D NULL)
> +    {
> +        buf[0] =3D 0;
> +        return;
> +    }
> +

[NOTE 1]
> +    int typeid =3D EVP_PKEY_id(pkey);
>
> +#ifndef OPENSSL_NO_EC
> +    if (typeid =3D=3D EVP_PKEY_EC && EVP_PKEY_get0_EC_KEY(pkey) !=3D NUL=
L)
> +    {
> +        EC_KEY *ec =3D EVP_PKEY_get0_EC_KEY(pkey);
> +        const EC_GROUP *group =3D EC_KEY_get0_group(ec);
> +
> +        int nid =3D EC_GROUP_get_curve_name(group);
> +        if (nid =3D=3D 0 || (curve =3D OBJ_nid2sn(nid)) =3D=3D NULL)
> +        {
> +            curve =3D "(error getting curve name)";
> +        }
> +    }
> +#endif

[NOTE 2]
> +    if (EVP_PKEY_id(pkey) !=3D 0)
> +    {
> +        int typeid =3D EVP_PKEY_id(pkey);

I believe this line above can be removed, as it is the same as [NOTE 1] - o=
r am I overlooking something?

+        type =3D OBJ_nid2sn(typeid);

And this line could be moved into an else {} fallback after the "nicer mapp=
ing".

[...snip...]
> @@ -2053,48 +2126,13 @@ print_details(struct key_state_ssl *ks_ssl, const=
 char *prefix)
>                        SSL_get_version(ks_ssl->ssl),
>                        SSL_CIPHER_get_version(ciph),
>                        SSL_CIPHER_get_name(ciph));
> -    cert =3D SSL_get_peer_certificate(ks_ssl->ssl);
> -    if (cert !=3D NULL)
> -    {
> -        EVP_PKEY *pkey =3D X509_get_pubkey(cert);
> -        if (pkey !=3D NULL)
> -        {
> -            if ((EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_RSA) && (EVP_PKEY_get=
0_RSA(pkey) !=3D NULL))
> -            {
> -                RSA *rsa =3D EVP_PKEY_get0_RSA(pkey);
> -                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
> -                                 RSA_bits(rsa));
> -            }
> -            else if ((EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_DSA) && (EVP_PKE=
Y_get0_DSA(pkey) !=3D NULL))
> -            {
> -                DSA *dsa =3D EVP_PKEY_get0_DSA(pkey);
> -                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> -                                 DSA_bits(dsa));
> -            }
> -#ifndef OPENSSL_NO_EC
> -            else if ((EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC) && (EVP_PKEY=
_get0_EC_KEY(pkey) !=3D NULL))
> -            {
> -                EC_KEY *ec =3D EVP_PKEY_get0_EC_KEY(pkey);
> -                const EC_GROUP *group =3D EC_KEY_get0_group(ec);
> -                const char *curve;

 From a styling perspective, I would suggest adding a space *before this li=
ne instead of *after*, as that will put it nicely in the same context as th=
e if(cert) in the chunk lower down.

> +    X509 *cert =3D SSL_get_peer_certificate(ks_ssl->ssl);
>=20=20=20
> -                int nid =3D EC_GROUP_get_curve_name(group);
> -                if (nid =3D=3D 0 || (curve =3D OBJ_nid2sn(nid)) =3D=3D N=
ULL)
> -                {
> -                    curve =3D "Error getting curve name";
> -                }
> -
> -                openvpn_snprintf(s2, sizeof(s2), ", %d bit EC, curve: %s=
",
> -                                 EC_GROUP_order_bits(group), curve);
> -
> -            }
> -#endif
> -            EVP_PKEY_free(pkey);
> -        }
> +    if (cert)
> +    {
> +        print_cert_details(cert, s2, sizeof(s2));
>           X509_free(cert);
>       }
> -    /* The SSL API does not allow us to look at temporary RSA/DH keys,
> -     * otherwise we should print their lengths too */
>       msg(D_HANDSHAKE, "%s%s", s1, s2);
>   }
>=20=20=20
>=20


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--ARM778z29uv7KtdbHqsJa5cqTw2wZ2Urc--

--xwiEfk1amadQx1DHTP47f0O63LONYPg1l
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBBS8QACgkQhs+UTJZx
/fK3qRAAhPJ+FPLObY2wl6EhK+GjyjD0Z/7soZPKtJmBVpHUNQlhzWj1o5uPq3Fx
pdTWWlaWaFXPp6nnMFEJM+7f5HXmoxn9eKgnAiqrPXUCpymPs3XUHHx/yDT4pj12
uEC7Yjjz6BTEO/S6UgghIROsh4EHNV2a2YFt56uF4BHJTZUhwzcX8joXL+35BFb+
cNbDSTN7Bttib2keGwCCKrdizc2otfMpp/W7JXY29wxYLfNhyg5s2onawBxRxDOZ
H4yqMy4V28IVSzo3OW52FMNeaMpzs+AY9SfRUuXFYDUQMVmTXixMd802bQXmuyp2
98SMH5MMMuHtmTwR33aM7smnieFx2127PshN478Uw6Dv8TMP97DFjoNu7NMMRZYb
9X3y+TeODxtTswdfvRVO+seZW03a5yuc9ye5IZGRMXfuhtShXPHidYWpES1NB1Hj
vpFLHG/VpH8hnrBH/ZuF0lyxYPpNVjlis/HSPiiNGi4+VTVeFuMkf62nUMk8BXXA
VUADjcrdPlE6O0vA+CrfPGL1VeKCw15wq5soX/hYB+NkVBkkk/aEmcVBpJ3AUPf9
zKesKMOZ1cgoj9zHoarb/IdEjhn8iH/j9NCPAgd5TbrGMc+reu/NPhYWDptP8TE1
x0fJMBHeYAfpORpcDaWug7bPkAFgby1Vx8lvol/WpwII76Z053E=
=hYO3
-----END PGP SIGNATURE-----

--xwiEfk1amadQx1DHTP47f0O63LONYPg1l--

