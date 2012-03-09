Message-ID: <4F59BF4C.9020800@...515...>
Date: Fri, 09 Mar 2012 10:29:00 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-36-git-send-email-alon.barlev@...277...>
	<4F588784.300@...515...>
	<CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>
In-Reply-To: <CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Thanks for the clarification. ACK then.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> I wrote this in the introduction of the patch set.
>
> There are two approaches to detecting dependencies:
>
> 1. Detect all compile time dependences- you detect headers and
> libraries, this is probably the safest way to go, but makes the code
> very complex.
>
> 2. Detect library only - you assume that if library is present, the
> functionality exists, this is what important... no need to check for
> header, most probably this exists as well. This makes the code
> simpler, in the risk of compile failure if header is missing.
>
> In all project I wrote build for (opensc, uswsusp, ntfs3g, ecryptfs)
> we took the 2nd approach, and it is fine.
>
> Alon.
>
> 2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> Looks like a cleaner implementation than the earlier one. I take it AC_C=
HECK_HEADER is not anymore needed to detect selinux.h, but why exactly?
>>
>> Besides that I give this one an ACK.
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>>> ---
>>>  configure.ac            |   35 +++++++++++++++--------------------
>>>  src/openvpn/Makefile.am |    1 +
>>>  src/openvpn/init.c      |    4 ++--
>>>  src/openvpn/options.c   |    6 +++---
>>>  src/openvpn/options.h   |    2 +-
>>>  src/openvpn/syshead.h   |    2 +-
>>>  6 files changed, 23 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 98615c6..2388f17 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -215,7 +215,7 @@ AC_ARG_ENABLE(
>>>
>>>  AC_ARG_ENABLE(
>>>       [selinux],
>>> -     [AS_HELP_STRING([--disable-selinux], [disable SELinux support])],
>>> +     [AS_HELP_STRING([--enable-selinux], [enable SELinux support])],
>>>       ,
>>>       [enable_selinux=3D"no"]
>>>  )
>>> @@ -619,6 +619,13 @@ AC_CHECK_LIB(
>>>  )
>>>  AC_SUBST([SOCKETS_LIBS])
>>>
>>> +AC_CHECK_LIB(
>>> +     [selinux],
>>> +     [setcon],
>>> +     [SELINUX_LIBS=3D"-lselinux"]
>>> +)
>>> +AC_SUBST([SELINUX_LIBS])
>>> +
>>>  case "${with_mem_check}" in
>>>       valgrind)
>>>               AC_CHECK_HEADER(
>>> @@ -826,25 +833,6 @@ if test "${enable_crypto}" =3D "yes"; then
>>>     fi
>>>  fi
>>>
>>> -dnl
>>> -dnl check for SELinux library and headers
>>> -dnl
>>> -if test "${enable_selinux}" =3D "yes"; then
>>> -     AC_CHECK_HEADER(
>>> -             [selinux/selinux.h],
>>> -             [AC_CHECK_LIB(
>>> -                     [selinux],
>>> -                     [setcon],
>>> -                     [
>>> -                             LIBS=3D"${LIBS} -lselinux"
>>> -                             AC_DEFINE(HAVE_SETCON, 1, [SELinux suppor=
t])
>>> -                     ],
>>> -                     [AC_MSG_RESULT([SELinux library not found.])]
>>> -             )],
>>> -             [AC_MSG_ERROR([SELinux headers not found.])]
>>> -     )
>>> -fi
>>> -
>>>  if test -n "${SP_PLATFORM_WINDOWS}"; then
>>>       AC_DEFINE_UNQUOTED([PATH_SEPARATOR], ['\\\\'], [Path separator]) =
#"
>>>       AC_DEFINE_UNQUOTED([PATH_SEPARATOR_STR], ["\\\\"], [Path separato=
r]) #"
>>> @@ -896,6 +884,12 @@ else
>>>       fi
>>>  fi
>>>
>>> +if test "${enable_selinux}" =3D "yes"; then
>>> +     test -z "${SELINUX_LIBS}" && AC_MSG_ERROR([libselinux required bu=
t missing])
>>> +     OPTIONAL_SELINUX_LIBS=3D"${SELINUX_LIBS}"
>>> +     AC_DEFINE([ENABLE_SELINUX], [1], [SELinux support])
>>> +fi
>>> +
>>>  if test "${enable_pedantic}" =3D "yes"; then
>>>       enable_strict=3D"yes"
>>>       CFLAGS=3D"${CFLAGS} -ansi -pedantic"
>>> @@ -922,6 +916,7 @@ AC_SUBST([TAP_WIN_MIN_MAJOR])
>>>  AC_SUBST([TAP_WIN_MIN_MINOR])
>>>
>>>  AC_SUBST([OPTIONAL_DL_LIBS])
>>> +AC_SUBST([OPTIONAL_SELINUX_LIBS])
>>>
>>>  AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>>>
>>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>>> index 86abd09..a3f8b3a 100644
>>> --- a/src/openvpn/Makefile.am
>>> +++ b/src/openvpn/Makefile.am
>>> @@ -97,6 +97,7 @@ openvpn_SOURCES =3D \
>>>       cryptoapi.h cryptoapi.c
>>>  openvpn_LDADD =3D \
>>>       $(SOCKETS_LIBS) \
>>> +     $(OPTIONAL_SELINUX_LIBS) \
>>>       $(OPTIONAL_DL_LIBS)
>>>  if WIN32
>>>  openvpn_SOURCES +=3D openvpn_win32_resources.rc
>>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>>> index b8f57b2..0c995ff 100644
>>> --- a/src/openvpn/init.c
>>> +++ b/src/openvpn/init.c
>>> @@ -1038,7 +1038,7 @@ do_uid_gid_chroot (struct context *c, bool no_del=
ay)
>>>       mstats_open(c->options.memstats_fn);
>>>  #endif
>>>
>>> -#ifdef HAVE_SETCON
>>> +#ifdef ENABLE_SELINUX
>>>        /* Apply a SELinux context in order to restrict what OpenVPN can=
 do
>>>         * to _only_ what it is supposed to do after initialization is c=
omplete
>>>         * (basically just network I/O operations). Doing it after chroot
>>> @@ -2465,7 +2465,7 @@ do_option_warnings (struct context *c)
>>>      msg (M_WARN, "WARNING: --ping should normally be used with --ping-=
restart or --ping-exit");
>>>
>>>    if (o->username || o->groupname || o->chroot_dir
>>> -#ifdef HAVE_SETCON
>>> +#ifdef ENABLE_SELINUX
>>>        || o->selinux_context
>>>  #endif
>>>        )
>>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>>> index d7f848e..4e95b83 100644
>>> --- a/src/openvpn/options.c
>>> +++ b/src/openvpn/options.c
>>> @@ -316,7 +316,7 @@ static const char usage_message[] =3D
>>>    "--user user     : Set UID to user after initialization.\n"
>>>    "--group group   : Set GID to group after initialization.\n"
>>>    "--chroot dir    : Chroot to this directory after initialization.\n"
>>> -#ifdef HAVE_SETCON
>>> +#ifdef ENABLE_SELINUX
>>>    "--setcon context: Apply this SELinux context after initialization.\=
n"
>>>  #endif
>>>    "--cd dir        : Change to this directory before initialization.\n"
>>> @@ -1477,7 +1477,7 @@ show_settings (const struct options *o)
>>>    SHOW_STR (groupname);
>>>    SHOW_STR (chroot_dir);
>>>    SHOW_STR (cd_dir);
>>> -#ifdef HAVE_SETCON
>>> +#ifdef ENABLE_SELINUX
>>>    SHOW_STR (selinux_context);
>>>  #endif
>>>    SHOW_STR (writepid);
>>> @@ -4525,7 +4525,7 @@ add_option (struct options *options,
>>>       }
>>>        options->cd_dir =3D p[1];
>>>      }
>>> -#ifdef HAVE_SETCON
>>> +#ifdef ENABLE_SELINUX
>>>    else if (streq (p[0], "setcon") && p[1])
>>>      {
>>>        VERIFY_PERMISSION (OPT_P_GENERAL);
>>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>>> index 6af4b3a..57b88b7 100644
>>> --- a/src/openvpn/options.h
>>> +++ b/src/openvpn/options.h
>>> @@ -310,7 +310,7 @@ struct options
>>>    const char *groupname;
>>>    const char *chroot_dir;
>>>    const char *cd_dir;
>>> -#ifdef HAVE_SETCON
>>> +#ifdef ENABLE_SELINUX
>>>    char *selinux_context;
>>>  #endif
>>>    const char *writepid;
>>> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
>>> index 1ad81d8..cac4757 100644
>>> --- a/src/openvpn/syshead.h
>>> +++ b/src/openvpn/syshead.h
>>> @@ -176,7 +176,7 @@
>>>  #include <sys/epoll.h>
>>>  #endif
>>>
>>> -#ifdef HAVE_SETCON
>>> +#ifdef ENABLE_SELINUX
>>>  #include <selinux/selinux.h>
>>>  #endif
>>>


