From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 29 Nov 2013 13:44:22 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901521E3A880@...1436...>
References: <CAA1AbxJYSMkSCzbaQL5-Nb4D-uObHe_ePPqSMwEr93HF=kA0=w@...278...>
	<1385728360-32127-1-git-send-email-arne@...1227...>
In-Reply-To: <1385728360-32127-1-git-send-email-arne@...1227...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Move ASSERT so external-key with
 OpenSSL	works again
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

ACK

-Steffan

> -----Original Message-----
> From: Arne Schwabe [mailto:arne@...1227...]
> Sent: vrijdag 29 november 2013 13:33
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] [PATCH] Move ASSERT so external-key with
> OpenSSL works again
>=20
> ---
>  src/openvpn/ssl_openssl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 120aa66..f41bb71 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -682,10 +682,11 @@ tls_ctx_use_external_private_key (struct
> tls_root_ctx *ctx,
>    X509 *cert =3D NULL;
>=20
>    ASSERT (NULL !=3D ctx);
> -  ASSERT (NULL !=3D cert);
>=20
>    tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline,
> &cert);
>=20
> +  ASSERT (NULL !=3D cert);
> +
>    /* allocate custom RSA method object */
>    ALLOC_OBJ_CLEAR (rsa_meth, RSA_METHOD);
>    rsa_meth->name =3D "OpenVPN external private key RSA Method";
> --
> 1.8.3.4 (Apple Git-47)
>=20
>=20
> -----------------------------------------------------------------------
> -------
> Rapidly troubleshoot problems before they affect your business. Most IT
> organizations don't have a clear picture of how application performance
> affects their revenue. With AppDynamics, you get 100% visibility into
> your
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of
> AppDynamics Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=3D84349351&iu=3D/4140/ostg.=
cl
> ktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

