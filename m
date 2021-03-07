MIME-Version: 1.0
References: <20210307161547.25130-1-gert@...1296...>
In-Reply-To: <20210307161547.25130-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 7 Mar 2021 12:22:32 -0500
Message-ID: <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000f4a36a05bcf590b2"
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
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

--000000000000f4a36a05bcf590b2
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Mar 7, 2021 at 11:31 AM Gert Doering <gert@...1296...> wrote:

> If --mlock is used, the amount of memory OpenVPN can use is guarded
> by the RLIMIT_MEMLOCK value (see mlockall(2)).  The OS default for this
> is usually 64 Kbyte, which is enough for OpenVPN to initialize, but
> as soon as the first TLS handshake comes it, OpenVPN will crash due
> to "ouf of memory", and might even end up in a crash loop.
>
> Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers with
> many concurrent clients) of memory.
>
> So: with this patch, we check if getrlimit() is available, and if yes,
> log the amount of mlock'able memory.  If the amount is below 20 MB,
> which is an arbitrary value "large enough for most smaller deployments",
> we abort.
>

This is required only if privileges are dropped, isn't it? Could be made
conditional
on o->username is set.


> Trac: #1390
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  configure.ac                         |  2 +-
>  doc/man-sections/generic-options.rst |  6 ++++++
>  src/openvpn/platform.c               | 18 ++++++++++++++++++
>  src/openvpn/platform.h               |  4 ++++
>  4 files changed, 29 insertions(+), 1 deletion(-)
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
> index d5f08839..0a7d3caf 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -237,6 +237,12 @@ which mode OpenVPN is configured as.
>    likely fail. The limit can be increased using ulimit or systemd
>    directives depending on how OpenVPN is started.
>
> +  If the platform has the getrlimit(2) system call, OpenVPN will check
> +  for the amount of mlock-able memory before calling mlockall(2), and


white space at end of line


>
> +  abort if less than 20 Mb are available.  20 Mb is somewhat arbitrary -
>

Mb -> MB


> +  it is enough for a moderately-sized OpenVPN deployment, but the memory
> +  usage will go beyond that if the number of concurrent clients is high.
> +
>  --nice n
>    Change process priority after initialization (``n`` greater than 0 is
>    lower priority, ``n`` less than zero is higher priority).
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index ef688c23..67a69748 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -193,6 +193,24 @@ void
>  platform_mlockall(bool print_msg)
>  {
>  #ifdef HAVE_MLOCKALL
> +
> +#ifdef HAVE_GETRLIMIT
> +    struct rlimit rl;
> +    if (getrlimit(RLIMIT_MEMLOCK,&rl)<0)
>

spaces after "," and around "<"  :)


> +    {
> +        msg(M_WARN | M_ERRNO, "WARNING: getrlimit(RLIMIT_MEMLOCK)
> failed");
> +    }
> +    else
> +    {
> +       msg(M_INFO, "mlock: MEMLOCK limit: soft=%ldkb, hard=%dkb",
>

%dkb --> %ldkb


> +           ((long int) rl.rlim_cur)/1024, ((long int) rl.rlim_max)/1024);
>

Some may argue that our style is to put space around "/"


> +       if (rl.rlim_cur < 20*1024*1024)
> +       {
> +           msg(M_FATAL, "mlock: RLIMIT_MEMLOCK < 20 MByte, increase
> limit");
>

Mbyte -> MB or megabytes


> +       }
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

 Selva

--000000000000f4a36a05bcf590b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi,<div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 7, 2021 at 11:31 =
AM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">ge=
rt@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">If --mlock is used, the amount of memory OpenVPN can use is gu=
arded<br>
by the RLIMIT_MEMLOCK value (see mlockall(2)).=C2=A0 The OS default for thi=
s<br>
is usually 64 Kbyte, which is enough for OpenVPN to initialize, but<br>
as soon as the first TLS handshake comes it, OpenVPN will crash due<br>
to &quot;ouf of memory&quot;, and might even end up in a crash loop.<br>
<br>
Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers with<br>
many concurrent clients) of memory.<br>
<br>
So: with this patch, we check if getrlimit() is available, and if yes,<br>
log the amount of mlock&#39;able memory.=C2=A0 If the amount is below 20 MB=
,<br>
which is an arbitrary value &quot;large enough for most smaller deployments=
&quot;,<br>
we abort.<br></blockquote><div><br></div><div>This is required only if=C2=
=A0privileges are dropped, isn&#39;t it? Could be made conditional=C2=A0</d=
iv><div>on o-&gt;username is set.</div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Trac: #1390<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0doc/man-sections/generic-options.rst |=C2=A0 6 ++++++<br>
=C2=A0src/openvpn/platform.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 18 ++++++++++++++++++<br>
=C2=A0src/openvpn/platform.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 4 ++++<br>
=C2=A04 files changed, 29 insertions(+), 1 deletion(-)<br>
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
index d5f08839..0a7d3caf 100644<br>
--- a/doc/man-sections/generic-options.rst<br>
+++ b/doc/man-sections/generic-options.rst<br>
@@ -237,6 +237,12 @@ which mode OpenVPN is configured as.<br>
=C2=A0 =C2=A0likely fail. The limit can be increased using ulimit or system=
d<br>
=C2=A0 =C2=A0directives depending on how OpenVPN is started.<br>
<br>
+=C2=A0 If the platform has the getrlimit(2) system call, OpenVPN will chec=
k<br>
+=C2=A0 for the amount of mlock-able memory before calling mlockall(2), and=
</blockquote><div><br></div><div>white space at end of line</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"> <br>
+=C2=A0 abort if less than 20 Mb are available.=C2=A0 20 Mb is somewhat arb=
itrary -<br></blockquote><div><br></div><div>Mb -&gt; MB=C2=A0</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 it is=
 enough for a moderately-sized OpenVPN deployment, but the memory<br>
+=C2=A0 usage will go beyond that if the number of concurrent clients is hi=
gh.<br>
+<br>
=C2=A0--nice n<br>
=C2=A0 =C2=A0Change process priority after initialization (``n`` greater th=
an 0 is<br>
=C2=A0 =C2=A0lower priority, ``n`` less than zero is higher priority).<br>
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c<br>
index ef688c23..67a69748 100644<br>
--- a/src/openvpn/platform.c<br>
+++ b/src/openvpn/platform.c<br>
@@ -193,6 +193,24 @@ void<br>
=C2=A0platform_mlockall(bool print_msg)<br>
=C2=A0{<br>
=C2=A0#ifdef HAVE_MLOCKALL<br>
+<br>
+#ifdef HAVE_GETRLIMIT<br>
+=C2=A0 =C2=A0 struct rlimit rl;<br>
+=C2=A0 =C2=A0 if (getrlimit(RLIMIT_MEMLOCK,&amp;rl)&lt;0)<br></blockquote>=
<div><br></div><div>spaces after &quot;,&quot; and around &quot;&lt;&quot;=
=C2=A0 :)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_ERRNO, &quot;WARNING: getrlimit=
(RLIMIT_MEMLOCK) failed&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_INFO, &quot;mlock: MEMLOCK limit: soft=3D=
%ldkb, hard=3D%dkb&quot;,<br>
</blockquote><div><br></div><div>%dkb --&gt; %ldkb</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0((long int) rl.rlim_cur)/1024, ((long int) rl.rlim_max)/10=
24);<br></blockquote><div><br></div><div>Some may argue that our style is t=
o put space around &quot;/&quot;</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rl.rlim_cur &lt; 20*1024*1024)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_FATAL, &quot;mlock: RLIMIT_=
MEMLOCK &lt; 20 MByte, increase limit&quot;);<br></blockquote><div><br></di=
v><div>Mbyte -&gt; MB or megabytes</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
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
=C2=A0#include &quot;buffer.h&quot;<br></blockquote><div><br></div><div>=C2=
=A0Selva</div></div></div></div>

--000000000000f4a36a05bcf590b2--

