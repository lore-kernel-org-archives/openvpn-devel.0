Message-ID: <51273023.4040400@...1147...>
Date: Fri, 22 Feb 2013 09:45:23 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1361398327-26258-1-git-send-email-chris.j.arges@...1808...>
In-Reply-To: <1361398327-26258-1-git-send-email-chris.j.arges@...1808...>
Subject: Re: [Openvpn-devel] [PATCH] Add auto value to pkcs11-id parameter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Chris J Arges <chris.j.arges@...1808...>
Cc: o.dumschat@...1809..., openvpn-devel@lists.sourceforge.net

Chris J Arges wrote:
> This patch allows one to specify --pkcs11-id auto to automatically
> select the first certificate on a pkcs11 device. This simplifies
> scripts and usage in environments where clients may only use a single
> certificate for connecting to a VPN.
> Based on a patch by Oliver Dumschat-H=C3=B6tte.
>
>=20=20=20
some security-minded (paranoid?) folks will say that you should never=20
automatically select a certificate/key pair (which is what a normal user=20
would want, of course).  This patch does seem like a useful addition,=20
and it actually restores some functionality found in earlier versions of=20
OpenVPN, IIRC.  Perhaps more warnings should be added about this being a=20
(minor) security risk.

A man page snippet for this is missing from the patch, but that can be=20
done if the patch is ACKed by others.
I'm not authoratitive on ACKing patches, but as far as I am concerned: ACK

JJK

> Reported-by: Oliver Dumschat-H=C3=B6tte <o.dumschat@...1809...>
> Signed-off-by: Chris J Arges <chris.j.arges@...1808...>
> ---
>  src/openvpn/pkcs11.c |   41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
> index 3a15ef6..11d5e8f 100644
> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -669,14 +669,39 @@ tls_ctx_use_pkcs11 (
>  		}
>  	}
>  	else {
> -		if (
> -			(rv =3D pkcs11h_certificate_deserializeCertificateId (
> -				&certificate_id,
> -				pkcs11_id
> -			)) !=3D CKR_OK
> -		) {
> -			msg (M_WARN, "PKCS#11: Cannot deserialize id %ld-'%s'", rv, pkcs11h_g=
etMessage (rv));
> -			goto cleanup;
> +		if ( strcmp(pkcs11_id, "auto") =3D=3D 0 ) {
> +			char *pkcs11_id_read =3D NULL;
> +			char *base64 =3D NULL;
> +			if ( !pkcs11_management_id_get(
> +			       0,
> +			       &pkcs11_id_read,
> +			       &base64
> +			   )
> +			) {
> +				msg (M_WARN, "PKCS#11: pkcs11_management_id_get 0 failed");
> +				goto cleanup;
> +			}
> +			if (
> +				(rv =3D pkcs11h_certificate_deserializeCertificateId (
> +					&certificate_id,
> +					pkcs11_id_read
> +				)) !=3D CKR_OK
> +			) {
> +				msg (M_WARN, "PKCS#11: Cannot deserialize auto id %ld-'%s'", rv,
> +				     pkcs11h_getMessage (rv));
> +				goto cleanup;
> +			}
> +		} else {
> +			if (
> +				(rv =3D pkcs11h_certificate_deserializeCertificateId (
> +					&certificate_id,
> +					pkcs11_id
> +				)) !=3D CKR_OK
> +			) {
> +				msg (M_WARN, "PKCS#11: Cannot deserialize id %ld-'%s'", rv,
> +				     pkcs11h_getMessage (rv));
> +				goto cleanup;
> +			}
>  		}
>  	}
>=20=20
>=20=20=20


