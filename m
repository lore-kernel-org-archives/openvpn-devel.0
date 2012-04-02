MIME-Version: 1.0
In-Reply-To: <1333351687-3732-3-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<1333351687-3732-3-git-send-email-dejong@...1435...>
Date: Mon, 2 Apr 2012 12:14:14 +0300
Message-ID: <CAOazyz34dbH+tm+D2s5g0g0jC9Zin5yvT7a7eXzJpYqewwKi7w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] Use POLARSSL_CFLAGS instead of
 POLARSSL_CRYPTO_CFLAGS in configure.ac
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Right.
Sorry for this typo!

On Mon, Apr 2, 2012 at 10:28 AM, Adriaan de Jong <dejong@...1435...> wrote:
> Ensured that the used variable name actually matches the one advertised b=
y configure.
>
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
> =C2=A0configure.ac | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index ef34697..70c51e7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -821,7 +821,7 @@ case "${with_crypto_library}" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0polarssl)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0have_crypto_crypto=
=3D"${have_polarssl_crypto}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0have_crypto_ssl=3D=
"${have_polarssl_ssl}"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CRYPTO_CRYPTO_CFLAGS=
=3D"${POLARSSL_CRYPTO_CFLAGS}"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CRYPTO_CRYPTO_CFLAGS=
=3D"${POLARSSL_CFLAGS}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CRYPTO_CRYPTO_LIBS=
=3D"${POLARSSL_LIBS}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE([ENABLE_=
CRYPTO_POLARSSL], [1], [Use PolarSSL library])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

