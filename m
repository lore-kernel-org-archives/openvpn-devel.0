MIME-Version: 1.0
In-Reply-To: <4F58A96E.1040305@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-47-git-send-email-alon.barlev@...277...>
	<4F58A96E.1040305@...515...>
Date: Thu, 8 Mar 2012 21:21:15 +0200
Message-ID: <CAOazyz3UU4XfSHSi8R78+JSuNWtEJ3-_MUTVYx2tM=OXRPSrcw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 46/52] build: move daemon() emulation
	into compat
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

daemon is gnu specific:
---
CONFORMING TO
       Not in POSIX.1-2001.  A similar function appears on the BSDs.
The daemon()  function
       first appeared in 4.4BSD.
---

Solaris, uclibc and other does not have it.

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Which platforms need daemon() emulation? Only Windows?
>
> I think it makes sense to isolate OS compatibility functions to files
> under src/compat. Better than having them in misc.c. Also, I can't see
> any obvious issues with the patch, code-vise.
>
> ACK.
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
>> =C2=A0src/compat/Makefile.am =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +-
>> =C2=A0src/compat/compat-daemon.c | =C2=A0100 +++++++++++++++++++++++++++=
+++++++++++++++++
>> =C2=A0src/compat/compat.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 ++
>> =C2=A0src/compat/compat.vcproj =C2=A0 | =C2=A0 =C2=A04 ++
>> =C2=A0src/openvpn/init.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/misc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 32 -------=
-------
>> =C2=A0src/openvpn/misc.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 --
>> =C2=A07 files changed, 111 insertions(+), 38 deletions(-)
>> =C2=A0create mode 100644 src/compat/compat-daemon.c
>>
>> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
>> index 5e9db5f..c8a92ce 100644
>> --- a/src/compat/Makefile.am
>> +++ b/src/compat/Makefile.am
>> @@ -21,4 +21,5 @@ libcompat_la_SOURCES =3D \
>> =C2=A0 =C2=A0 =C2=A0 compat.h \
>> =C2=A0 =C2=A0 =C2=A0 compat-dirname.c \
>> =C2=A0 =C2=A0 =C2=A0 compat-basename.c \
>> - =C2=A0 =C2=A0 compat-gettimeofday.c
>> + =C2=A0 =C2=A0 compat-gettimeofday.c \
>> + =C2=A0 =C2=A0 compat-daemon.c
>> diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
>> new file mode 100644
>> index 0000000..dde96a2
>> --- /dev/null
>> +++ b/src/compat/compat-daemon.c
>> @@ -0,0 +1,100 @@
>> +/*
>> + * =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single UDP port, wi=
th support for SSL/TLS-based
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and=
 key exchange,
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet =
authentication, and
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> + *
>> + * =C2=A0Copyright (C) 2011 - David Sommerseth <davids@...1347...>
>> + *
>> + * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> + * =C2=A0it under the terms of the GNU General Public License version 2
>> + * =C2=A0as published by the Free Software Foundation.
>> + *
>> + * =C2=A0This program is distributed in the hope that it will be useful,
>> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> + * =C2=A0GNU General Public License for more details.
>> + *
>> + * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> + * =C2=A0along with this program (see the file COPYING included with th=
is
>> + * =C2=A0distribution); if not, write to the Free Software Foundation, =
Inc.,
>> + * =C2=A059 Temple Place, Suite 330, Boston, MA =C2=A002111-1307 =C2=A0=
USA
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include "config.h"
>> +#elif defined(_MSC_VER)
>> +#include "config-msvc.h"
>> +#endif
>> +
>> +#ifndef HAVE_DAEMON
>> +
>> +#ifdef HAVE_UNISTD_H
>> +#include <unistd.h>
>> +#endif
>> +
>> +#ifdef HAVE_STDLIB_H
>> +#include <stdlib.h>
>> +#endif
>> +
>> +#ifdef HAVE_SYS_TYPES_H
>> +#include <sys/types.h>
>> +#endif
>> +
>> +#ifdef HAVE_SYS_STAT_H
>> +#include <sys/stat.h>
>> +#endif
>> +
>> +#ifdef HAVE_FCNTL_H
>> +#include <fcntl.h>
>> +#endif
>> +
>> +#ifdef HAVE_ERRNO_H
>> +#include <errno.h>
>> +#endif
>> +
>> +int
>> +daemon(int nochdir, int noclose)
>> +{
>> +#if defined(HAVE_FORK) && defined(HAVE_SETSID)
>> + =C2=A0 =C2=A0 switch (fork()) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case -1:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return (-1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
exit(0);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (setsid() =3D=3D -1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (-1);
>> +
>> + =C2=A0 =C2=A0 if (!nochdir)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chdir("/");
>> +
>> + =C2=A0 =C2=A0 if (!noclose) {
>> +#if defined(HAVE_DUP) && defined(HAVE_DUP2)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((fd =3D open ("/dev/null=
", O_RDWR, 0)) !=3D -1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dup2 (fd, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dup2 (fd, 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dup2 (fd, 2);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (fd > 2) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 close (fd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +#endif
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +#else
>> + =C2=A0 =C2=A0 (void)nochdir;
>> + =C2=A0 =C2=A0 (void)noclose;
>> + =C2=A0 =C2=A0 errno =3D EFAULT;
>> + =C2=A0 =C2=A0 return -1;
>> +#endif
>> +}
>> +
>> +#endif
>> +
>> diff --git a/src/compat/compat.h b/src/compat/compat.h
>> index 3f9ac31..e9d51b8 100644
>> --- a/src/compat/compat.h
>> +++ b/src/compat/compat.h
>> @@ -46,4 +46,8 @@ char * basename(char *str);
>> =C2=A0int gettimeofday (struct timeval *tv, void *tz);
>> =C2=A0#endif
>>
>> +#ifndef HAVE_DAEMON
>> +int daemon(int nochdir, int noclose);
>> +#endif
>> +
>> =C2=A0#endif /* COMPAT_H */
>> diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
>> index 235163c..efdecb4 100644
>> --- a/src/compat/compat.vcproj
>> +++ b/src/compat/compat.vcproj
>> @@ -162,6 +162,10 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\compat-gettimeofday.c"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </File>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
<File
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\compat-daemon.c"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
</File>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </Filter>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <Filter
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Name=3D"Header Files"
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index e7edb05..bba3cf8 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -993,7 +993,7 @@ possibly_become_daemon (const struct options *option=
s, const bool first_time)
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT (!options->inetd);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (daemon (options->cd_dir !=3D NULL, option=
s->log) < 0)
>> - =C2=A0 =C2=A0 msg (M_ERR, "daemon() failed");
>> + =C2=A0 =C2=A0 msg (M_ERR, "daemon() failed or unsupported");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0restore_signal_state ();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options->log)
>> =C2=A0 =C2=A0 =C2=A0 set_std_files_to_null (true);
>> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
>> index 898a183..07beaf0 100644
>> --- a/src/openvpn/misc.c
>> +++ b/src/openvpn/misc.c
>> @@ -301,38 +301,6 @@ do_mlockall(bool print_msg)
>> =C2=A0#endif
>> =C2=A0}
>>
>> -#ifndef HAVE_DAEMON
>> -
>> -int
>> -daemon(int nochdir, int noclose)
>> -{
>> -#if defined(HAVE_FORK) && defined(HAVE_SETSID)
>> - =C2=A0switch (fork())
>> - =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0case -1:
>> - =C2=A0 =C2=A0 =C2=A0return (-1);
>> - =C2=A0 =C2=A0case 0:
>> - =C2=A0 =C2=A0 =C2=A0break;
>> - =C2=A0 =C2=A0default:
>> - =C2=A0 =C2=A0 =C2=A0openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit p=
oint */
>> - =C2=A0 =C2=A0}
>> -
>> - =C2=A0if (setsid() =3D=3D -1)
>> - =C2=A0 =C2=A0return (-1);
>> -
>> - =C2=A0if (!nochdir)
>> - =C2=A0 =C2=A0openvpn_chdir ("/");
>> -
>> - =C2=A0if (!noclose)
>> - =C2=A0 =C2=A0set_std_files_to_null (false);
>> -#else
>> - =C2=A0msg (M_FATAL, "Sorry but I can't become a daemon because this op=
erating system doesn't appear to support either the daemon() or fork() syst=
em calls");
>> -#endif
>> - =C2=A0return (0);
>> -}
>> -
>> -#endif
>> -
>> =C2=A0/*
>> =C2=A0 * Set standard file descriptors to /dev/null
>> =C2=A0 */
>> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
>> index 9fa8106..9bb2fa2 100644
>> --- a/src/openvpn/misc.h
>> +++ b/src/openvpn/misc.h
>> @@ -115,10 +115,6 @@ unsigned int openvpn_getpid (void);
>>
>> =C2=A0void do_mlockall (bool print_msg); /* Disable paging */
>>
>> -#ifndef HAVE_DAEMON
>> -int daemon (int nochdir, int noclose);
>> -#endif
>> -
>> =C2=A0/* check file protections */
>> =C2=A0void warn_if_group_others_accessible(const char* filename);
>>
>
>

