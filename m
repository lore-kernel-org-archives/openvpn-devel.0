Date: Sun, 7 Jun 2020 13:11:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200607111138.GA50189@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-3-James.Bottomley@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20200528225920.6983-3-James.Bottomley@...2316...>
Subject: Re: [Openvpn-devel] [PATCH v6 2/3] crypto_openssl: add
 initialization to pick up local configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: openvpn-devel@lists.sourceforge.net

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 4ac77fde..fd57edd2 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -149,6 +149,11 @@ crypto_init_lib_engine(const char *engine_name)
>  void
>  crypto_init_lib(void)
>  {
> +#if (OPENSSL_VERSION_NUMBER >=3D 0x10100000L)
> +    OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
> +#else
> +    OPENSSL_config(NULL);
> +#endif

This is failing on some of the Travis builds, with the error message

1191 crypto_openssl.c: In function `crypto_init_lib':
1192 crypto_openssl.c:155:5: error: implicit declaration of function `OPENS=
SL_config'; did you mean `OPENSSL_init'? [-Werror=3Dimplicit-function-decla=
ration]
1193     OPENSSL_config(NULL);
1194     ^~~~~~~~~~~~~~

https://travis-ci.org/github/OpenVPN/openvpn/builds/695633823
--CE+1k2dSO48ffgeK--
