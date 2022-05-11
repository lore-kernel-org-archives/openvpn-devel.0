MIME-Version: 1.0
References: <20220504091305.434-1-lstipakov@...277...>
In-Reply-To: <20220504091305.434-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 11 May 2022 14:13:43 -0400
Message-ID: <CAKuzo_gm3GjD7SHTmt5e7z3JkFUgJtXXfNzyq1NvTKzXLrYohA@...278...>
Content-Type: multipart/alternative; boundary="000000000000cbc45c05dec067cb"
Subject: Re: [Openvpn-devel] [PATCH release/2.5] Fix M_ERRNO behavior on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000cbc45c05dec067cb
Content-Type: text/plain; charset="UTF-8"

Acked-by: Selva Nair <selva.nair@...277...>

Same as the patch 2429 <https://patchwork.openvpn.net/patch/2429/> for
master except for the minor change in x_check_status() to match 2.5.

On Wed, May 4, 2022 at 5:13 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> We use M_ERRNO flag in logging to display error code
> and error message. This has been broken on Windows,
> where we use error code from GetLastError() and
> error description from strerror(). strerror() expects
> C runtime error code, which is quite different from
> last error code from WinAPI call. As a result, we got
> incorrect error description.
>
> The ultimate fix would be introducing another flag
> for WinAPI errors, like M_WINERR and use either that or
> M_ERRNO depends on context. However, the change would be
> quite intrusive and in some cases it is hard to say which
> one to use without looking into internals.
>
> Instead we stick to M_ERRNO and in Windows case we
> first try to obtain error code from GetLastError() and
> if it returns ERROR_SUCCESS (which is 0), we assume that
> we have C runtime error and use errno. To get error
> description we use strerror_win32() with GetLastError()
> and strerror() with errno.
>
> strerror_win32() uses FormatMessage() internally, which
> is the right way to get WinAPI error description.
> ---
>
>  This is a backport of patch acked for master
> (https://patchwork.openvpn.net/patch/2429/) with
> a conflict resolved in x_check_status() in error.c.
>
>  src/openvpn/error.c    | 32 +++++++++++++++++++++++++-------
>  src/openvpn/error.h    | 39 +++++++++++++++++++++++++++++----------
>  src/openvpn/forward.c  |  9 ++++++++-
>  src/openvpn/manage.c   |  5 +++--
>  src/openvpn/platform.c |  2 +-
>  src/openvpn/tun.h      |  4 ++--
>  6 files changed, 68 insertions(+), 23 deletions(-)
>
> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index 54796d03..7fbda844 100644
> --- a/src/openvpn/error.c
> +++ b/src/openvpn/error.c
> @@ -220,6 +220,18 @@ x_msg(const unsigned int flags, const char *format,
> ...)
>      va_end(arglist);
>  }
>
> +static const char*
> +openvpn_strerror(int err, bool crt_error, struct gc_arena *gc)
> +{
> +#ifdef _WIN32
> +    if (!crt_error)
> +    {
> +        return strerror_win32(err, gc);
> +    }
> +#endif
> +    return strerror(err);
> +}
> +
>  void
>  x_msg_va(const unsigned int flags, const char *format, va_list arglist)
>  {
> @@ -244,7 +256,8 @@ x_msg_va(const unsigned int flags, const char *format,
> va_list arglist)
>      }
>  #endif
>
> -    e = openvpn_errno();
> +    bool crt_error = false;
> +    e = openvpn_errno_maybe_crt(&crt_error);
>
>      /*
>       * Apply muting filter.
> @@ -268,7 +281,7 @@ x_msg_va(const unsigned int flags, const char *format,
> va_list arglist)
>      if ((flags & M_ERRNO) && e)
>      {
>          openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
> -                         m1, strerror(e), e);
> +                         m1, openvpn_strerror(e, crt_error, &gc), e);
>          SWAP;
>      }
>
> @@ -649,7 +662,6 @@ x_check_status(int status,
>                 struct link_socket *sock,
>                 struct tuntap *tt)
>  {
> -    const int my_errno = openvpn_errno();
>      const char *extended_msg = NULL;
>
>      msg(x_cs_verbose_level, "%s %s returned %d",
> @@ -672,26 +684,32 @@ x_check_status(int status,
>                  sock->info.mtu_changed = true;
>              }
>          }
> -#elif defined(_WIN32)
> +#endif /* EXTENDED_SOCKET_ERROR_CAPABILITY */
> +
> +#ifdef _WIN32
>          /* get possible driver error from TAP-Windows driver */
>          if (tuntap_defined(tt))
>          {
>              extended_msg = tap_win_getinfo(tt, &gc);
>          }
>  #endif
> -        if (!ignore_sys_error(my_errno))
> +
> +        bool crt_error = false;
> +        int my_errno = openvpn_errno_maybe_crt(&crt_error);
> +
> +        if (!ignore_sys_error(my_errno, crt_error))
>          {
>              if (extended_msg)
>              {
>                  msg(x_cs_info_level, "%s %s [%s]: %s (code=%d)",
> description,
>                      sock ? proto2ascii(sock->info.proto, sock->info.af,
> true) : "",
> -                    extended_msg, strerror(my_errno), my_errno);
> +                    extended_msg, openvpn_strerror(my_errno, crt_error,
> &gc), my_errno);
>              }
>              else
>              {
>                  msg(x_cs_info_level, "%s %s: %s (code=%d)", description,
>                      sock ? proto2ascii(sock->info.proto, sock->info.af,
> true) : "",
> -                    strerror(my_errno), my_errno);
> +                    openvpn_strerror(my_errno, crt_error, &gc), my_errno);
>              }
>
>              if (x_cs_err_delay_ms)
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index d2d83c8a..fc878a56 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -71,13 +71,10 @@ struct gc_arena;
>  /* String and Error functions */
>
>  #ifdef _WIN32
> -#define openvpn_errno()             GetLastError()
> -#define openvpn_strerror(e, gc)     strerror_win32(e, gc)
> +#define openvpn_errno() GetLastError()
>  const char *strerror_win32(DWORD errnum, struct gc_arena *gc);
> -
>  #else
> -#define openvpn_errno()             errno
> -#define openvpn_strerror(x, gc)     strerror(x)
> +#define openvpn_errno() errno
>  #endif
>
>  /*
> @@ -363,20 +360,22 @@ msg_get_virtual_output(void)
>   * which can be safely ignored.
>   */
>  static inline bool
> -ignore_sys_error(const int err)
> +ignore_sys_error(const int err, bool crt_error)
>  {
> -    /* I/O operation pending */
>  #ifdef _WIN32
> -    if (err == WSAEWOULDBLOCK || err == WSAEINVAL)
> +    if (!crt_error && ((err == WSAEWOULDBLOCK || err == WSAEINVAL)))
>      {
>          return true;
>      }
>  #else
> -    if (err == EAGAIN)
> +    crt_error = true;
> +#endif
> +
> +    /* I/O operation pending */
> +    if (crt_error && (err == EAGAIN))
>      {
>          return true;
>      }
> -#endif
>
>  #if 0 /* if enabled, suppress ENOBUFS errors */
>  #ifdef ENOBUFS
> @@ -398,6 +397,26 @@ nonfatal(const unsigned int err)
>      return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
>  }
>
> +static inline int
> +openvpn_errno_maybe_crt(bool *crt_error)
> +{
> +    int err = 0;
> +    *crt_error = false;
> +#ifdef _WIN32
> +    err = GetLastError();
> +    if (err == ERROR_SUCCESS)
> +    {
> +        /* error is likely C runtime */
> +        *crt_error = true;
> +        err = errno;
> +    }
> +#else
> +    *crt_error = true;
> +    err = errno;
> +#endif
> +    return err;
> +}
> +
>  #include "errlevel.h"
>
>  #endif /* ifndef ERROR_H */
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 392a5c9f..de80dcff 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1676,7 +1676,14 @@ process_outgoing_link(struct context *c)
>          }
>
>          /* for unreachable network and "connecting" state switch to the
> next host */
> -        if (size < 0 && ENETUNREACH == error_code && c->c2.tls_multi
> +
> +        bool unreachable = error_code ==
> +#ifdef _WIN32
> +            WSAENETUNREACH;
> +#else
> +            ENETUNREACH;
> +#endif
> +        if (size < 0 && unreachable && c->c2.tls_multi
>              && !tls_initial_packet_received(c->c2.tls_multi) &&
> c->options.mode == MODE_POINT_TO_POINT)
>          {
>              msg(M_INFO, "Network unreachable, restarting");
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index a4264056..8d2d9983 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -2082,9 +2082,10 @@ man_process_command(struct management *man, const
> char *line)
>  static bool
>  man_io_error(struct management *man, const char *prefix)
>  {
> -    const int err = openvpn_errno();
> +    bool crt_error = false;
> +    int err = openvpn_errno_maybe_crt(&crt_error);
>
> -    if (!ignore_sys_error(err))
> +    if (!ignore_sys_error(err, crt_error))
>      {
>          struct gc_arena gc = gc_new();
>          msg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s", prefix,
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index 2604c27b..4921f035 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -471,7 +471,7 @@ platform_test_file(const char *filename)
>          }
>          else
>          {
> -            if (openvpn_errno() == EACCES)
> +            if (errno == EACCES)
>              {
>                  msg( M_WARN | M_ERRNO, "Could not access file '%s'",
> filename);
>              }
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index ea19620d..ae98966b 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -461,7 +461,7 @@ tuntap_stop(int status)
>       */
>      if (status < 0)
>      {
> -        return openvpn_errno() == ERROR_FILE_NOT_FOUND;
> +        return GetLastError() == ERROR_FILE_NOT_FOUND;
>      }
>      return false;
>  }
> @@ -474,7 +474,7 @@ tuntap_abort(int status)
>       */
>      if (status < 0)
>      {
> -        return openvpn_errno() == ERROR_OPERATION_ABORTED;
> +        return GetLastError() == ERROR_OPERATION_ABORTED;
>      }
>      return false;
>  }
> --
> 2.23.0.windows.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000cbc45c05dec067cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair=
@...277...">selva.nair@...277...</a>&gt;</div><div><br></div><div>Same as t=
he patch=C2=A0<a href=3D"https://patchwork.openvpn.net/patch/2429/">2429</a=
> for master except for the minor change in x_check_status() to match 2.5.<=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, May 4, 2022 at 5:13 AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@=
...277...">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@=
...515..." target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
We use M_ERRNO flag in logging to display error code<br>
and error message. This has been broken on Windows,<br>
where we use error code from GetLastError() and<br>
error description from strerror(). strerror() expects<br>
C runtime error code, which is quite different from<br>
last error code from WinAPI call. As a result, we got<br>
incorrect error description.<br>
<br>
The ultimate fix would be introducing another flag<br>
for WinAPI errors, like M_WINERR and use either that or<br>
M_ERRNO depends on context. However, the change would be<br>
quite intrusive and in some cases it is hard to say which<br>
one to use without looking into internals.<br>
<br>
Instead we stick to M_ERRNO and in Windows case we<br>
first try to obtain error code from GetLastError() and<br>
if it returns ERROR_SUCCESS (which is 0), we assume that<br>
we have C runtime error and use errno. To get error<br>
description we use strerror_win32() with GetLastError()<br>
and strerror() with errno.<br>
<br>
strerror_win32() uses FormatMessage() internally, which<br>
is the right way to get WinAPI error description.<br>
---<br>
<br>
=C2=A0This is a backport of patch acked for master<br>
(<a href=3D"https://patchwork.openvpn.net/patch/2429/" rel=3D"noreferrer" t=
arget=3D"_blank">https://patchwork.openvpn.net/patch/2429/</a>) with<br>
a conflict resolved in x_check_status() in error.c.<br>
<br>
=C2=A0src/openvpn/error.c=C2=A0 =C2=A0 | 32 +++++++++++++++++++++++++------=
-<br>
=C2=A0src/openvpn/error.h=C2=A0 =C2=A0 | 39 +++++++++++++++++++++++++++++--=
--------<br>
=C2=A0src/openvpn/forward.c=C2=A0 |=C2=A0 9 ++++++++-<br>
=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A0src/openvpn/platform.c |=C2=A0 2 +-<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A06 files changed, 68 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/src/openvpn/error.c b/src/openvpn/error.c<br>
index 54796d03..7fbda844 100644<br>
--- a/src/openvpn/error.c<br>
+++ b/src/openvpn/error.c<br>
@@ -220,6 +220,18 @@ x_msg(const unsigned int flags, const char *format, ..=
.)<br>
=C2=A0 =C2=A0 =C2=A0va_end(arglist);<br>
=C2=A0}<br>
<br>
+static const char*<br>
+openvpn_strerror(int err, bool crt_error, struct gc_arena *gc)<br>
+{<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 if (!crt_error)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return strerror_win32(err, gc);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+=C2=A0 =C2=A0 return strerror(err);<br>
+}<br>
+<br>
=C2=A0void<br>
=C2=A0x_msg_va(const unsigned int flags, const char *format, va_list arglis=
t)<br>
=C2=A0{<br>
@@ -244,7 +256,8 @@ x_msg_va(const unsigned int flags, const char *format, =
va_list arglist)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 e =3D openvpn_errno();<br>
+=C2=A0 =C2=A0 bool crt_error =3D false;<br>
+=C2=A0 =C2=A0 e =3D openvpn_errno_maybe_crt(&amp;crt_error);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Apply muting filter.<br>
@@ -268,7 +281,7 @@ x_msg_va(const unsigned int flags, const char *format, =
va_list arglist)<br>
=C2=A0 =C2=A0 =C2=A0if ((flags &amp; M_ERRNO) &amp;&amp; e)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_snprintf(m2, ERR_BUF_SIZE, &quot;=
%s: %s (errno=3D%d)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0m1, strerror(e), e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0m1, openvpn_strerror(e, crt_error, &amp;gc), e);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SWAP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -649,7 +662,6 @@ x_check_status(int status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct link_socket =
*sock,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tuntap *tt)<=
br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const int my_errno =3D openvpn_errno();<br>
=C2=A0 =C2=A0 =C2=A0const char *extended_msg =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0msg(x_cs_verbose_level, &quot;%s %s returned %d&quot;,<=
br>
@@ -672,26 +684,32 @@ x_check_status(int status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sock-&gt;info=
.mtu_changed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-#elif defined(_WIN32)<br>
+#endif /* EXTENDED_SOCKET_ERROR_CAPABILITY */<br>
+<br>
+#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* get possible driver error from TAP-Win=
dows driver */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tuntap_defined(tt))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extended_msg =3D tap_win_ge=
tinfo(tt, &amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ignore_sys_error(my_errno))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool crt_error =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int my_errno =3D openvpn_errno_maybe_crt(&amp;=
crt_error);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ignore_sys_error(my_errno, crt_error))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (extended_msg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(x_cs_info=
_level, &quot;%s %s [%s]: %s (code=3D%d)&quot;, description,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sock ? proto2ascii(sock-&gt;info.proto, sock-&gt;<a href=3D"http://info.=
af" rel=3D"noreferrer" target=3D"_blank">info.af</a>, true) : &quot;&quot;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exte=
nded_msg, strerror(my_errno), my_errno);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exte=
nded_msg, openvpn_strerror(my_errno, crt_error, &amp;gc), my_errno);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(x_cs_info=
_level, &quot;%s %s: %s (code=3D%d)&quot;, description,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sock ? proto2ascii(sock-&gt;info.proto, sock-&gt;<a href=3D"http://info.=
af" rel=3D"noreferrer" target=3D"_blank">info.af</a>, true) : &quot;&quot;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stre=
rror(my_errno), my_errno);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open=
vpn_strerror(my_errno, crt_error, &amp;gc), my_errno);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (x_cs_err_delay_ms)<br>
diff --git a/src/openvpn/error.h b/src/openvpn/error.h<br>
index d2d83c8a..fc878a56 100644<br>
--- a/src/openvpn/error.h<br>
+++ b/src/openvpn/error.h<br>
@@ -71,13 +71,10 @@ struct gc_arena;<br>
=C2=A0/* String and Error functions */<br>
<br>
=C2=A0#ifdef _WIN32<br>
-#define openvpn_errno()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get=
LastError()<br>
-#define openvpn_strerror(e, gc)=C2=A0 =C2=A0 =C2=A0strerror_win32(e, gc)<b=
r>
+#define openvpn_errno() GetLastError()<br>
=C2=A0const char *strerror_win32(DWORD errnum, struct gc_arena *gc);<br>
-<br>
=C2=A0#else<br>
-#define openvpn_errno()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err=
no<br>
-#define openvpn_strerror(x, gc)=C2=A0 =C2=A0 =C2=A0strerror(x)<br>
+#define openvpn_errno() errno<br>
=C2=A0#endif<br>
<br>
=C2=A0/*<br>
@@ -363,20 +360,22 @@ msg_get_virtual_output(void)<br>
=C2=A0 * which can be safely ignored.<br>
=C2=A0 */<br>
=C2=A0static inline bool<br>
-ignore_sys_error(const int err)<br>
+ignore_sys_error(const int err, bool crt_error)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* I/O operation pending */<br>
=C2=A0#ifdef _WIN32<br>
-=C2=A0 =C2=A0 if (err =3D=3D WSAEWOULDBLOCK || err =3D=3D WSAEINVAL)<br>
+=C2=A0 =C2=A0 if (!crt_error &amp;&amp; ((err =3D=3D WSAEWOULDBLOCK || err=
 =3D=3D WSAEINVAL)))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 if (err =3D=3D EAGAIN)<br>
+=C2=A0 =C2=A0 crt_error =3D true;<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 /* I/O operation pending */<br>
+=C2=A0 =C2=A0 if (crt_error &amp;&amp; (err =3D=3D EAGAIN))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-#endif<br>
<br>
=C2=A0#if 0 /* if enabled, suppress ENOBUFS errors */<br>
=C2=A0#ifdef ENOBUFS<br>
@@ -398,6 +397,26 @@ nonfatal(const unsigned int err)<br>
=C2=A0 =C2=A0 =C2=A0return err &amp; M_FATAL ? (err ^ M_FATAL) | M_NONFATAL=
 : err;<br>
=C2=A0}<br>
<br>
+static inline int<br>
+openvpn_errno_maybe_crt(bool *crt_error)<br>
+{<br>
+=C2=A0 =C2=A0 int err =3D 0;<br>
+=C2=A0 =C2=A0 *crt_error =3D false;<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 err =3D GetLastError();<br>
+=C2=A0 =C2=A0 if (err =3D=3D ERROR_SUCCESS)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error is likely C runtime */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *crt_error =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D errno;<br>
+=C2=A0 =C2=A0 }<br>
+#else<br>
+=C2=A0 =C2=A0 *crt_error =3D true;<br>
+=C2=A0 =C2=A0 err =3D errno;<br>
+#endif<br>
+=C2=A0 =C2=A0 return err;<br>
+}<br>
+<br>
=C2=A0#include &quot;errlevel.h&quot;<br>
<br>
=C2=A0#endif /* ifndef ERROR_H */<br>
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<br>
index 392a5c9f..de80dcff 100644<br>
--- a/src/openvpn/forward.c<br>
+++ b/src/openvpn/forward.c<br>
@@ -1676,7 +1676,14 @@ process_outgoing_link(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* for unreachable network and &quot;conn=
ecting&quot; state switch to the next host */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size &lt; 0 &amp;&amp; ENETUNREACH =3D=3D =
error_code &amp;&amp; c-&gt;c2.tls_multi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool unreachable =3D error_code =3D=3D<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WSAENETUNREACH;<br>
+#else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ENETUNREACH;<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size &lt; 0 &amp;&amp; unreachable &amp;&a=
mp; c-&gt;c2.tls_multi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; !tls_initial_pac=
ket_received(c-&gt;c2.tls_multi) &amp;&amp; c-&gt;options.mode =3D=3D MODE_=
POINT_TO_POINT)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_INFO, &quot;Network u=
nreachable, restarting&quot;);<br>
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c<br>
index a4264056..8d2d9983 100644<br>
--- a/src/openvpn/manage.c<br>
+++ b/src/openvpn/manage.c<br>
@@ -2082,9 +2082,10 @@ man_process_command(struct management *man, const ch=
ar *line)<br>
=C2=A0static bool<br>
=C2=A0man_io_error(struct management *man, const char *prefix)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const int err =3D openvpn_errno();<br>
+=C2=A0 =C2=A0 bool crt_error =3D false;<br>
+=C2=A0 =C2=A0 int err =3D openvpn_errno_maybe_crt(&amp;crt_error);<br>
<br>
-=C2=A0 =C2=A0 if (!ignore_sys_error(err))<br>
+=C2=A0 =C2=A0 if (!ignore_sys_error(err, crt_error))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_MANAGEMENT, &quot;MANAGEMENT: TCP %=
s error: %s&quot;, prefix,<br>
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c<br>
index 2604c27b..4921f035 100644<br>
--- a/src/openvpn/platform.c<br>
+++ b/src/openvpn/platform.c<br>
@@ -471,7 +471,7 @@ platform_test_file(const char *filename)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (openvpn_errno() =3D=3D EACCE=
S)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D EACCES)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg( M_WARN |=
 M_ERRNO, &quot;Could not access file &#39;%s&#39;&quot;, filename);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<br>
index ea19620d..ae98966b 100644<br>
--- a/src/openvpn/tun.h<br>
+++ b/src/openvpn/tun.h<br>
@@ -461,7 +461,7 @@ tuntap_stop(int status)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openvpn_errno() =3D=3D ERROR_FILE_NOT_F=
OUND;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError() =3D=3D ERROR_FILE_NOT_FO=
UND;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
@@ -474,7 +474,7 @@ tuntap_abort(int status)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openvpn_errno() =3D=3D ERROR_OPERATION_=
ABORTED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError() =3D=3D ERROR_OPERATION_A=
BORTED;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
-- <br>
2.23.0.windows.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000cbc45c05dec067cb--

