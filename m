MIME-Version: 1.0
References: <20210307161547.25130-1-gert@...1296...>
 <20210308071023.18269-1-gert@...1296...>
In-Reply-To: <20210308071023.18269-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 Mar 2021 16:54:53 -0500
Message-ID: <CAKuzo_j2LKw1S9qToV+0-hVqZL_Ze1kj0ms3RUU2Jy998kRWLw@...278...>
Content-Type: multipart/alternative; boundary="000000000000baf60905bd219a64"
Subject: Re: [Openvpn-devel] [PATCH v2] Require at least 100MB of
 mlock()-able memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000baf60905bd219a64
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Mar 8, 2021 at 2:11 AM Gert Doering <gert@...1296...> wrote:

> If --mlock is used, the amount of memory OpenVPN can use is guarded
> by the RLIMIT_MEMLOCK value (see mlockall(2)).  The OS default for this
> is usually 64 Kbyte, which is enough for OpenVPN to initialize, but
> as soon as the first TLS handshake comes it, OpenVPN will crash due
> to "ouf of memory", and might even end up in a crash loop.
>
> Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers with
> many concurrent clients) of memory.  TLS renegotiation with EC keys
> requires up to 90 MB of transient memory.
>
> So: with this patch, we check if getrlimit() is available, and if yes,
> log the amount of mlock'able memory.  If the amount is below 100 MB,
> which is an arbitrary value "large enough for most smaller deployments",
> we try to increase the limits to 100 MB, and abort if this fails.
>
> v2:
>   change arbitrary number to 100 MB, introduce #define for it
>   not only check but also increase with setrlimit()
>   uncrustify fixes
>
> Trac: #1390
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  configure.ac                         |  2 +-
>  doc/man-sections/generic-options.rst |  7 +++++++
>  src/openvpn/platform.c               | 29 ++++++++++++++++++++++++++++
>  src/openvpn/platform.h               |  4 ++++
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 1ab8fe59..c65df3e2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -645,7 +645,7 @@ AC_FUNC_FORK
>
>  AC_CHECK_FUNCS([ \
>         daemon chroot getpwnam setuid nice system getpid dup dup2 \
> -       getpass syslog openlog mlockall getgrnam setgid \
> +       getpass syslog openlog mlockall getrlimit getgrnam setgid \
>         setgroups stat flock readv writev time gettimeofday \
>         ctime memset vsnprintf strdup \
>         setsid chdir putenv getpeername unlink \
> diff --git a/doc/man-sections/generic-options.rst
> b/doc/man-sections/generic-options.rst
> index d5f08839..c026529e 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -237,6 +237,13 @@ which mode OpenVPN is configured as.
>    likely fail. The limit can be increased using ulimit or systemd
>    directives depending on how OpenVPN is started.
>
> +  If the platform has the getrlimit(2) system call, OpenVPN will check
> +  for the amount of mlock-able memory before calling mlockall(2), and
> +  tries to increase the limit to 100 MB if less than this is configured.
> +  100 Mb is somewhat arbitrary - it is enough for a moderately-sized
> +  OpenVPN deployment, but the memory usage might go beyond that if the
> +  number of concurrent clients is high.
> +
>  --nice n
>    Change process priority after initialization (``n`` greater than 0 is
>    lower priority, ``n`` less than zero is higher priority).
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index ef688c23..dfbf50c0 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -193,6 +193,35 @@ void
>  platform_mlockall(bool print_msg)
>  {
>  #ifdef HAVE_MLOCKALL
> +
> +#ifdef HAVE_GETRLIMIT
> +#define MIN_LOCKED_MEM_MB 100
> +    struct rlimit rl;
> +    if (getrlimit(RLIMIT_MEMLOCK, &rl) < 0)
> +    {
> +        msg(M_WARN | M_ERRNO, "WARNING: getrlimit(RLIMIT_MEMLOCK)
> failed");
> +    }
> +    else
> +    {
> +        msg(M_INFO, "mlock: MEMLOCK limit: soft=%ld KB, hard=%ld KB",
> +            ((long int) rl.rlim_cur) / 1024, ((long int) rl.rlim_max) /
> 1024);
> +        if (rl.rlim_cur < MIN_LOCKED_MEM_MB*1024*1024)
> +        {
> +            msg(M_INFO, "mlock: RLIMIT_MEMLOCK < %d MB, increase limit",
> +                MIN_LOCKED_MEM_MB);
> +            rl.rlim_cur = MIN_LOCKED_MEM_MB*1024*1024;
> +            if (rl.rlim_max < rl.rlim_cur)
> +            {
> +                rl.rlim_max = rl.rlim_cur;
> +            }
> +            if (setrlimit(RLIMIT_MEMLOCK, &rl) < 0)
> +            {
> +                msg(M_FATAL | M_ERRNO, "ERROR: setrlimit() failed");
> +            }
> +        }
> +    }
> +#endif
> +
>      if (mlockall(MCL_CURRENT | MCL_FUTURE))
>      {
>          msg(M_WARN | M_ERRNO, "WARNING: mlockall call failed");
> diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
> index 01f3200c..02c23e38 100644
> --- a/src/openvpn/platform.h
> +++ b/src/openvpn/platform.h
> @@ -48,6 +48,10 @@
>  #include <stdio.h>
>  #endif
>
> +#ifdef HAVE_GETRLIMIT
> +#include <sys/resource.h>
> +#endif
> +
>  #include "basic.h"
>  #include "buffer.h"
>
> --
> 2.26.2
>

Looks good to me. We call mlockall (and now setrlimit) early before
dropping privileges, so this should take care of at least the naive user
error of running with "--mlock --user foo" and the default low memlock
limit.

Acked-by: selva.nair@...277...

Selva

--000000000000baf60905bd219a64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 8, 2021 at 2:11 AM Gert Do=
ering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">If --mlock is u=
sed, the amount of memory OpenVPN can use is guarded<br>
by the RLIMIT_MEMLOCK value (see mlockall(2)).=C2=A0 The OS default for thi=
s<br>
is usually 64 Kbyte, which is enough for OpenVPN to initialize, but<br>
as soon as the first TLS handshake comes it, OpenVPN will crash due<br>
to &quot;ouf of memory&quot;, and might even end up in a crash loop.<br>
<br>
Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers with<br>
many concurrent clients) of memory.=C2=A0 TLS renegotiation with EC keys<br>
requires up to 90 MB of transient memory.<br>
<br>
So: with this patch, we check if getrlimit() is available, and if yes,<br>
log the amount of mlock&#39;able memory.=C2=A0 If the amount is below 100 M=
B,<br>
which is an arbitrary value &quot;large enough for most smaller deployments=
&quot;,<br>
we try to increase the limits to 100 MB, and abort if this fails.<br>
<br>
v2:<br>
=C2=A0 change arbitrary number to 100 MB, introduce #define for it<br>
=C2=A0 not only check but also increase with setrlimit()<br>
=C2=A0 uncrustify fixes<br>
<br>
Trac: #1390<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0doc/man-sections/generic-options.rst |=C2=A0 7 +++++++<br>
=C2=A0src/openvpn/platform.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 29 ++++++++++++++++++++++++++++<br>
=C2=A0src/openvpn/platform.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 4 ++++<br>
=C2=A04 files changed, 41 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 1ab8fe59..c65df3e2 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -645,7 +645,7 @@ AC_FUNC_FORK<br>
<br>
=C2=A0AC_CHECK_FUNCS([ \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 daemon chroot getpwnam setuid nice system getpi=
d dup dup2 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0getpass syslog openlog mlockall getgrnam setgid=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0getpass syslog openlog mlockall getrlimit getgr=
nam setgid \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 setgroups stat flock readv writev time gettimeo=
fday \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime memset vsnprintf strdup \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 setsid chdir putenv getpeername unlink \<br>
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst<br>
index d5f08839..c026529e 100644<br>
--- a/doc/man-sections/generic-options.rst<br>
+++ b/doc/man-sections/generic-options.rst<br>
@@ -237,6 +237,13 @@ which mode OpenVPN is configured as.<br>
=C2=A0 =C2=A0likely fail. The limit can be increased using ulimit or system=
d<br>
=C2=A0 =C2=A0directives depending on how OpenVPN is started.<br>
<br>
+=C2=A0 If the platform has the getrlimit(2) system call, OpenVPN will chec=
k<br>
+=C2=A0 for the amount of mlock-able memory before calling mlockall(2), and=
<br>
+=C2=A0 tries to increase the limit to 100 MB if less than this is configur=
ed.<br>
+=C2=A0 100 Mb is somewhat arbitrary - it is enough for a moderately-sized<=
br>
+=C2=A0 OpenVPN deployment, but the memory usage might go beyond that if th=
e<br>
+=C2=A0 number of concurrent clients is high.<br>
+<br>
=C2=A0--nice n<br>
=C2=A0 =C2=A0Change process priority after initialization (``n`` greater th=
an 0 is<br>
=C2=A0 =C2=A0lower priority, ``n`` less than zero is higher priority).<br>
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c<br>
index ef688c23..dfbf50c0 100644<br>
--- a/src/openvpn/platform.c<br>
+++ b/src/openvpn/platform.c<br>
@@ -193,6 +193,35 @@ void<br>
=C2=A0platform_mlockall(bool print_msg)<br>
=C2=A0{<br>
=C2=A0#ifdef HAVE_MLOCKALL<br>
+<br>
+#ifdef HAVE_GETRLIMIT<br>
+#define MIN_LOCKED_MEM_MB 100<br>
+=C2=A0 =C2=A0 struct rlimit rl;<br>
+=C2=A0 =C2=A0 if (getrlimit(RLIMIT_MEMLOCK, &amp;rl) &lt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_ERRNO, &quot;WARNING: getrlimit=
(RLIMIT_MEMLOCK) failed&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;mlock: MEMLOCK limit: soft=
=3D%ld KB, hard=3D%ld KB&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((long int) rl.rlim_cur) / 1024,=
 ((long int) rl.rlim_max) / 1024);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rl.rlim_cur &lt; MIN_LOCKED_MEM_MB*1024*10=
24)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;mlock: RLIMIT_=
MEMLOCK &lt; %d MB, increase limit&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIN_LOCKED_MEM_MB)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rl.rlim_cur =3D MIN_LOCKED_MEM_M=
B*1024*1024;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rl.rlim_max &lt; rl.rlim_cur=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rl.rlim_max =3D rl=
.rlim_cur;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (setrlimit(RLIMIT_MEMLOCK, &a=
mp;rl) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL | M_ER=
RNO, &quot;ERROR: setrlimit() failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (mlockall(MCL_CURRENT | MCL_FUTURE))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN | M_ERRNO, &quot;WARNING: mloc=
kall call failed&quot;);<br>
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h<br>
index 01f3200c..02c23e38 100644<br>
--- a/src/openvpn/platform.h<br>
+++ b/src/openvpn/platform.h<br>
@@ -48,6 +48,10 @@<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#endif<br>
<br>
+#ifdef HAVE_GETRLIMIT<br>
+#include &lt;sys/resource.h&gt;<br>
+#endif<br>
+<br>
=C2=A0#include &quot;basic.h&quot;<br>
=C2=A0#include &quot;buffer.h&quot;<br>
<br>
-- <br>
2.26.2<br></blockquote><div><br></div><div>Looks good to me. We call mlocka=
ll (and now setrlimit) early before dropping privileges, so this should tak=
e care of at least the naive user error of running with &quot;--mlock --use=
r foo&quot; and the default low memlock limit.</div><div><br></div><div>Ack=
ed-by: <a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a></di=
v><div><br></div><div>Selva</div></div></div>

--000000000000baf60905bd219a64--

