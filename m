Message-ID: <4FEB0BA6.8030905@...515...>
Date: Wed, 27 Jun 2012 16:33:26 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3e6j+t5BPqpUa6iTErsVzm9Nof4EtP+atx9vvBKNsobw@...278...>
	<1340719406-12157-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1340719406-12157-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: plugins: set defaults using a
 complex logic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Without this patch cross-compiling for Windows on Linux failed because
--enable-plugin-pam/-down-root was on by default. With this patch
building succeeded.

ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> pam cannot be compiled on OpenBSD and Windows.
> down-root cannot be compiled on Windows.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index db19d4a..d3d974d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -195,16 +195,27 @@ AC_ARG_ENABLE(
>=20=20
>  AC_ARG_ENABLE(
>  	[plugin-auth-pam],
> -	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @=
<:@default=3Dyes@:>@])],
> +	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @=
<:@default=3Dplatform specific@:>@])],
>  	,
> -	[enable_plugin_auth_pam=3D"yes"]
> +	[
> +		case "$host" in
> +			*-*-openbsd*) enable_plugin_auth_pam=3D"no";;
> +			*-mingw*) enable_plugin_auth_pam=3D"no";;
> +			*) enable_plugin_auth_pam=3D"yes";;
> +		esac
> +	]
>  )
>=20=20
>  AC_ARG_ENABLE(
>  	[plugin-down-root],
> -	[AS_HELP_STRING([--disable-plugin-down-root], [disable down-root plugin=
 @<:@default=3Dyes@:>@])],
> +	[AS_HELP_STRING([--disable-plugin-down-root], [disable down-root plugin=
 @<:@default=3Dplatform specific@:>@])],
>  	,
> -	[enable_plugin_down_root=3D"yes"]
> +	[
> +		case "$host" in
> +			*-mingw*) enable_plugin_down_root=3D"no";;
> +			*) enable_plugin_down_root=3D"yes";;
> +		esac
> +	]
>  )
>=20=20
>  AC_ARG_ENABLE(



