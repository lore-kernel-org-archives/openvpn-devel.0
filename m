MIME-Version: 1.0
References: <CAKuzo_gy_xHzy8Tscb8xJ7QKN5+OZZksG7o_0eYkao8FDDJ5WA@...278...>
 <20220117094917.178-1-lstipakov@...277...>
In-Reply-To: <20220117094917.178-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 20 Jan 2022 22:22:34 -0500
Message-ID: <CAKuzo_i8v7rsbpozS-CkD4kcZKLw+HN1t2vDQ7Pdg63X56agHQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000041acf805d60f2233"
Subject: Re: [Openvpn-devel] [PATCH v3] tun: remove tun_finalize()
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

--00000000000041acf805d60f2233
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Jan 17, 2022 at 4:51 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> tun_finalize() is essentially subset of socket_finalize() apart from:
>
>  - using WSAFoo() functions instead of Foo()
>
>  - "from" address is not returned
>
> There is no clear official statement that one can use non-WSA
> API on handles, so let's be on a safe side and use both.
>
> Introduce sockethandle_t abstraction, which represents
> socket and handle. Add SocketHandle* routines which call
> proper API depends on underlying type in abstraction.
>
> Rename socket_finalize() to sockethandle_finalize(), take
> sockethandle_t and new routines into use and kick tun_finalize().
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v3: replace macros with inline functions
>
>  v2: explicitly initialize .is_handle to false for readablity
>
>
>  src/openvpn/forward.c |  3 +-
>  src/openvpn/socket.c  | 37 ++++++++---------
>  src/openvpn/socket.h  | 49 ++++++++++++++++++----
>  src/openvpn/tun.c     | 94 +++++++++----------------------------------
>  src/openvpn/tun.h     | 34 +---------------
>  5 files changed, 80 insertions(+), 137 deletions(-)
>
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index f82386a1..a905f993 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1115,7 +1115,8 @@ read_incoming_tun(struct context *c)
>      }
>      else
>      {
> -        read_tun_buffered(c->c1.tuntap, &c->c2.buf);
> +        sockethandle_t sh = { .is_handle = true, .h = c->c1.tuntap->hand
> };
> +        sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
>      }
>  #else  /* ifdef _WIN32 */
>      ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index df736746..780c5cb3 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -3198,7 +3198,8 @@ link_socket_read_tcp(struct link_socket *sock,
>      if (!sock->stream_buf.residual_fully_formed)
>      {
>  #ifdef _WIN32
> -        len = socket_finalize(sock->sd, &sock->reads, buf, NULL);
> +        sockethandle_t sh = { .s = sock->sd };
> +        len = sockethandle_finalize(sh, &sock->reads, buf, NULL);
>  #else
>          struct buffer frag;
>          stream_buf_get_next(&sock->stream_buf, &frag);
> @@ -3664,10 +3665,10 @@ socket_send_queue(struct link_socket *sock, struct
> buffer *buf, const struct lin
>  }
>
>  int
> -socket_finalize(SOCKET s,
> -                struct overlapped_io *io,
> -                struct buffer *buf,
> -                struct link_socket_actual *from)
> +sockethandle_finalize(sockethandle_t sh,
> +                      struct overlapped_io *io,
> +                      struct buffer *buf,
> +                      struct link_socket_actual *from)
>  {
>      int ret = -1;
>      BOOL status;
> @@ -3675,13 +3676,7 @@ socket_finalize(SOCKET s,
>      switch (io->iostate)
>      {
>          case IOSTATE_QUEUED:
> -            status = WSAGetOverlappedResult(
> -                s,
> -                &io->overlapped,
> -                &io->size,
> -                FALSE,
> -                &io->flags
> -                );
> +            status = SocketHandleGetOverlappedResult(sh, io);
>              if (status)
>              {
>                  /* successful return for a queued operation */
> @@ -3693,18 +3688,18 @@ socket_finalize(SOCKET s,
>                  io->iostate = IOSTATE_INITIAL;
>                  ASSERT(ResetEvent(io->overlapped.hEvent));
>
> -                dmsg(D_WIN32_IO, "WIN32 I/O: Socket Completion success
> [%d]", ret);
> +                dmsg(D_WIN32_IO, "WIN32 I/O: Completion success [%d]",
> ret);
>              }
>              else
>              {
>                  /* error during a queued operation */
>                  ret = -1;
> -                if (WSAGetLastError() != WSA_IO_INCOMPLETE)
> +                if (SocketHandleGetLastError(sh) != ERROR_IO_INCOMPLETE)
>

WSA_IO_INCOMPLETE is the same as ERROR_IO_INCOMPLETE, so using them
interchangeably looks ok.

                 {
>                      /* if no error (i.e. just not finished yet), then
> DON'T execute this code */
>                      io->iostate = IOSTATE_INITIAL;
>                      ASSERT(ResetEvent(io->overlapped.hEvent));
> -                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Socket
> Completion error");
> +                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion
> error");
>                  }
>              }
>              break;
> @@ -3715,9 +3710,9 @@ socket_finalize(SOCKET s,
>              if (io->status)
>              {
>                  /* error return for a non-queued operation */
> -                WSASetLastError(io->status);
> +                SocketHandleSetLastError(sh, io->status);
>                  ret = -1;
> -                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Socket Completion
> non-queued error");
> +                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion
> non-queued error");
>              }
>              else
>              {
> @@ -3727,14 +3722,14 @@ socket_finalize(SOCKET s,
>                      *buf = io->buf;
>                  }
>                  ret = io->size;
> -                dmsg(D_WIN32_IO, "WIN32 I/O: Socket Completion non-queued
> success [%d]", ret);
> +                dmsg(D_WIN32_IO, "WIN32 I/O: Completion non-queued
> success [%d]", ret);
>              }
>              break;
>
>          case IOSTATE_INITIAL: /* were we called without proper queueing?
> */
> -            WSASetLastError(WSAEINVAL);
> +            SocketHandleSetInvalError(sh);
>              ret = -1;
> -            dmsg(D_WIN32_IO, "WIN32 I/O: Socket Completion BAD STATE");
> +            dmsg(D_WIN32_IO, "WIN32 I/O: Completion BAD STATE");
>              break;
>
>          default:
> @@ -3742,7 +3737,7 @@ socket_finalize(SOCKET s,
>      }
>
>      /* return from address if requested */
> -    if (from)
> +    if (!sh.is_handle && from)
>      {
>          if (ret >= 0 && io->addr_defined)
>          {
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index cc1e0c36..77c3d720 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -262,11 +262,44 @@ int socket_send_queue(struct link_socket *sock,
>                        struct buffer *buf,
>                        const struct link_socket_actual *to);
>
> -int socket_finalize(
> -    SOCKET s,
> -    struct overlapped_io *io,
> -    struct buffer *buf,
> -    struct link_socket_actual *from);
> +typedef struct {
> +    union {
> +        SOCKET s;
> +        HANDLE h;
> +    };
> +    bool is_handle;
> +} sockethandle_t;
> +
> +int sockethandle_finalize(sockethandle_t sh,
> +                          struct overlapped_io *io,
> +                          struct buffer *buf,
> +                          struct link_socket_actual *from);
> +
> +static inline BOOL
> +SocketHandleGetOverlappedResult(sockethandle_t sh, struct overlapped_io
> *io)
> +{
> +    return sh.is_handle ?
> +        GetOverlappedResult(sh.h, &io->overlapped, &io->size, FALSE) :
> +        WSAGetOverlappedResult(sh.s, &io->overlapped, &io->size, FALSE,
> &io->flags);
> +}
> +
> +static inline int
> +SocketHandleGetLastError(sockethandle_t sh)
> +{
> +    return sh.is_handle ? (int)GetLastError() : WSAGetLastError();
> +}
> +
> +inline static void
> +SocketHandleSetLastError(sockethandle_t sh, DWORD err)
> +{
> +    sh.is_handle ? SetLastError(err) : WSASetLastError(err);
>

To be consistent, one could add an explicit cast here too and avoid a
potential compiler warning:

WSASetLastError((int) err);


> +}
> +
> +static inline void
> +SocketHandleSetInvalError(sockethandle_t sh)
> +{
> +    sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) :
> WSASetLastError(WSAEINVAL);
> +}
>

I'm not sure whether ERROR_INVALID_FUNCTION is the appropriate error code
here. WSAEINVAL is more like invalid-argument (so ERROR_BAD_ARGUMENTS?).
But this agrees with the original, so let it be.


>
>  #else  /* ifdef _WIN32 */
>
> @@ -1020,7 +1053,8 @@ link_socket_read_udp_win32(struct link_socket *sock,
>                             struct buffer *buf,
>                             struct link_socket_actual *from)
>  {
> -    return socket_finalize(sock->sd, &sock->reads, buf, from);
> +    sockethandle_t sh = { .s = sock->sd };
> +    return sockethandle_finalize(sh, &sock->reads, buf, from);
>  }
>
>  #else  /* ifdef _WIN32 */
> @@ -1078,9 +1112,10 @@ link_socket_write_win32(struct link_socket *sock,
>  {
>      int err = 0;
>      int status = 0;
> +    sockethandle_t sh = { .s = sock->sd };
>      if (overlapped_io_active(&sock->writes))
>      {
> -        status = socket_finalize(sock->sd, &sock->writes, NULL, NULL);
> +        status = sockethandle_finalize(sh, &sock->writes, NULL, NULL);
>          if (status < 0)
>          {
>              err = WSAGetLastError();
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 12bdd200..fe32127b 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -3561,87 +3561,29 @@ tun_write_queue(struct tuntap *tt, struct buffer
> *buf)
>  }
>
>  int
> -tun_finalize(
> -    HANDLE h,
> -    struct overlapped_io *io,
> -    struct buffer *buf)
> +tun_write_win32(struct tuntap *tt, struct buffer *buf)
>  {
> -    int ret = -1;
> -    BOOL status;
> -
> -    switch (io->iostate)
> +    int err = 0;
> +    int status = 0;
> +    if (overlapped_io_active(&tt->writes))
>      {
> -        case IOSTATE_QUEUED:
> -            status = GetOverlappedResult(
> -                h,
> -                &io->overlapped,
> -                &io->size,
> -                FALSE
> -                );
> -            if (status)
> -            {
> -                /* successful return for a queued operation */
> -                if (buf)
> -                {
> -                    *buf = io->buf;
> -                }
> -                ret = io->size;
> -                io->iostate = IOSTATE_INITIAL;
> -                ASSERT(ResetEvent(io->overlapped.hEvent));
> -                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Completion success
> [%d]", ret);
> -            }
> -            else
> -            {
> -                /* error during a queued operation */
> -                ret = -1;
> -                if (GetLastError() != ERROR_IO_INCOMPLETE)
> -                {
> -                    /* if no error (i.e. just not finished yet),
> -                     * then DON'T execute this code */
> -                    io->iostate = IOSTATE_INITIAL;
> -                    ASSERT(ResetEvent(io->overlapped.hEvent));
> -                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: TAP Completion
> error");
> -                }
> -            }
> -            break;
> -
> -        case IOSTATE_IMMEDIATE_RETURN:
> -            io->iostate = IOSTATE_INITIAL;
> -            ASSERT(ResetEvent(io->overlapped.hEvent));
> -            if (io->status)
> -            {
> -                /* error return for a non-queued operation */
> -                SetLastError(io->status);
> -                ret = -1;
> -                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: TAP Completion
> non-queued error");
> -            }
> -            else
> -            {
> -                /* successful return for a non-queued operation */
> -                if (buf)
> -                {
> -                    *buf = io->buf;
> -                }
> -                ret = io->size;
> -                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Completion non-queued
> success [%d]", ret);
> -            }
> -            break;
> -
> -        case IOSTATE_INITIAL: /* were we called without proper queueing?
> */
> -            SetLastError(ERROR_INVALID_FUNCTION);
> -            ret = -1;
> -            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Completion BAD STATE");
> -            break;
> -
> -        default:
> -            ASSERT(0);
> +        sockethandle_t sh = { .is_handle = true, .h = tt->hand };
> +        status = sockethandle_finalize(sh, &tt->writes, NULL, NULL);
> +        if (status < 0)
> +        {
> +            err = GetLastError();
> +        }
>      }
> -
> -    if (buf)
> +    tun_write_queue(tt, buf);
> +    if (status < 0)
>      {
> -        buf->len = ret;
> +        SetLastError(err);
> +        return status;
> +    }
> +    else
> +    {
> +        return BLEN(buf);
>      }
> -    return ret;
>  }
>
>  static const struct device_instance_id_interface *
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index d4657537..a6661be0 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -437,8 +437,6 @@ int tun_read_queue(struct tuntap *tt, int maxsize);
>
>  int tun_write_queue(struct tuntap *tt, struct buffer *buf);
>
> -int tun_finalize(HANDLE h, struct overlapped_io *io, struct buffer *buf);
> -
>  static inline bool
>  tuntap_stop(int status)
>  {
> @@ -466,36 +464,8 @@ tuntap_abort(int status)
>      return false;
>  }
>
> -static inline int
> -tun_write_win32(struct tuntap *tt, struct buffer *buf)
> -{
> -    int err = 0;
> -    int status = 0;
> -    if (overlapped_io_active(&tt->writes))
> -    {
> -        status = tun_finalize(tt->hand, &tt->writes, NULL);
> -        if (status < 0)
> -        {
> -            err = GetLastError();
> -        }
> -    }
> -    tun_write_queue(tt, buf);
> -    if (status < 0)
> -    {
> -        SetLastError(err);
> -        return status;
> -    }
> -    else
> -    {
> -        return BLEN(buf);
> -    }
> -}
> -
> -static inline int
> -read_tun_buffered(struct tuntap *tt, struct buffer *buf)
> -{
> -    return tun_finalize(tt->hand, &tt->reads, buf);
> -}
> +int
> +tun_write_win32(struct tuntap *tt, struct buffer *buf);
>

Antonio wanted this to be in one line though we are not terribly consistent
about this.


>  static inline ULONG
>  wintun_ring_packet_align(ULONG size)
>

In spite of those nits meant to annoy the author, I think this looks good.

Acked-by: Selva Nair <selva.nair@...277...>

--00000000000041acf805d60f2233
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 17, 2022 at 4:51 AM Le=
v Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lst=
ipakov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." tar=
get=3D"_blank">lev@...515...</a>&gt;<br>
<br>
tun_finalize() is essentially subset of socket_finalize() apart from:<br>
<br>
=C2=A0- using WSAFoo() functions instead of Foo()<br>
<br>
=C2=A0- &quot;from&quot; address is not returned<br>
<br>
There is no clear official statement that one can use non-WSA<br>
API on handles, so let&#39;s be on a safe side and use both.<br>
<br>
Introduce sockethandle_t abstraction, which represents<br>
socket and handle. Add SocketHandle* routines which call<br>
proper API depends on underlying type in abstraction.<br>
<br>
Rename socket_finalize() to sockethandle_finalize(), take<br>
sockethandle_t and new routines into use and kick tun_finalize().<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v3: replace macros with inline functions<br>
<br>
=C2=A0v2: explicitly initialize .is_handle to false for readablity <br>
<br>
<br>
=C2=A0src/openvpn/forward.c |=C2=A0 3 +-<br>
=C2=A0src/openvpn/socket.c=C2=A0 | 37 ++++++++---------<br>
=C2=A0src/openvpn/socket.h=C2=A0 | 49 ++++++++++++++++++----<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0| 94 +++++++++------------------=
----------------<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0| 34 +---------------<br>
=C2=A05 files changed, 80 insertions(+), 137 deletions(-)<br>
<br>
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<br>
index f82386a1..a905f993 100644<br>
--- a/src/openvpn/forward.c<br>
+++ b/src/openvpn/forward.c<br>
@@ -1115,7 +1115,8 @@ read_incoming_tun(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_tun_buffered(c-&gt;c1.tuntap, &amp;c-&gt;=
c2.buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sockethandle_t sh =3D { .is_handle =3D true, .=
h =3D c-&gt;c1.tuntap-&gt;hand };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sockethandle_finalize(sh, &amp;c-&gt;c1.tuntap=
-&gt;reads, &amp;c-&gt;c2.buf, NULL);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else=C2=A0 /* ifdef _WIN32 */<br>
=C2=A0 =C2=A0 =C2=A0ASSERT(buf_init(&amp;c-&gt;c2.buf, FRAME_HEADROOM(&amp;=
c-&gt;c2.frame)));<br>
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c<br>
index df736746..780c5cb3 100644<br>
--- a/src/openvpn/socket.c<br>
+++ b/src/openvpn/socket.c<br>
@@ -3198,7 +3198,8 @@ link_socket_read_tcp(struct link_socket *sock,<br>
=C2=A0 =C2=A0 =C2=A0if (!sock-&gt;stream_buf.residual_fully_formed)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0#ifdef _WIN32<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D socket_finalize(sock-&gt;sd, &amp;sock=
-&gt;reads, buf, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sockethandle_t sh =3D { .s =3D sock-&gt;sd };<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D sockethandle_finalize(sh, &amp;sock-&g=
t;reads, buf, NULL);<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct buffer frag;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stream_buf_get_next(&amp;sock-&gt;stream_=
buf, &amp;frag);<br>
@@ -3664,10 +3665,10 @@ socket_send_queue(struct link_socket *sock, struct =
buffer *buf, const struct lin<br>
=C2=A0}<br>
<br>
=C2=A0int<br>
-socket_finalize(SOCKET s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct overlapped_=
io *io,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer *buf=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct link_socket=
_actual *from)<br>
+sockethandle_finalize(sockethandle_t sh,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct overlapped_io *io,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct buffer *buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct link_socket_actual *from)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0BOOL status;<br>
@@ -3675,13 +3676,7 @@ socket_finalize(SOCKET s,<br>
=C2=A0 =C2=A0 =C2=A0switch (io-&gt;iostate)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IOSTATE_QUEUED:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D WSAGetOverlappedResul=
t(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;io-&gt;overla=
pped,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;io-&gt;size,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FALSE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;io-&gt;flags<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D SocketHandleGetOverla=
ppedResult(sh, io);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* successful=
 return for a queued operation */<br>
@@ -3693,18 +3688,18 @@ socket_finalize(SOCKET s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0io-&gt;iostat=
e =3D IOSTATE_INITIAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(ResetE=
vent(io-&gt;overlapped.hEvent));<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &=
quot;WIN32 I/O: Socket Completion success [%d]&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &=
quot;WIN32 I/O: Completion success [%d]&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error duri=
ng a queued operation */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (WSAGetLastErro=
r() !=3D WSA_IO_INCOMPLETE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (SocketHandleGe=
tLastError(sh) !=3D ERROR_IO_INCOMPLETE)<br></blockquote><div><br></div><di=
v>WSA_IO_INCOMPLETE is the same as ERROR_IO_INCOMPLETE, so using them</div>=
<div>interchangeably looks ok.=C2=A0<br></div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* if no error (i.e. just not finished yet), then DON&#39;T execute this=
 code */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0io-&gt;iostate =3D IOSTATE_INITIAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ASSERT(ResetEvent(io-&gt;overlapped.hEvent));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
D_WIN32_IO | M_ERRNO, &quot;WIN32 I/O: Socket Completion error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
D_WIN32_IO | M_ERRNO, &quot;WIN32 I/O: Completion error&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -3715,9 +3710,9 @@ socket_finalize(SOCKET s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (io-&gt;status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error retu=
rn for a non-queued operation */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WSASetLastError(io=
-&gt;status);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SocketHandleSetLas=
tError(sh, io-&gt;status);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_WIN32_IO | M=
_ERRNO, &quot;WIN32 I/O: Socket Completion non-queued error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_WIN32_IO | M=
_ERRNO, &quot;WIN32 I/O: Completion non-queued error&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -3727,14 +3722,14 @@ socket_finalize(SOCKET s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*buf =3D io-&gt;buf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D io-&g=
t;size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &=
quot;WIN32 I/O: Socket Completion non-queued success [%d]&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &=
quot;WIN32 I/O: Completion non-queued success [%d]&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IOSTATE_INITIAL: /* were we called w=
ithout proper queueing? */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WSASetLastError(WSAEINVAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SocketHandleSetInvalError(sh);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &quot;WIN32 I/O=
: Socket Completion BAD STATE&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &quot;WIN32 I/O=
: Completion BAD STATE&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
@@ -3742,7 +3737,7 @@ socket_finalize(SOCKET s,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* return from address if requested */<br>
-=C2=A0 =C2=A0 if (from)<br>
+=C2=A0 =C2=A0 if (!sh.is_handle &amp;&amp; from)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &gt;=3D 0 &amp;&amp; io-&gt;addr_=
defined)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h<br>
index cc1e0c36..77c3d720 100644<br>
--- a/src/openvpn/socket.h<br>
+++ b/src/openvpn/socket.h<br>
@@ -262,11 +262,44 @@ int socket_send_queue(struct link_socket *sock,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct buffer *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct link_socket_actual *to);<br>
<br>
-int socket_finalize(<br>
-=C2=A0 =C2=A0 SOCKET s,<br>
-=C2=A0 =C2=A0 struct overlapped_io *io,<br>
-=C2=A0 =C2=A0 struct buffer *buf,<br>
-=C2=A0 =C2=A0 struct link_socket_actual *from);<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SOCKET s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HANDLE h;<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 bool is_handle;<br>
+} sockethandle_t;<br>
+<br>
+int sockethandle_finalize(sockethandle_t sh,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct overlapped_io *io,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct buffer *buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct link_socket_actual *from);<br>
+<br>
+static inline BOOL<br>
+SocketHandleGetOverlappedResult(sockethandle_t sh, struct overlapped_io *i=
o)<br>
+{<br>
+=C2=A0 =C2=A0 return sh.is_handle ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GetOverlappedResult(sh.h, &amp;io-&gt;overlapp=
ed, &amp;io-&gt;size, FALSE) :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WSAGetOverlappedResult(sh.s, &amp;io-&gt;overl=
apped, &amp;io-&gt;size, FALSE, &amp;io-&gt;flags);<br>
+}<br>
+<br>
+static inline int<br>
+SocketHandleGetLastError(sockethandle_t sh)<br>
+{<br>
+=C2=A0 =C2=A0 return sh.is_handle ? (int)GetLastError() : WSAGetLastError(=
);<br>
+}<br>
+<br>
+inline static void<br>
+SocketHandleSetLastError(sockethandle_t sh, DWORD err)<br>
+{<br>
+=C2=A0 =C2=A0 sh.is_handle ? SetLastError(err) : WSASetLastError(err);<br>=
</blockquote><div><br></div><div>To be consistent, one could add an explici=
t cast here too and avoid a potential compiler warning:</div><div><br></div=
><div>WSASetLastError((int) err);=C2=A0</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static inline void<br>
+SocketHandleSetInvalError(sockethandle_t sh)<br>
+{<br>
+=C2=A0 =C2=A0 sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) : WSASet=
LastError(WSAEINVAL);<br>
+}<br></blockquote><div><br></div><div>I&#39;m not sure whether ERROR_INVAL=
ID_FUNCTION is the appropriate error code here. WSAEINVAL is more like inva=
lid-argument (so ERROR_BAD_ARGUMENTS?). But this agrees with the original, =
so let it be.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
=C2=A0#else=C2=A0 /* ifdef _WIN32 */<br>
<br>
@@ -1020,7 +1053,8 @@ link_socket_read_udp_win32(struct link_socket *sock,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct link_socket_actual *from)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return socket_finalize(sock-&gt;sd, &amp;sock-&gt;reads, buf=
, from);<br>
+=C2=A0 =C2=A0 sockethandle_t sh =3D { .s =3D sock-&gt;sd };<br>
+=C2=A0 =C2=A0 return sockethandle_finalize(sh, &amp;sock-&gt;reads, buf, f=
rom);<br>
=C2=A0}<br>
<br>
=C2=A0#else=C2=A0 /* ifdef _WIN32 */<br>
@@ -1078,9 +1112,10 @@ link_socket_write_win32(struct link_socket *sock,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int status =3D 0;<br>
+=C2=A0 =C2=A0 sockethandle_t sh =3D { .s =3D sock-&gt;sd };<br>
=C2=A0 =C2=A0 =C2=A0if (overlapped_io_active(&amp;sock-&gt;writes))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D socket_finalize(sock-&gt;sd, &amp;s=
ock-&gt;writes, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D sockethandle_finalize(sh, &amp;sock=
-&gt;writes, NULL, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D WSAGetLastError();<=
br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 12bdd200..fe32127b 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -3561,87 +3561,29 @@ tun_write_queue(struct tuntap *tt, struct buffer *b=
uf)<br>
=C2=A0}<br>
<br>
=C2=A0int<br>
-tun_finalize(<br>
-=C2=A0 =C2=A0 HANDLE h,<br>
-=C2=A0 =C2=A0 struct overlapped_io *io,<br>
-=C2=A0 =C2=A0 struct buffer *buf)<br>
+tun_write_win32(struct tuntap *tt, struct buffer *buf)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int ret =3D -1;<br>
-=C2=A0 =C2=A0 BOOL status;<br>
-<br>
-=C2=A0 =C2=A0 switch (io-&gt;iostate)<br>
+=C2=A0 =C2=A0 int err =3D 0;<br>
+=C2=A0 =C2=A0 int status =3D 0;<br>
+=C2=A0 =C2=A0 if (overlapped_io_active(&amp;tt-&gt;writes))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IOSTATE_QUEUED:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D GetOverlappedResult(<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;io-&gt;overla=
pped,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;io-&gt;size,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FALSE<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* successful retu=
rn for a queued operation */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *buf=
 =3D io-&gt;buf;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D io-&gt;siz=
e;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 io-&gt;iostate =3D=
 IOSTATE_INITIAL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(ResetEvent(=
io-&gt;overlapped.hEvent));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &=
quot;WIN32 I/O: TAP Completion success [%d]&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error during a =
queued operation */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetLastError()=
 !=3D ERROR_IO_INCOMPLETE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* i=
f no error (i.e. just not finished yet),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* then DON&#39;T execute this code */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 io-&=
gt;iostate =3D IOSTATE_INITIAL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSE=
RT(ResetEvent(io-&gt;overlapped.hEvent));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
D_WIN32_IO | M_ERRNO, &quot;WIN32 I/O: TAP Completion error&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IOSTATE_IMMEDIATE_RETURN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 io-&gt;iostate =3D IOSTATE_INITI=
AL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(ResetEvent(io-&gt;overlap=
ped.hEvent));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (io-&gt;status)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error return fo=
r a non-queued operation */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SetLastError(io-&g=
t;status);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_WIN32_IO | M=
_ERRNO, &quot;WIN32 I/O: TAP Completion non-queued error&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* successful retu=
rn for a non-queued operation */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *buf=
 =3D io-&gt;buf;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D io-&gt;siz=
e;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &=
quot;WIN32 I/O: TAP Completion non-queued success [%d]&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IOSTATE_INITIAL: /* were we called withou=
t proper queueing? */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SetLastError(ERROR_INVALID_FUNCT=
ION);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_WIN32_IO, &quot;WIN32 I/O=
: TAP Completion BAD STATE&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sockethandle_t sh =3D { .is_handle =3D true, .=
h =3D tt-&gt;hand };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D sockethandle_finalize(sh, &amp;tt-&=
gt;writes, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D GetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 if (buf)<br>
+=C2=A0 =C2=A0 tun_write_queue(tt, buf);<br>
+=C2=A0 =C2=A0 if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf-&gt;len =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetLastError(err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return status;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return BLEN(buf);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static const struct device_instance_id_interface *<br>
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<br>
index d4657537..a6661be0 100644<br>
--- a/src/openvpn/tun.h<br>
+++ b/src/openvpn/tun.h<br>
@@ -437,8 +437,6 @@ int tun_read_queue(struct tuntap *tt, int maxsize);<br>
<br>
=C2=A0int tun_write_queue(struct tuntap *tt, struct buffer *buf);<br>
<br>
-int tun_finalize(HANDLE h, struct overlapped_io *io, struct buffer *buf);<=
br>
-<br>
=C2=A0static inline bool<br>
=C2=A0tuntap_stop(int status)<br>
=C2=A0{<br>
@@ -466,36 +464,8 @@ tuntap_abort(int status)<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
<br>
-static inline int<br>
-tun_write_win32(struct tuntap *tt, struct buffer *buf)<br>
-{<br>
-=C2=A0 =C2=A0 int err =3D 0;<br>
-=C2=A0 =C2=A0 int status =3D 0;<br>
-=C2=A0 =C2=A0 if (overlapped_io_active(&amp;tt-&gt;writes))<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D tun_finalize(tt-&gt;hand, &amp;tt-&=
gt;writes, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status &lt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 tun_write_queue(tt, buf);<br>
-=C2=A0 =C2=A0 if (status &lt; 0)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetLastError(err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return status;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return BLEN(buf);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-static inline int<br>
-read_tun_buffered(struct tuntap *tt, struct buffer *buf)<br>
-{<br>
-=C2=A0 =C2=A0 return tun_finalize(tt-&gt;hand, &amp;tt-&gt;reads, buf);<br>
-}<br>
+int<br>
+tun_write_win32(struct tuntap *tt, struct buffer *buf);<br></blockquote><d=
iv><br></div><div>Antonio wanted this to be in one line though we are not t=
erribly consistent about this.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
=C2=A0static inline ULONG<br>
=C2=A0wintun_ring_packet_align(ULONG size)<br></blockquote><div><br></div><=
div>In spite of those nits meant to annoy the author, I think this looks go=
od.</div><div><br></div><div>Acked-by: Selva Nair &lt;<a href=3D"mailto:sel=
va.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</div></di=
v></div></div>

--00000000000041acf805d60f2233--

