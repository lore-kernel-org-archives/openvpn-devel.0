Message-ID: <4FD07A2F.6090202@...515...>
Date: Thu, 07 Jun 2012 12:53:51 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3gNKF8OmTjm+rb_8-Wi0pzuihwh5u_85X-3sgsb3Bqfw@...278...>
	<1339061824-16542-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1339061824-16542-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: support =polarssl-1.1.0
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 07.06.2012 12:37, Alon Bar-Lev ha scritto:
> Repoted-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 339164f..9511317 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -755,7 +755,7 @@ if test "${with_crypto_library}" =3D "polarssl" ; then
>  #include <polarssl/version.h>
>  			]],
>  			[[
> -#if POLARSSL_VERSION_NUMBER <=3D 0x01010000
> +#if POLARSSL_VERSION_NUMBER < 0x01010000
>  #error invalid version
>  #endif
>  			]]
Fixes the reported issue, tested on Ubuntu 10.04.

ACK.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


