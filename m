MIME-Version: 1.0
In-Reply-To: <1322828243-21196-1-git-send-email-davids@...1347...>
References: <1322828243-21196-1-git-send-email-davids@...1347...>
Date: Fri, 2 Dec 2011 14:25:51 +0200
Message-ID: <CAOazyz3QLENvuKcchda6sooFJCF60zT=AnrfhGnaXAhyHDBkPA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Content-Type: multipart/alternative; boundary=f46d0444eb8bd48bfb04b31b11c6
Subject: Re: [Openvpn-devel] [PATCH v2] Provide an access() wrapper for
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--f46d0444eb8bd48bfb04b31b11c6
Content-Type: text/plain; charset=UTF-8

Why not:
#ifdef WIN32
#define access _access
#endif

On Fri, Dec 2, 2011 at 2:17 PM, David Sommerseth <davids@...1347...> wrote:

> Commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1 adds extra file and
> directory checks at startup.  However, this patch makes use of some
> features not directly available in Windows.
>
> This patch avoids #include <unistd.h> on Windows and provides a
> wrapper for the needed access() function.  The wrapper function
> which is global for all platforms is called openvpn_access()
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> Cc: Heiko Hund <heiko.hund@...1489...>
> ---
>  misc.h    |   12 ++++++++++++
>  options.c |    9 ++++-----
>  syshead.h |    3 +++
>  win32.h   |   20 ++++++++++++++++++++
>  4 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/misc.h b/misc.h
> index 9b35f18..223467e 100644
> --- a/misc.h
> +++ b/misc.h
> @@ -387,6 +387,18 @@ const char *openvpn_basename (const char *path);
>  /* return the dirname of path - POSIX variant, which modifies the input */
>  const char *openvpn_dirname (char *path);
>
> +/* access() wrapper, for both Windows and POSIX environments */
> +#ifdef WIN32
> +static inline int
> +openvpn_access( const char *path, int mode) {
> +  return _access(path, mode);
> +}
> +#else
> +static inline int
> +openvpn_access( const char *path, int mode) {
> +  return access(path, mode);
> +}
> +#endif
>  /*
>  * A printf-like function (that only recognizes a subset of standard printf
>  * format operators) that prints arguments to an argv list instead
> diff --git a/options.c b/options.c
> index a29c115..891bb7f 100644
> --- a/options.c
> +++ b/options.c
> @@ -52,7 +52,6 @@
>  #include "configure.h"
>  #include "forward.h"
>  #include <ctype.h>
> -#include <unistd.h>
>
>  #include "memdbg.h"
>
> @@ -2617,18 +2616,18 @@ check_file_access(const int type, const char
> *file, const int mode, const char *
>       char *fullpath = strdup(file);  /* POSIX dirname() implementaion may
> modify its arguments */
>       const char *dirpath = openvpn_dirname(fullpath);
>
> -      if (access (dirpath, mode|X_OK) != 0)
> +      if (openvpn_access (dirpath, mode|X_OK) != 0)
>           errcode = errno;
>       free(fullpath);
>     }
>
>   /* Is the file itself accessible? */
> -  if (!errcode && (type & CHKACC_FILE) && (access (file, mode) != 0) )
> +  if (!errcode && (type & CHKACC_FILE) && (openvpn_access (file, mode) !=
> 0) )
>       errcode = errno;
>
>   /* If the file exists and is accessible, is it writable? */
> -  if (!errcode && (type & CHKACC_FILEXSTWR) && (access (file, F_OK) == 0)
> )
> -    if (access (file, W_OK) != 0)
> +  if (!errcode && (type & CHKACC_FILEXSTWR) && (openvpn_access (file,
> F_OK) == 0) )
> +    if (openvpn_access (file, W_OK) != 0)
>       errcode = errno;
>
>   /* Scream if an error is found */
> diff --git a/syshead.h b/syshead.h
> index f3c0ac9..232c214 100644
> --- a/syshead.h
> +++ b/syshead.h
> @@ -52,9 +52,12 @@
>  #ifdef WIN32
>  #include <windows.h>
>  #include <winsock2.h>
> +#include <io.h>
>  #define sleep(x) Sleep((x)*1000)
>  #define random rand
>  #define srandom srand
> +#else
> +#include <unistd.h>
>  #endif
>
>  #if defined(__APPLE__)
> diff --git a/win32.h b/win32.h
> index 23c04be..2b9cb8b 100644
> --- a/win32.h
> +++ b/win32.h
> @@ -70,6 +70,26 @@ struct security_attributes
>
>  #define HANDLE_DEFINED(h) ((h) != NULL && (h) != INVALID_HANDLE_VALUE)
>
> +/* Provide wrapper for the access() function
> + * based on information found here:
> + * http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=vs.80%29.aspx
> + */
> +#ifndef R_OK
> +#define R_OK 4
> +#endif
> +
> +#ifndef W_OK
> +#define W_OK 2
> +#endif
> +
> +#ifndef X_OK
> +#define X_OK 1
> +#endif
> +
> +#ifndef F_OK
> +#define F_OK 0
> +#endif
> +
>  /*
>  * Save old window title.
>  */
> --
> 1.7.4.4
>
>
>
> ------------------------------------------------------------------------------
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--f46d0444eb8bd48bfb04b31b11c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Why not:<br>#ifdef WIN32<br>#define access _access<br>#end=
if<br><br><div class=3D"gmail_quote">On Fri, Dec 2, 2011 at 2:17 PM, David =
Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:davids@...1347...">david=
s@...1347...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">Commit 0f2bc0dd92f43c91e3=
3bba8a66b06b98f281efc1 adds extra file and<br>
directory checks at startup. =C2=A0However, this patch makes use of some<br>
features not directly available in Windows.<br>
<br>
This patch avoids #include &lt;unistd.h&gt; on Windows and provides a<br>
</div>wrapper for the needed access() function. =C2=A0The wrapper function<=
br>
which is global for all platforms is called openvpn_access()<br>
<div class=3D"im"><br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...1347...">da=
vids@...1347...</a>&gt;<br>
Cc: Heiko Hund &lt;<a href=3D"mailto:heiko.hund@...1489...">heiko.hund@...1386...=
489...</a>&gt;<br>
---<br>
</div>=C2=A0misc.h =C2=A0 =C2=A0| =C2=A0 12 ++++++++++++<br>
=C2=A0options.c | =C2=A0 =C2=A09 ++++-----<br>
=C2=A0syshead.h | =C2=A0 =C2=A03 +++<br>
=C2=A0win32.h =C2=A0 | =C2=A0 20 ++++++++++++++++++++<br>
=C2=A04 files changed, 39 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/misc.h b/misc.h<br>
index 9b35f18..223467e 100644<br>
--- a/misc.h<br>
+++ b/misc.h<br>
@@ -387,6 +387,18 @@ const char *openvpn_basename (const char *path);<br>
=C2=A0/* return the dirname of path - POSIX variant, which modifies the inp=
ut */<br>
=C2=A0const char *openvpn_dirname (char *path);<br>
<br>
+/* access() wrapper, for both Windows and POSIX environments */<br>
+#ifdef WIN32<br>
+static inline int<br>
+openvpn_access( const char *path, int mode) {<br>
<div class=3D"im">+ =C2=A0return _access(path, mode);<br>
+}<br>
</div>+#else<br>
+static inline int<br>
+openvpn_access( const char *path, int mode) {<br>
+ =C2=A0return access(path, mode);<br>
+}<br>
+#endif<br>
=C2=A0/*<br>
 =C2=A0* A printf-like function (that only recognizes a subset of standard =
printf<br>
 =C2=A0* format operators) that prints arguments to an argv list instead<br>
diff --git a/options.c b/options.c<br>
index a29c115..891bb7f 100644<br>
<div class=3D"im">--- a/options.c<br>
+++ b/options.c<br>
@@ -52,7 +52,6 @@<br>
=C2=A0#include &quot;configure.h&quot;<br>
=C2=A0#include &quot;forward.h&quot;<br>
=C2=A0#include &lt;ctype.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
<br>
=C2=A0#include &quot;memdbg.h&quot;<br>
<br>
</div>@@ -2617,18 +2616,18 @@ check_file_access(const int type, const char =
*file, const int mode, const char *<br>
 =C2=A0 =C2=A0 =C2=A0 char *fullpath =3D strdup(file); =C2=A0/* POSIX dirna=
me() implementaion may modify its arguments */<br>
 =C2=A0 =C2=A0 =C2=A0 const char *dirpath =3D openvpn_dirname(fullpath);<br>
<br>
- =C2=A0 =C2=A0 =C2=A0if (access (dirpath, mode|X_OK) !=3D 0)<br>
+ =C2=A0 =C2=A0 =C2=A0if (openvpn_access (dirpath, mode|X_OK) !=3D 0)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errcode =3D errno;<br>
 =C2=A0 =C2=A0 =C2=A0 free(fullpath);<br>
 =C2=A0 =C2=A0 }<br>
<br>
 =C2=A0 /* Is the file itself accessible? */<br>
- =C2=A0if (!errcode &amp;&amp; (type &amp; CHKACC_FILE) &amp;&amp; (access=
 (file, mode) !=3D 0) )<br>
+ =C2=A0if (!errcode &amp;&amp; (type &amp; CHKACC_FILE) &amp;&amp; (openvp=
n_access (file, mode) !=3D 0) )<br>
 =C2=A0 =C2=A0 =C2=A0 errcode =3D errno;<br>
<br>
 =C2=A0 /* If the file exists and is accessible, is it writable? */<br>
- =C2=A0if (!errcode &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (a=
ccess (file, F_OK) =3D=3D 0) )<br>
- =C2=A0 =C2=A0if (access (file, W_OK) !=3D 0)<br>
+ =C2=A0if (!errcode &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (o=
penvpn_access (file, F_OK) =3D=3D 0) )<br>
+ =C2=A0 =C2=A0if (openvpn_access (file, W_OK) !=3D 0)<br>
 =C2=A0 =C2=A0 =C2=A0 errcode =3D errno;<br>
<br>
 =C2=A0 /* Scream if an error is found */<br>
<div class=3D"im">diff --git a/syshead.h b/syshead.h<br>
index f3c0ac9..232c214 100644<br>
--- a/syshead.h<br>
+++ b/syshead.h<br>
@@ -52,9 +52,12 @@<br>
=C2=A0#ifdef WIN32<br>
=C2=A0#include &lt;windows.h&gt;<br>
=C2=A0#include &lt;winsock2.h&gt;<br>
+#include &lt;io.h&gt;<br>
=C2=A0#define sleep(x) Sleep((x)*1000)<br>
=C2=A0#define random rand<br>
=C2=A0#define srandom srand<br>
+#else<br>
+#include &lt;unistd.h&gt;<br>
=C2=A0#endif<br>
<br>
=C2=A0#if defined(__APPLE__)<br>
diff --git a/win32.h b/win32.h<br>
</div>index 23c04be..2b9cb8b 100644<br>
--- a/win32.h<br>
+++ b/win32.h<br>
@@ -70,6 +70,26 @@ struct security_attributes<br>
<div class=3D"im"><br>
=C2=A0#define HANDLE_DEFINED(h) ((h) !=3D NULL &amp;&amp; (h) !=3D INVALID_=
HANDLE_VALUE)<br>
<br>
+/* Provide wrapper for the access() function<br>
+ * based on information found here:<br>
+ * <a href=3D"http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=3Dvs.80=
%29.aspx" target=3D"_blank">http://msdn.microsoft.com/en-us/library/1w06ktd=
y%28v=3Dvs.80%29.aspx</a><br>
+ */<br>
+#ifndef R_OK<br>
+#define R_OK 4<br>
+#endif<br>
+<br>
+#ifndef W_OK<br>
+#define W_OK 2<br>
+#endif<br>
+<br>
+#ifndef X_OK<br>
+#define X_OK 1<br>
+#endif<br>
+<br>
</div>+#ifndef F_OK<br>
+#define F_OK 0<br>
+#endif<br>
<div class=3D"HOEnZb"><div class=3D"h5">+<br>
=C2=A0/*<br>
 =C2=A0* Save old window title.<br>
 =C2=A0*/<br>
--<br>
1.7.4.4<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
All the data continuously generated in your IT infrastructure<br>
contains a definitive record of customers, application performance,<br>
security threats, fraudulent activity, and more. Splunk takes this<br>
data and makes sense of it. IT sense. And common sense.<br>
<a href=3D"http://p.sf.net/sfu/splunk-novd2d" target=3D"_blank">http://p.sf=
.net/sfu/splunk-novd2d</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</div></div></blockquote></div><br></div>

--f46d0444eb8bd48bfb04b31b11c6--

