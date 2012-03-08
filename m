MIME-Version: 1.0
In-Reply-To: <4F588784.300@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-36-git-send-email-alon.barlev@...277...>
	<4F588784.300@...515...>
Date: Thu, 8 Mar 2012 21:36:53 +0200
Message-ID: <CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 35/52] build: proper selinux detection
	and usage
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

I wrote this in the introduction of the patch set.

There are two approaches to detecting dependencies:

1. Detect all compile time dependences- you detect headers and
libraries, this is probably the safest way to go, but makes the code
very complex.

2. Detect library only - you assume that if library is present, the
functionality exists, this is what important... no need to check for
header, most probably this exists as well. This makes the code
simpler, in the risk of compile failure if header is missing.

In all project I wrote build for (opensc, uswsusp, ntfs3g, ecryptfs)
we took the 2nd approach, and it is fine.

Alon.

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Looks like a cleaner implementation than the earlier one. I take it AC_CH=
ECK_HEADER is not anymore needed to detect selinux.h, but why exactly?
>
> Besides that I give this one an ACK.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 35 =
+++++++++++++++--------------------
>> =C2=A0src/openvpn/Makefile.am | =C2=A0 =C2=A01 +
>> =C2=A0src/openvpn/init.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 ++--
>> =C2=A0src/openvpn/options.c =C2=A0 | =C2=A0 =C2=A06 +++---
>> =C2=A0src/openvpn/options.h =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/syshead.h =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A06 files changed, 23 insertions(+), 27 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 98615c6..2388f17 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -215,7 +215,7 @@ AC_ARG_ENABLE(
>>
>> =C2=A0AC_ARG_ENABLE(
>> =C2=A0 =C2=A0 =C2=A0 [selinux],
>> - =C2=A0 =C2=A0 [AS_HELP_STRING([--disable-selinux], [disable SELinux su=
pport])],
>> + =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-selinux], [enable SELinux supp=
ort])],
>> =C2=A0 =C2=A0 =C2=A0 ,
>> =C2=A0 =C2=A0 =C2=A0 [enable_selinux=3D"no"]
>> =C2=A0)
>> @@ -619,6 +619,13 @@ AC_CHECK_LIB(
>> =C2=A0)
>> =C2=A0AC_SUBST([SOCKETS_LIBS])
>>
>> +AC_CHECK_LIB(
>> + =C2=A0 =C2=A0 [selinux],
>> + =C2=A0 =C2=A0 [setcon],
>> + =C2=A0 =C2=A0 [SELINUX_LIBS=3D"-lselinux"]
>> +)
>> +AC_SUBST([SELINUX_LIBS])
>> +
>> =C2=A0case "${with_mem_check}" in
>> =C2=A0 =C2=A0 =C2=A0 valgrind)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_CHECK_HEADER(
>> @@ -826,25 +833,6 @@ if test "${enable_crypto}" =3D "yes"; then
>> =C2=A0 =C2=A0 fi
>> =C2=A0fi
>>
>> -dnl
>> -dnl check for SELinux library and headers
>> -dnl
>> -if test "${enable_selinux}" =3D "yes"; then
>> - =C2=A0 =C2=A0 AC_CHECK_HEADER(
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [selinux/selinux.h],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [AC_CHECK_LIB(
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
[selinux],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
[setcon],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBS=3D"${LIBS} -lselinux"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE(HAVE_SETCON, 1, [SELinux support])
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
[AC_MSG_RESULT([SELinux library not found.])]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [AC_MSG_ERROR([SELinux heade=
rs not found.])]
>> - =C2=A0 =C2=A0 )
>> -fi
>> -
>> =C2=A0if test -n "${SP_PLATFORM_WINDOWS}"; then
>> =C2=A0 =C2=A0 =C2=A0 AC_DEFINE_UNQUOTED([PATH_SEPARATOR], ['\\\\'], [Pat=
h separator]) #"
>> =C2=A0 =C2=A0 =C2=A0 AC_DEFINE_UNQUOTED([PATH_SEPARATOR_STR], ["\\\\"], =
[Path separator]) #"
>> @@ -896,6 +884,12 @@ else
>> =C2=A0 =C2=A0 =C2=A0 fi
>> =C2=A0fi
>>
>> +if test "${enable_selinux}" =3D "yes"; then
>> + =C2=A0 =C2=A0 test -z "${SELINUX_LIBS}" && AC_MSG_ERROR([libselinux re=
quired but missing])
>> + =C2=A0 =C2=A0 OPTIONAL_SELINUX_LIBS=3D"${SELINUX_LIBS}"
>> + =C2=A0 =C2=A0 AC_DEFINE([ENABLE_SELINUX], [1], [SELinux support])
>> +fi
>> +
>> =C2=A0if test "${enable_pedantic}" =3D "yes"; then
>> =C2=A0 =C2=A0 =C2=A0 enable_strict=3D"yes"
>> =C2=A0 =C2=A0 =C2=A0 CFLAGS=3D"${CFLAGS} -ansi -pedantic"
>> @@ -922,6 +916,7 @@ AC_SUBST([TAP_WIN_MIN_MAJOR])
>> =C2=A0AC_SUBST([TAP_WIN_MIN_MINOR])
>>
>> =C2=A0AC_SUBST([OPTIONAL_DL_LIBS])
>> +AC_SUBST([OPTIONAL_SELINUX_LIBS])
>>
>> =C2=A0AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>>
>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>> index 86abd09..a3f8b3a 100644
>> --- a/src/openvpn/Makefile.am
>> +++ b/src/openvpn/Makefile.am
>> @@ -97,6 +97,7 @@ openvpn_SOURCES =3D \
>> =C2=A0 =C2=A0 =C2=A0 cryptoapi.h cryptoapi.c
>> =C2=A0openvpn_LDADD =3D \
>> =C2=A0 =C2=A0 =C2=A0 $(SOCKETS_LIBS) \
>> + =C2=A0 =C2=A0 $(OPTIONAL_SELINUX_LIBS) \
>> =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_DL_LIBS)
>> =C2=A0if WIN32
>> =C2=A0openvpn_SOURCES +=3D openvpn_win32_resources.rc
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index b8f57b2..0c995ff 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -1038,7 +1038,7 @@ do_uid_gid_chroot (struct context *c, bool no_dela=
y)
>> =C2=A0 =C2=A0 =C2=A0 mstats_open(c->options.memstats_fn);
>> =C2=A0#endif
>>
>> -#ifdef HAVE_SETCON
>> +#ifdef ENABLE_SELINUX
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Apply a SELinux context in order to restri=
ct what OpenVPN can do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to _only_ what it is supposed to do after =
initialization is complete
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (basically just network I/O operations). D=
oing it after chroot
>> @@ -2465,7 +2465,7 @@ do_option_warnings (struct context *c)
>> =C2=A0 =C2=A0 =C2=A0msg (M_WARN, "WARNING: --ping should normally be use=
d with --ping-restart or --ping-exit");
>>
>> =C2=A0 =C2=A0if (o->username || o->groupname || o->chroot_dir
>> -#ifdef HAVE_SETCON
>> +#ifdef ENABLE_SELINUX
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0|| o->selinux_context
>> =C2=A0#endif
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index d7f848e..4e95b83 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -316,7 +316,7 @@ static const char usage_message[] =3D
>> =C2=A0 =C2=A0"--user user =C2=A0 =C2=A0 : Set UID to user after initiali=
zation.\n"
>> =C2=A0 =C2=A0"--group group =C2=A0 : Set GID to group after initializati=
on.\n"
>> =C2=A0 =C2=A0"--chroot dir =C2=A0 =C2=A0: Chroot to this directory after=
 initialization.\n"
>> -#ifdef HAVE_SETCON
>> +#ifdef ENABLE_SELINUX
>> =C2=A0 =C2=A0"--setcon context: Apply this SELinux context after initial=
ization.\n"
>> =C2=A0#endif
>> =C2=A0 =C2=A0"--cd dir =C2=A0 =C2=A0 =C2=A0 =C2=A0: Change to this direc=
tory before initialization.\n"
>> @@ -1477,7 +1477,7 @@ show_settings (const struct options *o)
>> =C2=A0 =C2=A0SHOW_STR (groupname);
>> =C2=A0 =C2=A0SHOW_STR (chroot_dir);
>> =C2=A0 =C2=A0SHOW_STR (cd_dir);
>> -#ifdef HAVE_SETCON
>> +#ifdef ENABLE_SELINUX
>> =C2=A0 =C2=A0SHOW_STR (selinux_context);
>> =C2=A0#endif
>> =C2=A0 =C2=A0SHOW_STR (writepid);
>> @@ -4525,7 +4525,7 @@ add_option (struct options *options,
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0options->cd_dir =3D p[1];
>> =C2=A0 =C2=A0 =C2=A0}
>> -#ifdef HAVE_SETCON
>> +#ifdef ENABLE_SELINUX
>> =C2=A0 =C2=A0else if (streq (p[0], "setcon") && p[1])
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_GENERAL);
>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>> index 6af4b3a..57b88b7 100644
>> --- a/src/openvpn/options.h
>> +++ b/src/openvpn/options.h
>> @@ -310,7 +310,7 @@ struct options
>> =C2=A0 =C2=A0const char *groupname;
>> =C2=A0 =C2=A0const char *chroot_dir;
>> =C2=A0 =C2=A0const char *cd_dir;
>> -#ifdef HAVE_SETCON
>> +#ifdef ENABLE_SELINUX
>> =C2=A0 =C2=A0char *selinux_context;
>> =C2=A0#endif
>> =C2=A0 =C2=A0const char *writepid;
>> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
>> index 1ad81d8..cac4757 100644
>> --- a/src/openvpn/syshead.h
>> +++ b/src/openvpn/syshead.h
>> @@ -176,7 +176,7 @@
>> =C2=A0#include <sys/epoll.h>
>> =C2=A0#endif
>>
>> -#ifdef HAVE_SETCON
>> +#ifdef ENABLE_SELINUX
>> =C2=A0#include <selinux/selinux.h>
>> =C2=A0#endif
>>
>

