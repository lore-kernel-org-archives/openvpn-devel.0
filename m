MIME-Version: 1.0
In-Reply-To: <1340719406-12157-1-git-send-email-alon.barlev@...277...>
References: <CAOazyz3e6j+t5BPqpUa6iTErsVzm9Nof4EtP+atx9vvBKNsobw@...278...>
	<1340719406-12157-1-git-send-email-alon.barlev@...277...>
Date: Tue, 26 Jun 2012 17:03:56 +0300
Message-ID: <CAOazyz1ArCcSZGj110b9Y1KT50TqYBqMLUOC78ZORmtoNN-4EQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

This removes the Linux from the help string.

On Tue, Jun 26, 2012 at 5:03 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> pam cannot be compiled on OpenBSD and Windows.
> down-root cannot be compiled on Windows.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0configure.ac | =C2=A0 21 ++++++++++++++++-----
> =C2=A01 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index db19d4a..d3d974d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -195,16 +195,27 @@ AC_ARG_ENABLE(
>
> =C2=A0AC_ARG_ENABLE(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[plugin-auth-pam],
> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-plugin-auth-pam], [disa=
ble auth-pam plugin @<:@default=3Dyes@:>@])],
> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-plugin-auth-pam], [disa=
ble auth-pam plugin @<:@default=3Dplatform specific@:>@])],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> - =C2=A0 =C2=A0 =C2=A0 [enable_plugin_auth_pam=3D"yes"]
> + =C2=A0 =C2=A0 =C2=A0 [
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$host" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *-*-openbsd*) enable_plugin_auth_pam=3D"no";;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *-mingw*) enable_plugin_auth_pam=3D"no";;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *) enable_plugin_auth_pam=3D"yes";;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
> + =C2=A0 =C2=A0 =C2=A0 ]
> =C2=A0)
>
> =C2=A0AC_ARG_ENABLE(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[plugin-down-root],
> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-plugin-down-root], [dis=
able down-root plugin @<:@default=3Dyes@:>@])],
> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-plugin-down-root], [dis=
able down-root plugin @<:@default=3Dplatform specific@:>@])],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> - =C2=A0 =C2=A0 =C2=A0 [enable_plugin_down_root=3D"yes"]
> + =C2=A0 =C2=A0 =C2=A0 [
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$host" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *-mingw*) enable_plugin_down_root=3D"no";;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *) enable_plugin_down_root=3D"yes";;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
> + =C2=A0 =C2=A0 =C2=A0 ]
> =C2=A0)
>
> =C2=A0AC_ARG_ENABLE(
> --
> 1.7.3.4
>

