From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 21 May 2012 13:56:25 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9012D1DD35A4@...1436...>
References: <1337598254-32641-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1337598254-32641-1-git-send-email-alon.barlev@...277...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] build: check minimum polarssl version
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
To: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Looks good! I'll give it a feature ack. I don't see any problems in the aut=
oconf code, but I'm not an expert in that area. So a tentative ack there to=
o.

Adriaan

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> Sent: maandag 21 mei 2012 13:04
> To: openvpn-devel@lists.sourceforge.net
> Cc: Alon Bar-Lev
> Subject: [Openvpn-devel] [PATCH] build: check minimum polarssl version
>=20
> Pre 1.1 is unsupported, API was changed.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac index 4592727..5ace128 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -743,6 +743,27 @@ if test -z "${POLARSSL_LIBS}"; then
>  	)
>  fi
>=20
> +if test "${with_crypto_library}" =3D "polarssl" ; then
> +	AC_MSG_CHECKING([polarssl version])
> +	old_CFLAGS=3D"${CFLAGS}"
> +	CFLAGS=3D"${POLARSSL_CFLAGS} ${CFLAGS}"
> +	AC_COMPILE_IFELSE(
> +		[AC_LANG_PROGRAM(
> +			[[
> +#include <polarssl/version.h>
> +			]],
> +			[[
> +#if POLARSSL_VERSION_NUMBER <=3D 0x01010000 #error invalid version
> #endif
> +			]]
> +		)],
> +		[AC_MSG_RESULT([ok])],
> +		[AC_MSG_ERROR([invalid polarssl version])]
> +	)
> +	CFLAGS=3D"${old_CFLAGS}"
> +fi
> +
>  AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
> AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])  have_lzo=3D"yes"
> --
> 1.7.3.4
>=20
>=20
> -----------------------------------------------------------------------
> -------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

