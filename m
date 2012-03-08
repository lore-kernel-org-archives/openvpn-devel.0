MIME-Version: 1.0
In-Reply-To: <4F587F1A.2050905@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-32-git-send-email-alon.barlev@...277...>
	<4F587F1A.2050905@...515...>
Date: Thu, 8 Mar 2012 21:38:27 +0200
Message-ID: <CAOazyz1bT9-1fGdSK4d-gpqHMgceMjbM8Zi9rO3zMp7wG9Jf9A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 31/52] build: autoconf: commands as
	environment
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

Just like CPP, CC, CXX, LD, AR, PKG_CONFIG
Programs are expected to be in environment.
The autoconf detection get/set these in environment too.

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> So, this patch replaces (removes?) the "--with-<executable>-path" configu=
re options with environment variables, right? =C2=A0For example, if one has=
 "ifconfig" in a non-standard place, he can set the IFCONFIG environment va=
riable and the build will find it. Did I understand this correctly?
>
> I don't know autotools well enough to give this one an ACK at this point.=
 That said, the patch does clean up configure.ac a lot, and cleanups are al=
ways nice :).
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
>> =C2=A0configure.ac | =C2=A0 66 ++++++++++++++++++++++++-----------------=
----------------
>> =C2=A01 files changed, 28 insertions(+), 38 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 6b5cf71..ed98464 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -267,37 +267,6 @@ AC_ARG_WITH(
>> =C2=A0)
>>
>> =C2=A0AC_ARG_WITH(
>> - =C2=A0 =C2=A0 [ifconfig-path],
>> - =C2=A0 =C2=A0 [AS_HELP_STRING([--with-ifconfig-path=3DPATH], [Path to =
ifconfig tool])],
>> - =C2=A0 =C2=A0 [IFCONFIG=3D"$withval"],
>> - =C2=A0 =C2=A0 [AC_PATH_PROG([IFCONFIG], [ifconfig], [ifconfig], [$PATH=
:/usr/local/sbin:/usr/sbin:/sbin])]
>> -)
>> -AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig to=
ol])
>> -
>> -AC_ARG_WITH(
>> - =C2=A0 =C2=A0 [iproute-path],
>> - =C2=A0 =C2=A0 [AS_HELP_STRING([--with-iproute-path=3DPATH], [Path to i=
proute tool])],
>> - =C2=A0 =C2=A0 [IPROUTE=3D"$withval"],
>> - =C2=A0 =C2=A0 [AC_PATH_PROG([IPROUTE], [ip], [ip], [$PATH:/usr/local/s=
bin:/usr/sbin:/sbin])]
>> -)
>> -AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
>> -
>> -AC_ARG_WITH([route-path],
>> - =C2=A0 [AS_HELP_STRING([--with-route-path=3DPATH], [Path to route tool=
])],
>> - =C2=A0 [ROUTE=3D"$withval"],
>> - =C2=A0 [AC_PATH_PROG([ROUTE], [route], [route], [$PATH:/usr/local/sbin=
:/usr/sbin:/sbin])]
>> -)
>> -AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
>> -
>> -AC_ARG_WITH(
>> - =C2=A0 =C2=A0 [netstat-path],
>> - =C2=A0 =C2=A0 [AS_HELP_STRING([--with-netstat-path=3DPATH], [Path to n=
etstat tool])],
>> - =C2=A0 =C2=A0 [NETSTAT=3D"$withval"],
>> - =C2=A0 =C2=A0 [AC_PATH_PROG([NETSTAT], [netstat], [netstat], [$PATH:/u=
sr/local/sbin:/usr/sbin:/sbin:/etc])]
>> -)
>> -AC_DEFINE_UNQUOTED([NETSTAT_PATH], ["$NETSTAT"], [Path to netstat tool])
>> -
>> -AC_ARG_WITH(
>> =C2=A0 =C2=A0 =C2=A0 [mem-check],
>> =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--with-mem-check=3DTYPE], [build w=
ith debug memory checking, TYPE=3Ddmalloc|valgrind|ssl])],
>> =C2=A0 =C2=A0 =C2=A0 [
>> @@ -370,6 +339,20 @@ AC_PROG_INSTALL
>> =C2=A0AC_PROG_LN_S
>> =C2=A0AC_PROG_MAKE_SET
>>
>> +AC_ARG_VAR([IFCONFIG], [full path to ipconfig utility])
>> +AC_ARG_VAR([ROUTE], [full path to route utility])
>> +AC_ARG_VAR([IPROUTE], [full path to ip utility])
>> +AC_ARG_VAR([NETSTAT], [path to netstat utility]) # tests
>> +AC_ARG_VAR([MAN2HTML], [path to man2html utility])
>> +AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin=
:/sbin])
>> +AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin=
])
>> +AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
>> +AC_CHECK_PROGS([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:=
/usr/sbin:/sbin:/etc]) # tests
>> +AC_CHECK_PROGS([MAN2HTML], [man2html])
>> +AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig to=
ol])
>> +AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
>> +AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
>> +
>> =C2=A0#
>> =C2=A0# Libtool
>> =C2=A0#
>> @@ -386,12 +369,6 @@ ifdef(
>> =C2=A0 =C2=A0 =C2=A0 ]
>> =C2=A0)
>>
>> -if test "${WIN32}" =3D "yes"; then
>> - =C2=A0 =C2=A0 AC_ARG_VAR([MAN2HTML], [man2html utility])
>> - =C2=A0 =C2=A0 AC_CHECK_PROGS([MAN2HTML], [man2html])
>> - =C2=A0 =C2=A0 test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is requi=
red for win32])
>> -fi
>> -
>> =C2=A0AC_C_CONST
>> =C2=A0AC_C_INLINE
>> =C2=A0AC_C_VOLATILE
>> @@ -920,7 +897,16 @@ test "${enable_pf}" =3D "yes" && AC_DEFINE([ENABLE_=
PF], [1], [Enable internal pack
>> =C2=A0test "${enable_strict_options}" =3D "yes" && AC_DEFINE([ENABLE_STR=
ICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
>> =C2=A0test "${enable_password_save}" =3D "yes" && AC_DEFINE([ENABLE_PASS=
WORD_SAVE], [1], [Allow --askpass and --auth-user-pass passwords to be read=
 from a file])
>> =C2=A0test "${enable_systemd}" =3D "yes" && AC_DEFINE([ENABLE_SYSTEMD], =
[1], [Enable systemd support])
>> -test "${enable_iproute2}" =3D "yes" && AC_DEFINE([ENABLE_IPROUTE], [1],=
 [enable iproute2 support])
>> +
>> +if test "${enable_iproute2}" =3D "yes"; then
>> + =C2=A0 =C2=A0 test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is requ=
ired but missing])
>> + =C2=A0 =C2=A0 AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 suppor=
t])
>> +else
>> + =C2=A0 =C2=A0 if test "${WIN32}" !=3D "yes"; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test -z "${ROUTE}" && AC_MSG=
_ERROR([route utility is required but missing])
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test -z "${IFCONFIG}" && AC_=
MSG_ERROR([ifconfig utility is required but missing])
>> + =C2=A0 =C2=A0 fi
>> +fi
>>
>> =C2=A0if test "${enable_pedantic}" =3D "yes"; then
>> =C2=A0 =C2=A0 =C2=A0 enable_strict=3D"yes"
>> @@ -930,6 +916,10 @@ if test "${enable_strict}" =3D "yes"; then
>> =C2=A0 =C2=A0 =C2=A0 CFLAGS=3D"${CFLAGS} -Wall -Wno-unused-parameter -Wn=
o-unused-function"
>> =C2=A0fi
>>
>> +if test "${WIN32}" =3D "yes"; then
>> + =C2=A0 =C2=A0 test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is requi=
red for win32])
>> +fi
>> +
>> =C2=A0CONFIGURE_DEFINES=3D"`set | grep '^enable_.*=3D' ; set | grep '^wi=
th_.*=3D'`"
>> =C2=A0AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINE=
S}`"], [Configuration settings])
>>
>

