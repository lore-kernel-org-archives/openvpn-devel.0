MIME-Version: 1.0
References: <CAGyAFMWSHhzpTzEe+TJXD6jasv+w+vGCYygH6uXjEm1k4L0qxQ@...278...>
 <20220503002840.295-1-lstipakov@...277...>
In-Reply-To: <20220503002840.295-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 3 May 2022 15:12:49 -0400
Message-ID: <CAKuzo_izJiqNaNfD8-xjxf+133fbKnee+KfKaceYkZzvi_pCOw@...278...>
Content-Type: multipart/alternative; boundary="0000000000006232a405de204cc4"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix M_ERRNO behavior on Windows
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

--0000000000006232a405de204cc4
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the changes. Looks good.

On Tue, May 3, 2022 at 9:12 AM Lev Stipakov <lstipakov@...277...> wrote:

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
>  v2:
>   - removed WSA error printing, to be implemented in a follow-up patch
>   - added missing crt error fallback to x_check_status() and
>     main_io_error()
>   - fixed "network unreachable" detection
>
>  src/openvpn/error.c    | 34 +++++++++++++++++++++++++++-------
>  src/openvpn/error.h    | 39 +++++++++++++++++++++++++++++----------
>  src/openvpn/forward.c  |  9 ++++++++-
>  src/openvpn/manage.c   |  5 +++--
>  src/openvpn/platform.c |  2 +-
>  src/openvpn/tun.h      |  4 ++--
>  6 files changed, 70 insertions(+), 23 deletions(-)
>
> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index 603d6c63..1b7f5cde 100644
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
> @@ -242,7 +254,8 @@ x_msg_va(const unsigned int flags, const char *format,
> va_list arglist)
>          return;
>      }
>
> -    e = openvpn_errno();
> +    bool crt_error = false;
> +    e = openvpn_errno_maybe_crt(&crt_error);
>
>      /*
>       * Apply muting filter.
> @@ -264,7 +277,7 @@ x_msg_va(const unsigned int flags, const char *format,
> va_list arglist)
>      if ((flags & M_ERRNO) && e)
>      {
>          openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
> -                         m1, strerror(e), e);
> +                         m1, openvpn_strerror(e, crt_error, &gc), e);
>          SWAP;
>      }
>
> @@ -643,7 +656,6 @@ x_check_status(int status,
>                 struct link_socket *sock,
>                 struct tuntap *tt)
>  {
> -    const int my_errno = openvpn_errno();
>      const char *extended_msg = NULL;
>
>      msg(x_cs_verbose_level, "%s %s returned %d",
> @@ -666,26 +678,34 @@ x_check_status(int status,
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
>                  msg(x_cs_info_level, "%s %s [%s]: %s (fd=%d,code=%d)",
> description,
>                      sock ? proto2ascii(sock->info.proto, sock->info.af,
> true) : "",
> -                    extended_msg, strerror(my_errno), sock ? sock->sd :
> -1, my_errno);
> +                    extended_msg, openvpn_strerror(my_errno, crt_error,
> &gc),
> +                    sock ? sock->sd : -1, my_errno);
>              }
>              else
>              {
>                  msg(x_cs_info_level, "%s %s: %s (fd=%d,code=%d)",
> description,
>                      sock ? proto2ascii(sock->info.proto, sock->info.af,
> true) : "",
> -                    strerror(my_errno), sock ? sock->sd : -1, my_errno);
> +                    openvpn_strerror(my_errno, crt_error, &gc),
> +                    sock ? sock->sd : -1, my_errno);
>              }
>
>              if (x_cs_err_delay_ms)
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index ad7defe8..be8d97e5 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -75,13 +75,10 @@ struct gc_arena;
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
> @@ -352,20 +349,22 @@ msg_get_virtual_output(void)
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
> @@ -387,6 +386,26 @@ nonfatal(const unsigned int err)
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
> index 8930e578..04828a5c 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1660,7 +1660,14 @@ process_outgoing_link(struct context *c)
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
> index 9b03b057..036658b1 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -2008,9 +2008,10 @@ man_process_command(struct management *man, const
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
> index 61afee83..ae1678db 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -532,7 +532,7 @@ platform_test_file(const char *filename)
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
> index 3a7314c5..4bc35916 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -446,7 +446,7 @@ tuntap_stop(int status)
>       */
>      if (status < 0)
>      {
> -        return openvpn_errno() == ERROR_FILE_NOT_FOUND;
> +        return GetLastError() == ERROR_FILE_NOT_FOUND;
>      }
>      return false;
>  }
> @@ -459,7 +459,7 @@ tuntap_abort(int status)
>       */
>      if (status < 0)
>      {
> -        return openvpn_errno() == ERROR_OPERATION_ABORTED;
> +        return GetLastError() == ERROR_OPERATION_ABORTED;
>      }
>      return false;
>  }
>

Acked-by: Selva Nair <selva.nair@...277...>

--0000000000006232a405de204cc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Thanks for the changes. =
Looks good.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, May 3, 2022 at 9:12 AM Lev Stipakov &lt;<a href=3D"mailt=
o:lstipakov@...277..." target=3D"_blank">lstipakov@...277...</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stipa=
kov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a=
>&gt;<br>
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
=C2=A0v2:<br>
=C2=A0 - removed WSA error printing, to be implemented in a follow-up patch=
<br>
=C2=A0 - added missing crt error fallback to x_check_status() and<br>
=C2=A0 =C2=A0 main_io_error()<br>
=C2=A0 - fixed &quot;network unreachable&quot; detection<br>
<br>
=C2=A0src/openvpn/error.c=C2=A0 =C2=A0 | 34 +++++++++++++++++++++++++++----=
---<br>
=C2=A0src/openvpn/error.h=C2=A0 =C2=A0 | 39 +++++++++++++++++++++++++++++--=
--------<br>
=C2=A0src/openvpn/forward.c=C2=A0 |=C2=A0 9 ++++++++-<br>
=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A0src/openvpn/platform.c |=C2=A0 2 +-<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A06 files changed, 70 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/src/openvpn/error.c b/src/openvpn/error.c<br>
index 603d6c63..1b7f5cde 100644<br>
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
@@ -242,7 +254,8 @@ x_msg_va(const unsigned int flags, const char *format, =
va_list arglist)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 e =3D openvpn_errno();<br>
+=C2=A0 =C2=A0 bool crt_error =3D false;<br>
+=C2=A0 =C2=A0 e =3D openvpn_errno_maybe_crt(&amp;crt_error);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Apply muting filter.<br>
@@ -264,7 +277,7 @@ x_msg_va(const unsigned int flags, const char *format, =
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
@@ -643,7 +656,6 @@ x_check_status(int status,<br>
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
@@ -666,26 +678,34 @@ x_check_status(int status,<br>
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
_level, &quot;%s %s [%s]: %s (fd=3D%d,code=3D%d)&quot;, description,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sock ? proto2ascii(sock-&gt;info.proto, sock-&gt;<a href=3D"http://info.=
af" rel=3D"noreferrer" target=3D"_blank">info.af</a>, true) : &quot;&quot;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exte=
nded_msg, strerror(my_errno), sock ? sock-&gt;sd : -1, my_errno);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exte=
nded_msg, openvpn_strerror(my_errno, crt_error, &amp;gc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sock=
 ? sock-&gt;sd : -1, my_errno);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(x_cs_info=
_level, &quot;%s %s: %s (fd=3D%d,code=3D%d)&quot;, description,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sock ? proto2ascii(sock-&gt;info.proto, sock-&gt;<a href=3D"http://info.=
af" rel=3D"noreferrer" target=3D"_blank">info.af</a>, true) : &quot;&quot;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stre=
rror(my_errno), sock ? sock-&gt;sd : -1, my_errno);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open=
vpn_strerror(my_errno, crt_error, &amp;gc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sock=
 ? sock-&gt;sd : -1, my_errno);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (x_cs_err_delay_ms)<br>
diff --git a/src/openvpn/error.h b/src/openvpn/error.h<br>
index ad7defe8..be8d97e5 100644<br>
--- a/src/openvpn/error.h<br>
+++ b/src/openvpn/error.h<br>
@@ -75,13 +75,10 @@ struct gc_arena;<br>
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
@@ -352,20 +349,22 @@ msg_get_virtual_output(void)<br>
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
@@ -387,6 +386,26 @@ nonfatal(const unsigned int err)<br>
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
index 8930e578..04828a5c 100644<br>
--- a/src/openvpn/forward.c<br>
+++ b/src/openvpn/forward.c<br>
@@ -1660,7 +1660,14 @@ process_outgoing_link(struct context *c)<br>
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
index 9b03b057..036658b1 100644<br>
--- a/src/openvpn/manage.c<br>
+++ b/src/openvpn/manage.c<br>
@@ -2008,9 +2008,10 @@ man_process_command(struct management *man, const ch=
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
index 61afee83..ae1678db 100644<br>
--- a/src/openvpn/platform.c<br>
+++ b/src/openvpn/platform.c<br>
@@ -532,7 +532,7 @@ platform_test_file(const char *filename)<br>
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
index 3a7314c5..4bc35916 100644<br>
--- a/src/openvpn/tun.h<br>
+++ b/src/openvpn/tun.h<br>
@@ -446,7 +446,7 @@ tuntap_stop(int status)<br>
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
@@ -459,7 +459,7 @@ tuntap_abort(int status)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openvpn_errno() =3D=3D ERROR_OPERATION_=
ABORTED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError() =3D=3D ERROR_OPERATION_A=
BORTED;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br></blockquote><div><br></div><div>Acked-by: Selva Nair &lt;<a hre=
f=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a=
>&gt;</div></div></div>

--0000000000006232a405de204cc4--

