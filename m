References: <20200912153647.10631-1-themiron@...2010...>
 <20201005005114.13619-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bc4cae77-c7cc-8158-c5e0-5b00cd193418@...1227...>
Date: Mon, 5 Oct 2020 10:25:56 +0200
MIME-Version: 1.0
In-Reply-To: <20201005005114.13619-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B4Zl8JD0XnnEwHWfTV2Xys9BntD48BNGh"
Subject: Re: [Openvpn-devel] [PATCH v5] Support X509 field list to be
 username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B4Zl8JD0XnnEwHWfTV2Xys9BntD48BNGh
Content-Type: multipart/mixed; boundary="5rR3ZNWb9luyjU4eDJx8YPGMJSBC1SlCr"

--5rR3ZNWb9luyjU4eDJx8YPGMJSBC1SlCr
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 05.10.20 um 02:51 schrieb Vladislav Grishenko:
> OpenVPN has the ability to choose different X509 field in case "CN" can
> not be use used to be unique connected username since commit
> 935c62be9c0c8a256112df818bfb8470586a23b6 "Choose a different field in
> X509 to be username".
> Unfortunately it's not enough in case when client has multiple and
> valid certificates from PKI for different devices (ex. laptop,
> mobile, etc) with the same CN/UID.
>=20
> Having --duplicate-cn as a workaround helps only partially: clients can
> be connected, but it breaks coexistance with --ifconfig-pool-persist,
> --client-config-dir and opens doors to DoS possibility since same client
> device (with the same cert) being reconnected no more replaces previously
> connected session, so it can exhaust server resources (ex. address pool)
> and can prevent other clients to be connected.
>=20
> With this patch, multiple X509 fields incl. "serialNumber" can be chosen
> to be username with --x509-username-field parameters, they will be
> concatened into the one username using '_' separator. As long as the
> resulting username is unique, --duplicate-cn will not be required.
> Default field is preserved as "CN".
>=20
> Openssl backend is the only supported, since so far MbedTLS has no
> --x509-username-field support at all.
>=20
> v2: conform C99, man update, fix typos
> v3: reuse buffer methods, drop delimiter define, use memcpy
> v4: man update, change separator "_" to avoid path issues on windows
> v5: mention collision possibility with "_" separator in man
>     capitalize hex serialNumber value

> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index 454efeec..34e1de01 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -269,6 +269,21 @@ backend_x509_get_username(char *common_name, int cn_=
len,
>              return FAILURE;
>          }
>      }
> +    else if (strcmp(LN_serialNumber,x509_username_field) =3D=3D 0)
> +    {

Whitespace error after ,

Otherwise the patch looks good now. (We had informal reviews on IRC that
prompted the newer versions)

Acked-By: Arne Schwabe <arne@...1227...>


--5rR3ZNWb9luyjU4eDJx8YPGMJSBC1SlCr--

--B4Zl8JD0XnnEwHWfTV2Xys9BntD48BNGh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl962JUACgkQFRhsZwKx
RFSy1Q//YWfEWq2h6d+4PFPaZBUwcnBYj7vxZvzS97lrX5wuaDohGmlVa7aaqoQx
zt+XfyJ1hC4bhK7OlT71Jh2JBqmqJN5J+BNCWM7i/0/Avh4AjIFfhIOIwDr5A0SG
CXmt7nBSbTirKRZgFs9G9+x31n7vKYEbDeu99g6MGYOjxWDhpgGMofWWtZD4Dd+u
tfsj3utS7gOfuH7o9xY9M1MmaxCz6qmzpEwHtg1olioHITkF7Dhk8Dr2lfNCsvh+
yaJvkHscWA52XFDW8V/oY+NEaJFP0rXi37eH32unfqNDW+3+wUxnY0gT9qD3vC2Y
+sjwIb8m3ObSbsCBqINGEvS7Tc/vSX9snCM98b3ybke94HtH0i+VG9m0dhvzTsAj
swQWS0EiM9B8fnIJFi/UcvSlol2J06DINxwNvQRCUw4pbFvJByR2zz+JxW0sEp19
n2HDTqH365rEcAEAuP8PmA7n1qja1vu75Mxjdlp+Kxzr/M68djPg73L8+iUKTPmn
E78pmxel1RBvnM0ugrxonbcnY4mBo5YXYQPlXxGpTR52LSev84uUgug7cSrAD9ie
ANj6nI+Q+G+uYV4HJ/8PYyLeb9PZUaE88zg+UuX6H4ZRYmpEB8YPMwQqRZUbWKaa
jwpSbIDMDdUpYzAT1haW6jx19r7ri44Ko1WOS/gdLIezaEDhsUY=
=vHsC
-----END PGP SIGNATURE-----

--B4Zl8JD0XnnEwHWfTV2Xys9BntD48BNGh--

