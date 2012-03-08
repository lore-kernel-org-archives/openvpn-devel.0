Message-ID: <4F588F93.9060406@...515...>
Date: Thu, 08 Mar 2012 12:53:07 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-42-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-42-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 41/52] build: autoconf: update defaults
 for options
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
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

I'd rather not RTFM... could somebody explain to me what the funky
"@<:@default=3Dno@:>@" thing exactly does? Does it just add the default
"enabled/disabled" value to the help strings?

If so it's an ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |   56 ++++++++++++++++++++++++++++------------------------=
----
>  1 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 57d294d..9ffcc68 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -41,195 +41,195 @@ AC_USE_SYSTEM_EXTENSIONS
>
>  AC_ARG_ENABLE(
>         [lzo],
> -       [AS_HELP_STRING([--enable-lzo], [enable LZO compression support])=
],
> +       [AS_HELP_STRING([--enable-lzo], [enable LZO compression support @=
<:@default=3Dno@:>@])],
>         ,
>         [enable_lzo=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [lzo-stub],
> -       [AS_HELP_STRING([--enable-lzo-stub], [don't compile LZO compressi=
on support but still allow limited interoperability with LZO-enabled peers]=
)],
> +       [AS_HELP_STRING([--enable-lzo-stub], [don't compile LZO compressi=
on support but still allow limited interoperability with LZO-enabled peers =
@<:@default=3Dno@:>@])],
>         ,
>         [enable_lzo_stub=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [crypto],
> -       [AS_HELP_STRING([--disable-crypto], [disable crypto support])],
> +       [AS_HELP_STRING([--disable-crypto], [disable crypto support @<:@d=
efault=3Dyes@:>@])],
>         ,
>         [enable_crypto=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [ssl],
> -       [AS_HELP_STRING([--disable-ssl], [disable SSL support for TLS-bas=
ed key exchange])],
> +       [AS_HELP_STRING([--disable-ssl], [disable SSL support for TLS-bas=
ed key exchange @<:@default=3Dyes@:>@])],
>         ,
>         [enable_ssl=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [x509-alt-username],
> -       [AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-=
username-field feature])],
> +       [AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-=
username-field feature @<:@default=3Dno@:>@])],
>         ,
>         [enable_x509_alt_username=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [multi],
> -       [AS_HELP_STRING([--disable-multi], [disable client/server support=
 (--mode server + client mode)])],
> +       [AS_HELP_STRING([--disable-multi], [disable client/server support=
 (--mode server + client mode) @<:@default=3Dyes@:>@])],
>         ,
>         [enable_multi=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [server],
> -       [AS_HELP_STRING([--disable-server], [disable server support only =
(but retain client support)])],
> +       [AS_HELP_STRING([--disable-server], [disable server support only =
(but retain client support) @<:@default=3Dyes@:>@])],
>         ,
>         [enable_server=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [plugins],
> -       [AS_HELP_STRING([--disable-plugins], [disable plug-in support])],
> +       [AS_HELP_STRING([--disable-plugins], [disable plug-in support @<:=
@default=3Dyes@:>@])],
>         ,
>         [enable_plugins=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [eurephia],
> -       [AS_HELP_STRING([--disable-eurephia], [disable support for the eu=
rephia plug-in])],
> +       [AS_HELP_STRING([--disable-eurephia], [disable support for the eu=
rephia plug-in @<:@default=3Dyes@:>@])],
>         ,
>         [enable_eurephia=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [management],
> -       [AS_HELP_STRING([--disable-management], [disable management serve=
r support])],
> +       [AS_HELP_STRING([--disable-management], [disable management serve=
r support @<:@default=3Dyes@:>@])],
>         ,
>         [enable_management=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [pkcs11],
> -       [AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support])],
> +       [AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support @<:@def=
ault=3Dno@:>@])],
>         ,
>         [enable_pkcs11=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [socks],
> -       [AS_HELP_STRING([--disable-socks], [disable Socks support])],
> +       [AS_HELP_STRING([--disable-socks], [disable Socks support @<:@def=
ault=3Dyes@:>@])],
>         ,
>         [enable_socks=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [http-proxy],
> -       [AS_HELP_STRING([--disable-http-proxy], [disable HTTP proxy suppo=
rt])],
> +       [AS_HELP_STRING([--disable-http-proxy], [disable HTTP proxy suppo=
rt @<:@default=3Dyes@:>@])],
>         ,
>         [enable_http_proxy=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [fragment],
> -       [AS_HELP_STRING([--disable-fragment], [disable internal fragmenta=
tion support (--fragment)])],
> +       [AS_HELP_STRING([--disable-fragment], [disable internal fragmenta=
tion support (--fragment) @<:@default=3Dyes@:>@])],
>         ,
>         [enable_fragment=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [multihome],
> -       [AS_HELP_STRING([--disable-multihome], [disable multi-homed UDP s=
erver support (--multihome)])],
> +       [AS_HELP_STRING([--disable-multihome], [disable multi-homed UDP s=
erver support (--multihome) @<:@default=3Dyes@:>@])],
>         ,
>         [enable_multihome=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [port-share],
> -       [AS_HELP_STRING([--disable-port-share], [disable TCP server port-=
share support (--port-share)])],
> +       [AS_HELP_STRING([--disable-port-share], [disable TCP server port-=
share support (--port-share) @<:@default=3Dyes@:>@])],
>         ,
>         [enable_port_share=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [debug],
> -       [AS_HELP_STRING([--disable-debug], [disable debugging support (di=
sable gremlin and verb 7+ messages)])],
> +       [AS_HELP_STRING([--disable-debug], [disable debugging support (di=
sable gremlin and verb 7+ messages) @<:@default=3Dyes@:>@])],
>         ,
>         [enable_debug=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [small],
> -       [AS_HELP_STRING([--enable-small], [enable smaller executable size=
 (disable OCC, usage message, and verb 4 parm list)])],
> +       [AS_HELP_STRING([--enable-small], [enable smaller executable size=
 (disable OCC, usage message, and verb 4 parm list) @<:@default=3Dyes@:>@])=
],
>         ,
>         [enable_small=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [password-save],
> -       [AS_HELP_STRING([--enable-password-save], [allow --askpass and --=
auth-user-pass passwords to be read from a file])],
> +       [AS_HELP_STRING([--enable-password-save], [allow --askpass and --=
auth-user-pass passwords to be read from a file @<:@default=3Dyes@:>@])],
>         [enable_password_save=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [iproute2],
> -       [AS_HELP_STRING([--enable-iproute2], [enable support for iproute2=
])],
> +       [AS_HELP_STRING([--enable-iproute2], [enable support for iproute2=
 @<:@default=3Dno@:>@])],
>         ,
>         [enable_iproute2=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [def-auth],
> -       [AS_HELP_STRING([--disable-def-auth], [disable deferred authentic=
ation])],
> +       [AS_HELP_STRING([--disable-def-auth], [disable deferred authentic=
ation @<:@default=3Dyes@:>@])],
>         ,
>         [enable_def_auth=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [pf],
> -       [AS_HELP_STRING([--disable-pf], [disable internal packet filter])=
],
> +       [AS_HELP_STRING([--disable-pf], [disable internal packet filter @=
<:@default=3Dyes@:>@])],
>         ,
>         [enable_pf=3D"yes"]
>  )
>
>  AC_ARG_ENABLE(
>         [strict],
> -       [AS_HELP_STRING([--enable-strict], [enable strict compiler warnin=
gs (debugging option)])],
> +       [AS_HELP_STRING([--enable-strict], [enable strict compiler warnin=
gs (debugging option) @<:@default=3Dno@:>@])],
>         ,
>         [enable_strict=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [pedantic],
> -       [AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler wa=
rnings, will not generate a working executable (debugging option)])],
> +       [AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler wa=
rnings, will not generate a working executable (debugging option) @<:@defau=
lt=3Dno@:>@])],
>         ,
>         [enable_pedantic=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [strict-options],
> -       [AS_HELP_STRING([--enable-strict-options], [enable strict options=
 check between peers (debugging option)])],
> +       [AS_HELP_STRING([--enable-strict-options], [enable strict options=
 check between peers (debugging option) @<:@default=3Dno@:>@])],
>         ,
>         [enable_strict_options=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [selinux],
> -       [AS_HELP_STRING([--enable-selinux], [enable SELinux support])],
> +       [AS_HELP_STRING([--enable-selinux], [enable SELinux support @<:@d=
efault=3Dno@:>@])],
>         ,
>         [enable_selinux=3D"no"]
>  )
>
>  AC_ARG_ENABLE(
>         [systemd],
> -       [AS_HELP_STRING([--enable-systemd], [enable systemd suppport])],
> +       [AS_HELP_STRING([--enable-systemd], [enable systemd suppport @<:@=
default=3Dno@:>@])],
>         ,
>         [enable_systemd=3D"no"]
>  )
>
>  AC_ARG_WITH(
>         [mem-check],
> -       [AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memo=
ry checking, TYPE=3Ddmalloc|valgrind|ssl])],
> +       [AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memo=
ry checking, TYPE=3Dno|dmalloc|valgrind|ssl @<:@default=3Dno@:>@])],
>         [
>                 case "${withval}" in
>                         dmalloc|valgrind|ssl|no) ;;
> --
> 1.7.3.4
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



