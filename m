MIME-Version: 1.0
In-Reply-To: <4F588F93.9060406@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-42-git-send-email-alon.barlev@...277...>
	<4F588F93.9060406@...515...>
Date: Thu, 8 Mar 2012 21:30:32 +0200
Message-ID: <CAOazyz2n5O6VxaGOLKbombwnx5UqLEjY6ARi9GpgMzziD0cbSw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Yes. You cannot put '[' or ']' in m4.

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> I'd rather not RTFM... could somebody explain to me what the funky
> "@<:@default=3Dno@:>@" thing exactly does? Does it just add the default
> "enabled/disabled" value to the help strings?
>
> If so it's an ACK.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0configure.ac | =C2=A0 56 ++++++++++++++++++++++++++++-------------=
---------------
>> =C2=A01 files changed, 28 insertions(+), 28 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 57d294d..9ffcc68 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -41,195 +41,195 @@ AC_USE_SYSTEM_EXTENSIONS
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [lzo],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-lzo], [enable LZO compr=
ession support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-lzo], [enable LZO compr=
ession support @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_lzo=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [lzo-stub],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-lzo-stub], [don't compi=
le LZO compression support but still allow limited interoperability with LZ=
O-enabled peers])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-lzo-stub], [don't compi=
le LZO compression support but still allow limited interoperability with LZ=
O-enabled peers @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_lzo_stub=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [crypto],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-crypto], [disable cryp=
to support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-crypto], [disable cryp=
to support @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_crypto=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ssl],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-ssl], [disable SSL sup=
port for TLS-based key exchange])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-ssl], [disable SSL sup=
port for TLS-based key exchange @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_ssl=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [x509-alt-username],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-x509-alt-username], [en=
able the --x509-username-field feature])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-x509-alt-username], [en=
able the --x509-username-field feature @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_x509_alt_username=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [multi],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-multi], [disable clien=
t/server support (--mode server + client mode)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-multi], [disable clien=
t/server support (--mode server + client mode) @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_multi=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [server],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-server], [disable serv=
er support only (but retain client support)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-server], [disable serv=
er support only (but retain client support) @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_server=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [plugins],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-plugins], [disable plu=
g-in support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-plugins], [disable plu=
g-in support @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_plugins=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [eurephia],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-eurephia], [disable su=
pport for the eurephia plug-in])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-eurephia], [disable su=
pport for the eurephia plug-in @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_eurephia=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [management],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-management], [disable =
management server support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-management], [disable =
management server support @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_management=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [pkcs11],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-pkcs11], [enable pkcs11=
 support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-pkcs11], [enable pkcs11=
 support @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_pkcs11=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [socks],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-socks], [disable Socks=
 support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-socks], [disable Socks=
 support @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_socks=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [http-proxy],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-http-proxy], [disable =
HTTP proxy support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-http-proxy], [disable =
HTTP proxy support @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_http_proxy=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [fragment],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-fragment], [disable in=
ternal fragmentation support (--fragment)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-fragment], [disable in=
ternal fragmentation support (--fragment) @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_fragment=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [multihome],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-multihome], [disable m=
ulti-homed UDP server support (--multihome)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-multihome], [disable m=
ulti-homed UDP server support (--multihome) @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_multihome=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [port-share],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-port-share], [disable =
TCP server port-share support (--port-share)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-port-share], [disable =
TCP server port-share support (--port-share) @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_port_share=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [debug],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-debug], [disable debug=
ging support (disable gremlin and verb 7+ messages)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-debug], [disable debug=
ging support (disable gremlin and verb 7+ messages) @<:@default=3Dyes@:>@])=
],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_debug=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [small],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-small], [enable smaller=
 executable size (disable OCC, usage message, and verb 4 parm list)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-small], [enable smaller=
 executable size (disable OCC, usage message, and verb 4 parm list) @<:@def=
ault=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_small=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [password-save],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-password-save], [allow =
--askpass and --auth-user-pass passwords to be read from a file])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-password-save], [allow =
--askpass and --auth-user-pass passwords to be read from a file @<:@default=
=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_password_save=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [iproute2],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-iproute2], [enable supp=
ort for iproute2])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-iproute2], [enable supp=
ort for iproute2 @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_iproute2=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [def-auth],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-def-auth], [disable de=
ferred authentication])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-def-auth], [disable de=
ferred authentication @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_def_auth=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [pf],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-pf], [disable internal=
 packet filter])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-pf], [disable internal=
 packet filter @<:@default=3Dyes@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_pf=3D"yes"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [strict],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-strict], [enable strict=
 compiler warnings (debugging option)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-strict], [enable strict=
 compiler warnings (debugging option) @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_strict=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [pedantic],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-pedantic], [enable peda=
ntic compiler warnings, will not generate a working executable (debugging o=
ption)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-pedantic], [enable peda=
ntic compiler warnings, will not generate a working executable (debugging o=
ption) @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_pedantic=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [strict-options],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-strict-options], [enabl=
e strict options check between peers (debugging option)])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-strict-options], [enabl=
e strict options check between peers (debugging option) @<:@default=3Dno@:>=
@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_strict_options=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [selinux],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-selinux], [enable SELin=
ux support])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-selinux], [enable SELin=
ux support @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_selinux=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [systemd],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-systemd], [enable syste=
md suppport])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-systemd], [enable syste=
md suppport @<:@default=3Dno@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_systemd=3D"no"]
>> =C2=A0)
>>
>> =C2=A0AC_ARG_WITH(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [mem-check],
>> - =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--with-mem-check=3DTYPE], [build=
 with debug memory checking, TYPE=3Ddmalloc|valgrind|ssl])],
>> + =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--with-mem-check=3DTYPE], [build=
 with debug memory checking, TYPE=3Dno|dmalloc|valgrind|ssl @<:@default=3Dn=
o@:>@])],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "${withval}=
" in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dmalloc|valgrind|ssl|no) ;;
>> --
>> 1.7.3.4
>>
>>
>> ------------------------------------------------------------------------=
------
>> Virtualization & Cloud Management Using Capacity Planning
>> Cloud computing makes use of virtualization - but cloud computing
>> also focuses on allowing computing to be delivered as a service.
>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

