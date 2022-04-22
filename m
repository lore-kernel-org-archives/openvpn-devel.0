MIME-Version: 1.0
References: <20220222031424.406-1-lstipakov@...277...>
In-Reply-To: <20220222031424.406-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Apr 2022 11:17:10 -0400
Message-ID: <CAKuzo_h7XVDPk=G4toRDczLBy1GjsLbK7MpKXWxr5KJmONOUUw@...278...>
Content-Type: multipart/alternative; boundary="0000000000005c94ce05dd3fb972"
Subject: Re: [Openvpn-devel] [PATCH] Fix M_ERRNO behavior on Windows
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

--0000000000005c94ce05dd3fb972
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry for the long delay in getting back to this..

On Tue, Feb 22, 2022 at 9:13 AM Lev Stipakov <lstipakov@...277...> wrote:

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
>
> While on it, add a new flag M_SKERR to display socket
> error. On Linux it is resolved into M_ERRNO and on Windows
> to an conjunction of another new flag M_WSAERR and M_ERRNO.
> With M_WSAERR we use WSAGetLastError() to get error code
> and strerror_win32() to get error description.
> WSAGetLastError() is a correct way to get WinSock error code,
> according to documentation.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/error.c    | 26 ++++++++++++++++++++++----
>  src/openvpn/error.h    | 11 ++++++++++-
>  src/openvpn/manage.c   |  4 ++--
>  src/openvpn/mtu.c      |  2 +-
>  src/openvpn/platform.c |  2 +-
>  src/openvpn/proxy.c    |  8 ++++----
>  src/openvpn/ps.c       |  2 +-
>  src/openvpn/socket.c   | 20 ++++++++++----------
>  src/openvpn/socket.h   |  6 ++++++
>  src/openvpn/socks.c    | 26 +++++++++++++-------------
>  10 files changed, 70 insertions(+), 37 deletions(-)
>
> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index b0e9a48c..5da588d9 100644
> --- a/src/openvpn/error.c
> +++ b/src/openvpn/error.c
> @@ -242,7 +242,25 @@ x_msg_va(const unsigned int flags, const char
> *format, va_list arglist)
>          return;
>      }
>
> -    e = openvpn_errno();
> +    bool use_strerr = false;
> +#ifdef _WIN32
> +    if (flags & M_WSAERR)
> +    {
> +        e = WSAGetLastError();
> +    }
> +    else
> +    {
> +        e = GetLastError();
> +        if (e == ERROR_SUCCESS)
> +        {
> +            /* error is likely C runtime, fallback to errno/strerr */
> +            use_strerr = true;
> +            e = errno;
> +        }
> +    }
> +#else
> +    e = errno;
> +#endif
>
>
Ideally I would have liked to modify openvpn_errno() and
openvpn_strerror()  to do the right thing instead of adding this logic here
and below. I have not worked out what exactly that would entail --  most
likely those two functions would require an extra argument to keep track of
the kind of error.

Also there are some places openvpn_errno() is used and the result checked
against POSIX error codes:
in forward.c around line 2102:

if (.... && ENETUNREACH == error_code && ...)

where error_code = openvpn_errno() which may return WSAENETUNREACH on
Windows not ENETUNREACH-- even that depends on GetLastError() and
WSAGetLastError() to behave identically.

Also does code like the below in socket.c do the right thing?
(around line 1451 in socket.c)
status = openvpn_errno();
if (status == WSAEWOULDBLOCK) ....
but openvpn_errono() doesn't look for WSA errors (though it probably still
works?).

     /*
>       * Apply muting filter.
> @@ -264,7 +282,7 @@ x_msg_va(const unsigned int flags, const char *format,
> va_list arglist)
>      if ((flags & M_ERRNO) && e)
>      {
>          openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
> -                         m1, strerror(e), e);
> +                         m1, use_strerr ? strerror(e) :
> openvpn_strerror(e, &gc), e);
>          SWAP;
>      }
>
> @@ -678,13 +696,13 @@ x_check_status(int status,
>              {
>                  msg(x_cs_info_level, "%s %s [%s]: %s (fd=%d,code=%d)",
> description,
>                      sock ? proto2ascii(sock->info.proto, sock->info.af,
> true) : "",
> -                    extended_msg, strerror(my_errno), sock ? sock->sd :
> -1, my_errno);
> +                    extended_msg, openvpn_strerror(my_errno, &gc), sock ?
> sock->sd : -1, my_errno);
>

Here my_errno = openvpn_errno() -- don't we need the fallback to POSIX
errno in this case? Could this also get called when a socket error is
expected?


>              }
>              else
>              {
>                  msg(x_cs_info_level, "%s %s: %s (fd=%d,code=%d)",
> description,
>                      sock ? proto2ascii(sock->info.proto, sock->info.af,
> true) : "",
> -                    strerror(my_errno), sock ? sock->sd : -1, my_errno);
> +                    openvpn_strerror(my_errno, &gc), sock ? sock->sd :
> -1, my_errno);
>              }
>
>              if (x_cs_err_delay_ms)
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index ad7defe8..9c3f4dfb 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -99,9 +99,18 @@ extern int x_msg_line_num;
>  #define M_NONFATAL        (1<<5)         /* non-fatal error */
>  #define M_WARN            (1<<6)         /* call syslog with LOG_WARNING
> */
>  #define M_DEBUG           (1<<7)
> -
>  #define M_ERRNO           (1<<8)         /* show errno description */
>
> +#ifdef _WIN32
> +#define M_WSAERR          (1<<9)         /* WinSock errors */
> +#endif
> +
> +#ifdef _WIN32
> +#define M_SKERR           (M_ERRNO | M_WSAERR) /* socket errors */
> +#else
> +#define M_SKERR           M_ERRNO
> +#endif
>

The two ifdefs could be combined into one.

The rest looks good to me.


> +
>  #define M_NOMUTE          (1<<11)        /* don't do mute processing */
>  #define M_NOPREFIX        (1<<12)        /* don't show date/time prefix */
>  #define M_USAGE_SMALL     (1<<13)        /* fatal options error, call
> usage_small */
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 496042a6..2fa508ef 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -1890,13 +1890,13 @@ man_connect(struct management *man)
>  #if UNIX_SOCK_SUPPORT
>          if (man->settings.flags & MF_UNIX_SOCK)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO,
> +            msg(D_LINK_ERRORS | M_SKERR,
>                  "MANAGEMENT: connect to unix socket %s failed",
>                  sockaddr_unix_name(&man->settings.local_unix, "NULL"));
>          }
>          else
>  #endif
> -        msg(D_LINK_ERRORS | M_ERRNO,
> +        msg(D_LINK_ERRORS | M_SKERR,
>              "MANAGEMENT: connect to %s failed",
>              print_sockaddr(man->settings.local->ai_addr, &gc));
>          throw_signal_soft(SIGTERM, "management-connect-failed");
> diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
> index aa810f1c..45398953 100644
> --- a/src/openvpn/mtu.c
> +++ b/src/openvpn/mtu.c
> @@ -407,7 +407,7 @@ set_sock_extended_error_passing(int sd)
>      int on = 1;
>      if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *) &on, sizeof(on)))
>      {
> -        msg(M_WARN | M_ERRNO,
> +        msg(M_WARN | M_SKERR,
>              "Note: enable extended error passing on TCP/UDP socket failed
> (IP_RECVERR)");
>      }
>  }
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index 450f28ba..1aafd604 100644
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
> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index ed720161..409bc4af 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -110,7 +110,7 @@ recv_line(socket_descriptor_t sd,
>          {
>              if (verbose)
>              {
> -                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read
> timeout expired");
> +                msg(D_LINK_ERRORS | M_SKERR, "recv_line: TCP port read
> timeout expired");
>              }
>              goto error;
>          }
> @@ -120,7 +120,7 @@ recv_line(socket_descriptor_t sd,
>          {
>              if (verbose)
>              {
> -                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read
> failed on select()");
> +                msg(D_LINK_ERRORS | M_SKERR, "recv_line: TCP port read
> failed on select()");
>              }
>              goto error;
>          }
> @@ -133,7 +133,7 @@ recv_line(socket_descriptor_t sd,
>          {
>              if (verbose)
>              {
> -                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read
> failed on recv()");
> +                msg(D_LINK_ERRORS | M_SKERR, "recv_line: TCP port read
> failed on recv()");
>              }
>              goto error;
>          }
> @@ -199,7 +199,7 @@ send_line(socket_descriptor_t sd,
>      const ssize_t size = send(sd, buf, strlen(buf), MSG_NOSIGNAL);
>      if (size != (ssize_t) strlen(buf))
>      {
> -        msg(D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed on
> send()");
> +        msg(D_LINK_ERRORS | M_SKERR, "send_line: TCP port write failed on
> send()");
>          return false;
>      }
>      return true;
> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
> index 9dca53c8..64cc1ed3 100644
> --- a/src/openvpn/ps.c
> +++ b/src/openvpn/ps.c
> @@ -429,7 +429,7 @@ proxy_entry_new(struct proxy_connection **list,
>      /* connect to port share server */
>      if ((sd_server = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
>      {
> -        msg(M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
> +        msg(M_WARN|M_SKERR, "PORT SHARE PROXY: cannot create socket");
>          return false;
>      }
>      status = openvpn_connect(sd_server,(const struct sockaddr *)
> &server_addr, 5, NULL);
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 0f34a5de..acfcfd65 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1143,7 +1143,7 @@ create_socket(struct link_socket *sock, struct
> addrinfo *addr)
>          msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
>          if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE,
> sock->bind_dev, strlen(sock->bind_dev) + 1) != 0)
>          {
> -            msg(M_WARN|M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s
> failed", sock->bind_dev);
> +            msg(M_WARN|M_SKERR, "WARN: setsockopt SO_BINDTODEVICE=%s
> failed", sock->bind_dev);
>          }
>
>      }
> @@ -1222,7 +1222,7 @@ socket_do_accept(socket_descriptor_t sd,
>
>          if (!socket_defined(new_sd))
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "TCP: getpeername() failed");
> +            msg(D_LINK_ERRORS | M_SKERR, "TCP: getpeername() failed");
>          }
>          else
>          {
> @@ -1247,7 +1247,7 @@ socket_do_accept(socket_descriptor_t sd,
>
>      if (!socket_defined(new_sd))
>      {
> -        msg(D_LINK_ERRORS | M_ERRNO, "TCP: accept(%d) failed", (int)sd);
> +        msg(D_LINK_ERRORS | M_SKERR, "TCP: accept(%d) failed", (int)sd);
>      }
>      /* only valid if we have remote_len_af!=0 */
>      else if (remote_len_af && remote_len != remote_len_af)
> @@ -1313,7 +1313,7 @@ socket_listen_accept(socket_descriptor_t sd,
>
>          if (status < 0)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "TCP: select() failed");
> +            msg(D_LINK_ERRORS | M_SKERR, "TCP: select() failed");
>          }
>
>          if (status <= 0)
> @@ -1409,12 +1409,12 @@ socket_bind(socket_descriptor_t sd,
>          msg(M_INFO, "setsockopt(IPV6_V6ONLY=%d)", v6only);
>          if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, (void *) &v6only,
> sizeof(v6only)))
>          {
> -            msg(M_NONFATAL|M_ERRNO, "Setting IPV6_V6ONLY=%d failed",
> v6only);
> +            msg(M_NONFATAL | M_SKERR, "Setting IPV6_V6ONLY=%d failed",
> v6only);
>          }
>      }
>      if (bind(sd, cur->ai_addr, cur->ai_addrlen))
>      {
> -        msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address
> %s",
> +        msg(M_FATAL | M_SKERR, "%s: Socket bind failed on local address
> %s",
>              prefix,
>              print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
>      }
> @@ -2254,7 +2254,7 @@ link_socket_close(struct link_socket *sock)
>                  msg(D_LOW, "TCP/UDP: Closing socket");
>                  if (openvpn_close_socket(sock->sd))
>                  {
> -                    msg(M_WARN | M_ERRNO, "TCP/UDP: Close Socket failed");
> +                    msg(M_WARN | M_SKERR, "TCP/UDP: Close Socket failed");
>                  }
>              }
>              sock->sd = SOCKET_UNDEFINED;
> @@ -2271,7 +2271,7 @@ link_socket_close(struct link_socket *sock)
>          {
>              if (openvpn_close_socket(sock->ctrl_sd))
>              {
> -                msg(M_WARN | M_ERRNO, "TCP/UDP: Close Socket (ctrl_sd)
> failed");
> +                msg(M_WARN | M_SKERR, "TCP/UDP: Close Socket (ctrl_sd)
> failed");
>              }
>              sock->ctrl_sd = SOCKET_UNDEFINED;
>          }
> @@ -3668,7 +3668,7 @@ sockethandle_finalize(sockethandle_t sh,
>                      /* if no error (i.e. just not finished yet), then
> DON'T execute this code */
>                      io->iostate = IOSTATE_INITIAL;
>                      ASSERT(ResetEvent(io->overlapped.hEvent));
> -                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion
> error");
> +                    msg(D_WIN32_IO | SocketHandleErrorFlag(sh), "WIN32
> I/O: Completion error");
>                  }
>              }
>              break;
> @@ -3681,7 +3681,7 @@ sockethandle_finalize(sockethandle_t sh,
>                  /* error return for a non-queued operation */
>                  SocketHandleSetLastError(sh, io->status);
>                  ret = -1;
> -                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion
> non-queued error");
> +                msg(D_WIN32_IO | SocketHandleErrorFlag(sh), "WIN32 I/O:
> Completion non-queued error");
>              }
>              else
>              {
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index e9f1524d..a7ec827a 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -301,6 +301,12 @@ SocketHandleSetInvalError(sockethandle_t sh)
>      sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) :
> WSASetLastError(WSAEINVAL);
>  }
>
> +static inline int
> +SocketHandleErrorFlag(sockethandle_t sh)
> +{
> +    return sh.is_handle ? M_ERRNO : M_SKERR;
> +}
> +
>  #else  /* ifdef _WIN32 */
>
>  #define openvpn_close_socket(s) close(s)
> diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
> index 768bb613..10107c18 100644
> --- a/src/openvpn/socks.c
> +++ b/src/openvpn/socks.c
> @@ -117,7 +117,7 @@ socks_username_password_auth(struct socks_proxy_info
> *p,
>
>      if (size != strlen(to_send))
>      {
> -        msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP
> port write failed on send()");
> +        msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth: TCP
> port write failed on send()");
>          goto cleanup;
>      }
>
> @@ -145,14 +145,14 @@ socks_username_password_auth(struct socks_proxy_info
> *p,
>          /* timeout? */
>          if (status == 0)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth:
> TCP port read timeout expired");
> +            msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth:
> TCP port read timeout expired");
>              goto cleanup;
>          }
>
>          /* error */
>          if (status < 0)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth:
> TCP port read failed on select()");
> +            msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth:
> TCP port read failed on select()");
>              goto cleanup;
>          }
>
> @@ -162,7 +162,7 @@ socks_username_password_auth(struct socks_proxy_info
> *p,
>          /* error? */
>          if (size != 1)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth:
> TCP port read failed on recv()");
> +            msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth:
> TCP port read failed on recv()");
>              goto cleanup;
>          }
>
> @@ -204,7 +204,7 @@ socks_handshake(struct socks_proxy_info *p,
>      size = send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL);
>      if (size != sizeof(method_sel))
>      {
> -        msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write
> failed on send()");
> +        msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port write
> failed on send()");
>          return false;
>      }
>
> @@ -232,14 +232,14 @@ socks_handshake(struct socks_proxy_info *p,
>          /* timeout? */
>          if (status == 0)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read
> timeout expired");
> +            msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port read
> timeout expired");
>              return false;
>          }
>
>          /* error */
>          if (status < 0)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read
> failed on select()");
> +            msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port read
> failed on select()");
>              return false;
>          }
>
> @@ -249,7 +249,7 @@ socks_handshake(struct socks_proxy_info *p,
>          /* error? */
>          if (size != 1)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read
> failed on recv()");
> +            msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port read
> failed on recv()");
>              return false;
>          }
>
> @@ -342,14 +342,14 @@ recv_socks_reply(socket_descriptor_t sd,
>          /* timeout? */
>          if (status == 0)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read
> timeout expired");
> +            msg(D_LINK_ERRORS | M_SKERR, "recv_socks_reply: TCP port read
> timeout expired");
>              return false;
>          }
>
>          /* error */
>          if (status < 0)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read
> failed on select()");
> +            msg(D_LINK_ERRORS | M_SKERR, "recv_socks_reply: TCP port read
> failed on select()");
>              return false;
>          }
>
> @@ -359,7 +359,7 @@ recv_socks_reply(socket_descriptor_t sd,
>          /* error? */
>          if (size != 1)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read
> failed on recv()");
> +            msg(D_LINK_ERRORS | M_SKERR, "recv_socks_reply: TCP port read
> failed on recv()");
>              return false;
>          }
>
> @@ -484,7 +484,7 @@ establish_socks_proxy_passthru(struct socks_proxy_info
> *p,
>          const ssize_t size = send(sd, buf, 5 + len + 2, MSG_NOSIGNAL);
>          if ((int)size != 5 + (int)len + 2)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "establish_socks_proxy_passthru:
> TCP port write failed on send()");
> +            msg(D_LINK_ERRORS | M_SKERR, "establish_socks_proxy_passthru:
> TCP port write failed on send()");
>              goto error;
>          }
>      }
> @@ -527,7 +527,7 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info
> *p,
>                                    10, MSG_NOSIGNAL);
>          if (size != 10)
>          {
> -            msg(D_LINK_ERRORS | M_ERRNO, "establish_socks_proxy_passthru:
> TCP port write failed on send()");
> +            msg(D_LINK_ERRORS | M_SKERR, "establish_socks_proxy_passthru:
> TCP port write failed on send()");
>              goto error;
>          }
>      }
> --
>

All that said, it may be hard to get all error reporting fixed in one
patch, so we could proceed in steps. First make openvpn_errno() and
openvpn_strerror() do the right thing with GetLastError() vs errno, then
fix WSA error printing, then the rest if any. Just a thought.

Selva

--0000000000005c94ce05dd3fb972
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Sorry for the long delay=
 in getting back to this..=C2=A0</div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 22, 2022 at 9:13 AM Lev Stipako=
v &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...1186...=
.277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_b=
lank">lev@...515...</a>&gt;<br>
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
<br>
While on it, add a new flag M_SKERR to display socket<br>
error. On Linux it is resolved into M_ERRNO and on Windows<br>
to an conjunction of another new flag M_WSAERR and M_ERRNO.<br>
With M_WSAERR we use WSAGetLastError() to get error code<br>
and strerror_win32() to get error description.<br>
WSAGetLastError() is a correct way to get WinSock error code,<br>
according to documentation.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/error.c=C2=A0 =C2=A0 | 26 ++++++++++++++++++++++----<br>
=C2=A0src/openvpn/error.h=C2=A0 =C2=A0 | 11 ++++++++++-<br>
=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0src/openvpn/mtu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0src/openvpn/platform.c |=C2=A0 2 +-<br>
=C2=A0src/openvpn/proxy.c=C2=A0 =C2=A0 |=C2=A0 8 ++++----<br>
=C2=A0src/openvpn/ps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0src/openvpn/socket.c=C2=A0 =C2=A0| 20 ++++++++++----------<br>
=C2=A0src/openvpn/socket.h=C2=A0 =C2=A0|=C2=A0 6 ++++++<br>
=C2=A0src/openvpn/socks.c=C2=A0 =C2=A0 | 26 +++++++++++++-------------<br>
=C2=A010 files changed, 70 insertions(+), 37 deletions(-)<br>
<br>
diff --git a/src/openvpn/error.c b/src/openvpn/error.c<br>
index b0e9a48c..5da588d9 100644<br>
--- a/src/openvpn/error.c<br>
+++ b/src/openvpn/error.c<br>
@@ -242,7 +242,25 @@ x_msg_va(const unsigned int flags, const char *format,=
 va_list arglist)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 e =3D openvpn_errno();<br>
+=C2=A0 =C2=A0 bool use_strerr =3D false;<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 if (flags &amp; M_WSAERR)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D WSAGetLastError();<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D GetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (e =3D=3D ERROR_SUCCESS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error is likely C runtime, fa=
llback to errno/strerr */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use_strerr =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+#else<br>
+=C2=A0 =C2=A0 e =3D errno;<br>
+#endif<br>
<br></blockquote><div><br></div><div>Ideally I would=C2=A0have liked to mod=
ify openvpn_errno() and openvpn_strerror()=C2=A0 to do the right thing inst=
ead of adding this logic here and below. I have not worked out what exactly=
=C2=A0that would entail --=C2=A0 most likely those two functions would requ=
ire an extra argument to keep track of the kind of error.</div><div><br></d=
iv><div>Also there are some places openvpn_errno() is used and the result c=
hecked against=C2=A0POSIX error codes:</div><div><div>in forward.c around l=
ine 2102:</div><div><br></div><div>if (.... &amp;&amp; ENETUNREACH =3D=3D e=
rror_code &amp;&amp; ...)</div><div><br></div><div>where error_code =3D ope=
nvpn_errno() which may=C2=A0return WSAENETUNREACH on Windows not ENETUNREAC=
H-- even that depends on GetLastError() and WSAGetLastError() to behave ide=
ntically.</div></div><div><br></div><div>Also does code like the below in s=
ocket.c do the right thing?</div><div>(around line 1451 in socket.c)</div><=
div>status =3D openvpn_errno();=C2=A0=C2=A0</div><div>if (status =3D=3D WSA=
EWOULDBLOCK) ....</div><div>but openvpn_errono() doesn&#39;t=C2=A0look for =
WSA errors (though it probably still works?).</div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Apply muting filter.<br>
@@ -264,7 +282,7 @@ x_msg_va(const unsigned int flags, const char *format, =
va_list arglist)<br>
=C2=A0 =C2=A0 =C2=A0if ((flags &amp; M_ERRNO) &amp;&amp; e)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_snprintf(m2, ERR_BUF_SIZE, &quot;=
%s: %s (errno=3D%d)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0m1, strerror(e), e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0m1, use_strerr ? strerror(e) : openvpn_strerror(e, &amp;gc=
), e);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SWAP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -678,13 +696,13 @@ x_check_status(int status,<br>
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
nded_msg, openvpn_strerror(my_errno, &amp;gc), sock ? sock-&gt;sd : -1, my_=
errno);<br></blockquote><div><br></div><div>Here my_errno =3D openvpn_errno=
() -- don&#39;t we need the fallback to POSIX errno in this case? Could thi=
s also get called when a socket error is expected?</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
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
vpn_strerror(my_errno, &amp;gc), sock ? sock-&gt;sd : -1, my_errno);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (x_cs_err_delay_ms)<br>
diff --git a/src/openvpn/error.h b/src/openvpn/error.h<br>
index ad7defe8..9c3f4dfb 100644<br>
--- a/src/openvpn/error.h<br>
+++ b/src/openvpn/error.h<br>
@@ -99,9 +99,18 @@ extern int x_msg_line_num;<br>
=C2=A0#define M_NONFATAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;5)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* non-fatal error */<br>
=C2=A0#define M_WARN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;6)=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* call syslog with LOG_WARNING */<br>
=C2=A0#define M_DEBUG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;7)<=
br>
-<br>
=C2=A0#define M_ERRNO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;8)=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* show errno description */<br>
<br>
+#ifdef _WIN32<br>
+#define M_WSAERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;9)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* WinSock errors */<br>
+#endif<br>
+<br>
+#ifdef _WIN32<br>
+#define M_SKERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(M_ERRNO | M_WSAER=
R) /* socket errors */<br>
+#else<br>
+#define M_SKERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0M_ERRNO<br>
+#endif<br></blockquote><div><br></div><div>The two ifdefs could be combine=
d into one.</div><div><br></div><div>The rest looks good to me.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#define M_NOMUTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;11)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* don&#39;t do mute processing */<br>
=C2=A0#define M_NOPREFIX=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;12)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* don&#39;t show date/time prefix */<br>
=C2=A0#define M_USAGE_SMALL=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;13)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* fatal options error, call usage_small */<br>
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c<br>
index 496042a6..2fa508ef 100644<br>
--- a/src/openvpn/manage.c<br>
+++ b/src/openvpn/manage.c<br>
@@ -1890,13 +1890,13 @@ man_connect(struct management *man)<br>
=C2=A0#if UNIX_SOCK_SUPPORT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (man-&gt;settings.flags &amp; MF_UNIX_=
SOCK)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;MANAGEM=
ENT: connect to unix socket %s failed&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sockaddr_unix=
_name(&amp;man-&gt;settings.local_unix, &quot;NULL&quot;));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;MANAGEMENT: connect t=
o %s failed&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_sockaddr(man-&gt;sett=
ings.local-&gt;ai_addr, &amp;gc));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throw_signal_soft(SIGTERM, &quot;manageme=
nt-connect-failed&quot;);<br>
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c<br>
index aa810f1c..45398953 100644<br>
--- a/src/openvpn/mtu.c<br>
+++ b/src/openvpn/mtu.c<br>
@@ -407,7 +407,7 @@ set_sock_extended_error_passing(int sd)<br>
=C2=A0 =C2=A0 =C2=A0int on =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *) &amp;on=
, sizeof(on)))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_ERRNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_SKERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Note: enable extended=
 error passing on TCP/UDP socket failed (IP_RECVERR)&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c<br>
index 450f28ba..1aafd604 100644<br>
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
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c<br>
index ed720161..409bc4af 100644<br>
--- a/src/openvpn/proxy.c<br>
+++ b/src/openvpn/proxy.c<br>
@@ -110,7 +110,7 @@ recv_line(socket_descriptor_t sd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (verbose)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS =
| M_ERRNO, &quot;recv_line: TCP port read timeout expired&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS =
| M_SKERR, &quot;recv_line: TCP port read timeout expired&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -120,7 +120,7 @@ recv_line(socket_descriptor_t sd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (verbose)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS =
| M_ERRNO, &quot;recv_line: TCP port read failed on select()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS =
| M_SKERR, &quot;recv_line: TCP port read failed on select()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -133,7 +133,7 @@ recv_line(socket_descriptor_t sd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (verbose)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS =
| M_ERRNO, &quot;recv_line: TCP port read failed on recv()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS =
| M_SKERR, &quot;recv_line: TCP port read failed on recv()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -199,7 +199,7 @@ send_line(socket_descriptor_t sd,<br>
=C2=A0 =C2=A0 =C2=A0const ssize_t size =3D send(sd, buf, strlen(buf), MSG_N=
OSIGNAL);<br>
=C2=A0 =C2=A0 =C2=A0if (size !=3D (ssize_t) strlen(buf))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &quot;send_line: =
TCP port write failed on send()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &quot;send_line: =
TCP port write failed on send()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c<br>
index 9dca53c8..64cc1ed3 100644<br>
--- a/src/openvpn/ps.c<br>
+++ b/src/openvpn/ps.c<br>
@@ -429,7 +429,7 @@ proxy_entry_new(struct proxy_connection **list,<br>
=C2=A0 =C2=A0 =C2=A0/* connect to port share server */<br>
=C2=A0 =C2=A0 =C2=A0if ((sd_server =3D socket(PF_INET, SOCK_STREAM, IPPROTO=
_TCP)) &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN|M_ERRNO, &quot;PORT SHARE PROXY: ca=
nnot create socket&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN|M_SKERR, &quot;PORT SHARE PROXY: ca=
nnot create socket&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0status =3D openvpn_connect(sd_server,(const struct sock=
addr *)=C2=A0 &amp;server_addr, 5, NULL);<br>
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c<br>
index 0f34a5de..acfcfd65 100644<br>
--- a/src/openvpn/socket.c<br>
+++ b/src/openvpn/socket.c<br>
@@ -1143,7 +1143,7 @@ create_socket(struct link_socket *sock, struct addrin=
fo *addr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_INFO, &quot;Using bind-dev %s&quot;=
, sock-&gt;bind_dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (setsockopt(sock-&gt;sd, SOL_SOCKET, S=
O_BINDTODEVICE, sock-&gt;bind_dev, strlen(sock-&gt;bind_dev) + 1) !=3D 0)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN|M_ERRNO, &quot;WARN: =
setsockopt SO_BINDTODEVICE=3D%s failed&quot;, sock-&gt;bind_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN|M_SKERR, &quot;WARN: =
setsockopt SO_BINDTODEVICE=3D%s failed&quot;, sock-&gt;bind_dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1222,7 +1222,7 @@ socket_do_accept(socket_descriptor_t sd,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!socket_defined(new_sd))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;TCP: getpeername() failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;TCP: getpeername() failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -1247,7 +1247,7 @@ socket_do_accept(socket_descriptor_t sd,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!socket_defined(new_sd))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &quot;TCP: accept=
(%d) failed&quot;, (int)sd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &quot;TCP: accept=
(%d) failed&quot;, (int)sd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0/* only valid if we have remote_len_af!=3D0 */<br>
=C2=A0 =C2=A0 =C2=A0else if (remote_len_af &amp;&amp; remote_len !=3D remot=
e_len_af)<br>
@@ -1313,7 +1313,7 @@ socket_listen_accept(socket_descriptor_t sd,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;TCP: select() failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;TCP: select() failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status &lt;=3D 0)<br>
@@ -1409,12 +1409,12 @@ socket_bind(socket_descriptor_t sd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_INFO, &quot;setsockopt(IPV6_V6ONLY=
=3D%d)&quot;, v6only);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6O=
NLY, (void *) &amp;v6only, sizeof(v6only)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL|M_ERRNO, &quot;Se=
tting IPV6_V6ONLY=3D%d failed&quot;, v6only);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL | M_SKERR, &quot;=
Setting IPV6_V6ONLY=3D%d failed&quot;, v6only);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (bind(sd, cur-&gt;ai_addr, cur-&gt;ai_addrlen))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind f=
ailed on local address %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL | M_SKERR, &quot;%s: Socket bind f=
ailed on local address %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_sockaddr_ex(local-&gt=
;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -2254,7 +2254,7 @@ link_socket_close(struct link_socket *sock)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_LOW, &q=
uot;TCP/UDP: Closing socket&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (openvpn_c=
lose_socket(sock-&gt;sd))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_WARN | M_ERRNO, &quot;TCP/UDP: Close Socket failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_WARN | M_SKERR, &quot;TCP/UDP: Close Socket failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sock-&gt;sd =3D SOCKET_UNDE=
FINED;<br>
@@ -2271,7 +2271,7 @@ link_socket_close(struct link_socket *sock)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (openvpn_close_socket(so=
ck-&gt;ctrl_sd))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_ERR=
NO, &quot;TCP/UDP: Close Socket (ctrl_sd) failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_SKE=
RR, &quot;TCP/UDP: Close Socket (ctrl_sd) failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sock-&gt;ctrl_sd =3D SOCKET=
_UNDEFINED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3668,7 +3668,7 @@ sockethandle_finalize(sockethandle_t sh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* if no error (i.e. just not finished yet), then DON&#39;T execute this=
 code */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0io-&gt;iostate =3D IOSTATE_INITIAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ASSERT(ResetEvent(io-&gt;overlapped.hEvent));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
D_WIN32_IO | M_ERRNO, &quot;WIN32 I/O: Completion error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
D_WIN32_IO | SocketHandleErrorFlag(sh), &quot;WIN32 I/O: Completion error&q=
uot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -3681,7 +3681,7 @@ sockethandle_finalize(sockethandle_t sh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error retu=
rn for a non-queued operation */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SocketHandleS=
etLastError(sh, io-&gt;status);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_WIN32_IO | M=
_ERRNO, &quot;WIN32 I/O: Completion non-queued error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_WIN32_IO | S=
ocketHandleErrorFlag(sh), &quot;WIN32 I/O: Completion non-queued error&quot=
;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h<br>
index e9f1524d..a7ec827a 100644<br>
--- a/src/openvpn/socket.h<br>
+++ b/src/openvpn/socket.h<br>
@@ -301,6 +301,12 @@ SocketHandleSetInvalError(sockethandle_t sh)<br>
=C2=A0 =C2=A0 =C2=A0sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) : W=
SASetLastError(WSAEINVAL);<br>
=C2=A0}<br>
<br>
+static inline int<br>
+SocketHandleErrorFlag(sockethandle_t sh)<br>
+{<br>
+=C2=A0 =C2=A0 return sh.is_handle ? M_ERRNO : M_SKERR;<br>
+}<br>
+<br>
=C2=A0#else=C2=A0 /* ifdef _WIN32 */<br>
<br>
=C2=A0#define openvpn_close_socket(s) close(s)<br>
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c<br>
index 768bb613..10107c18 100644<br>
--- a/src/openvpn/socks.c<br>
+++ b/src/openvpn/socks.c<br>
@@ -117,7 +117,7 @@ socks_username_password_auth(struct socks_proxy_info *p=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (size !=3D strlen(to_send))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &quot;socks_usern=
ame_password_auth: TCP port write failed on send()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &quot;socks_usern=
ame_password_auth: TCP port write failed on send()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -145,14 +145,14 @@ socks_username_password_auth(struct socks_proxy_info =
*p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* timeout? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;socks_username_password_auth: TCP port read timeout expired&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;socks_username_password_auth: TCP port read timeout expired&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;socks_username_password_auth: TCP port read failed on select()&quot;);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;socks_username_password_auth: TCP port read failed on select()&quot;);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -162,7 +162,7 @@ socks_username_password_auth(struct socks_proxy_info *p=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;socks_username_password_auth: TCP port read failed on recv()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;socks_username_password_auth: TCP port read failed on recv()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -204,7 +204,7 @@ socks_handshake(struct socks_proxy_info *p,<br>
=C2=A0 =C2=A0 =C2=A0size =3D send(sd, method_sel, sizeof(method_sel), MSG_N=
OSIGNAL);<br>
=C2=A0 =C2=A0 =C2=A0if (size !=3D sizeof(method_sel))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &quot;socks_hands=
hake: TCP port write failed on send()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &quot;socks_hands=
hake: TCP port write failed on send()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -232,14 +232,14 @@ socks_handshake(struct socks_proxy_info *p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* timeout? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;socks_handshake: TCP port read timeout expired&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;socks_handshake: TCP port read timeout expired&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;socks_handshake: TCP port read failed on select()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;socks_handshake: TCP port read failed on select()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -249,7 +249,7 @@ socks_handshake(struct socks_proxy_info *p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;socks_handshake: TCP port read failed on recv()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;socks_handshake: TCP port read failed on recv()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -342,14 +342,14 @@ recv_socks_reply(socket_descriptor_t sd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* timeout? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;recv_socks_reply: TCP port read timeout expired&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;recv_socks_reply: TCP port read timeout expired&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;recv_socks_reply: TCP port read failed on select()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;recv_socks_reply: TCP port read failed on select()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -359,7 +359,7 @@ recv_socks_reply(socket_descriptor_t sd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;recv_socks_reply: TCP port read failed on recv()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;recv_socks_reply: TCP port read failed on recv()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -484,7 +484,7 @@ establish_socks_proxy_passthru(struct socks_proxy_info =
*p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const ssize_t size =3D send(sd, buf, 5 + =
len + 2, MSG_NOSIGNAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((int)size !=3D 5 + (int)len + 2)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;establish_socks_proxy_passthru: TCP port write failed on send()&quot;);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;establish_socks_proxy_passthru: TCP port write failed on send()&quot;);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -527,7 +527,7 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info =
*p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010, MSG_NOSIGNAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 10)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;establish_socks_proxy_passthru: TCP port write failed on send()&quot;);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_LINK_ERRORS | M_SKERR, &qu=
ot;establish_socks_proxy_passthru: TCP port write failed on send()&quot;);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
</blockquote><div><br></div><div>All that said, it may be hard to get all e=
rror reporting fixed in one patch, so we could proceed in steps. First make=
 openvpn_errno() and openvpn_strerror() do the right thing with GetLastErro=
r() vs errno, then fix WSA error printing, then the rest if any. Just a tho=
ught.</div><div><br></div><div>Selva</div></div></div>

--0000000000005c94ce05dd3fb972--

