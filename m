From: lstipakov@...277...
Mime-Version: 1.0 (1.0)
Date: Mon, 29 Aug 2022 16:35:46 +0300
Message-Id: <300C4042-73A3-4B19-8CE1-F55E30873C37@...277...>
References: <20220829115117.291-1-lstipakov@...277...>
In-Reply-To: <20220829115117.291-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] dco-win: support for --persist-tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Let=E2=80=99s not merge it yet. I managed to get a BSOD with the new driver=
 version, which this patch is supposed to use. I haven=E2=80=99t seen those=
 for a while, which means that the previous driver version (0.7.6) is stabl=
e and new one (with persist tun support) is not.=20

We=E2=80=99ll get back to this patch when I=E2=80=99ll fix the driver.=20

L=C3=A4hetetty iPhonesta

> Lev Stipakov <lstipakov@...277...> kirjoitti 29.8.2022 kello 14.51:
>=20
> =EF=BB=BFFrom: Lev Stipakov <lev@...515...>
>=20
> Since version 0.8.0, dco-win driver added support for
> DEL_PEER command, which enabled --persist-tun
> implementation on client side.
>=20
> Add real implementation for dco_del_peer on Windows,
> which calls DEL_PEER, which clears peer state
> on the driver without tearing tunnel down.
>=20
> When pulled options are changed on restart,
> we need to close and reopen tun device. This
> is not yes supported for dco-win, so we close
> tun and trigger reconnect.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> src/openvpn/dco.c          |  5 -----
> src/openvpn/dco_win.c      | 29 ++++++++++++++----------
> src/openvpn/dco_win.h      |  8 ++++---
> src/openvpn/init.c         | 19 +++++++++++++---
> src/openvpn/ovpn_dco_win.h |  1 +
> src/openvpn/socket.c       | 45 ++++++++++++++++++++------------------
> 6 files changed, 63 insertions(+), 44 deletions(-)
>=20
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index 78023eea..075820c3 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -233,11 +233,6 @@ dco_check_startup_option_conflict(int msglevel, cons=
t struct options *o)
>         return false;
>     }
>=20
> -    if (o->persist_tun)
> -    {
> -        msg(msglevel, "--persist-tun is not supported with ovpn-dco.");
> -        return false;
> -    }
> #elif defined(TARGET_LINUX)
>     /* if the device name is fixed, we need to check if an interface with=
 this
>      * name already exists. IF it does, it must be a DCO interface, other=
wise
> diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
> index a2030866..a7d6b55d 100644
> --- a/src/openvpn/dco_win.c
> +++ b/src/openvpn/dco_win.c
> @@ -42,7 +42,7 @@
> const IN_ADDR in4addr_any =3D { 0 };
> #endif
>=20
> -static struct tuntap
> +struct tuntap
> create_dco_handle(const char *devname, struct gc_arena *gc)
> {
>     struct tuntap tt =3D { .windows_driver =3D WINDOWS_DRIVER_DCO };
> @@ -157,10 +157,9 @@ dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int =
timeout, volatile int *signa
>     return -1;
> }
>=20
> -struct tuntap
> -dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
> -                  struct addrinfo *bind, const char *devname,
> -                  struct gc_arena *gc, int timeout,
> +bool
> +dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_=
local,
> +                  struct addrinfo *bind, int timeout,
>                   volatile int *signal_received)
> {
>     msg(D_DCO_DEBUG, "%s", __func__);
> @@ -232,10 +231,8 @@ dco_create_socket(struct addrinfo *remoteaddr, bool =
bind_local,
>         ASSERT(0);
>     }
>=20
> -    struct tuntap tt =3D create_dco_handle(devname, gc);
> -
>     OVERLAPPED ov =3D { 0 };
> -    if (!DeviceIoControl(tt.hand, OVPN_IOCTL_NEW_PEER, &peer, sizeof(pee=
r), NULL, 0, NULL, &ov))
> +    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer=
), NULL, 0, NULL, &ov))
>     {
>         DWORD err =3D GetLastError();
>         if (err !=3D ERROR_IO_PENDING)
> @@ -244,13 +241,13 @@ dco_create_socket(struct addrinfo *remoteaddr, bool=
 bind_local,
>         }
>         else
>         {
> -            if (dco_connect_wait(tt.hand, &ov, timeout, signal_received)=
 < 0)
> +            if (dco_connect_wait(handle, &ov, timeout, signal_received) =
< 0)
>             {
> -                close_tun_handle(&tt);
> +                return false;
>             }
>         }
>     }
> -    return tt;
> +    return true;
> }
>=20
> int
> @@ -265,7 +262,15 @@ dco_new_peer(dco_context_t *dco, unsigned int peerid=
, int sd,
> int
> dco_del_peer(dco_context_t *dco, unsigned int peerid)
> {
> -    msg(D_DCO_DEBUG, "%s: peer-id %d - not implemented", __func__, peeri=
d);
> +    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
> +
> +    DWORD bytes_returned =3D 0;
> +    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_DEL_PEER, NULL,
> +                         0, NULL, 0, &bytes_returned, NULL))
> +    {
> +        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_DEL_PEER) fail=
ed");
> +        return -1;
> +    }
>     return 0;
> }
>=20
> diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
> index 348fc568..3a04e4f3 100644
> --- a/src/openvpn/dco_win.h
> +++ b/src/openvpn/dco_win.h
> @@ -37,9 +37,11 @@ struct dco_context {
> typedef struct dco_context dco_context_t;
>=20
> struct tuntap
> -dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
> -                  struct addrinfo *bind, const char *devname,
> -                  struct gc_arena *gc, int timeout,
> +create_dco_handle(const char *devname, struct gc_arena *gc);
> +
> +bool
> +dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_=
local,
> +                  struct addrinfo *bind, int timeout,
>                   volatile int *signal_received);
>=20
> void
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 9917cefe..84d95c21 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2183,10 +2183,23 @@ do_up(struct context *c, bool pulled_options, uns=
igned int option_types_found)
>             {
>                 /* if so, close tun, delete routes, then reinitialize tun=
 and add routes */
>                 msg(M_INFO, "NOTE: Pulled options changed on restart, wil=
l need to close and reopen TUN/TAP device.");
> +
> +                bool tt_dco_win =3D tuntap_is_dco_win(c->c1.tuntap);
>                 do_close_tun(c, true);
> -                management_sleep(1);
> -                c->c2.did_open_tun =3D do_open_tun(c);
> -                update_time();
> +
> +                if (tt_dco_win)
> +                {
> +                    msg(M_NONFATAL, "dco-win doesn't yet support reopeni=
ng TUN device");
> +                    /* prevent link_socket_close() from closing handle w=
ith WinSock API */
> +                    c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
> +                    return false;
> +                }
> +                else
> +                {
> +                    management_sleep(1);
> +                    c->c2.did_open_tun =3D do_open_tun(c);
> +                    update_time();
> +                }
>             }
>         }
>=20
> diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
> index 1ebd51a7..cbbdf92e 100644
> --- a/src/openvpn/ovpn_dco_win.h
> +++ b/src/openvpn/ovpn_dco_win.h
> @@ -106,3 +106,4 @@ typedef struct _OVPN_SET_PEER {
> #define OVPN_IOCTL_SWAP_KEYS    CTL_CODE(FILE_DEVICE_UNKNOWN, 4, METHOD_B=
UFFERED, FILE_ANY_ACCESS)
> #define OVPN_IOCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_B=
UFFERED, FILE_ANY_ACCESS)
> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_B=
UFFERED, FILE_ANY_ACCESS)
> +#define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_=
BUFFERED, FILE_ANY_ACCESS)
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 4e29327b..f2bb3d69 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -2128,23 +2128,29 @@ static void
> create_socket_dco_win(struct context *c, struct link_socket *sock,
>                       volatile int *signal_received)
> {
> -    struct tuntap *tt;
> -    /* In this case persist-tun is enabled, which we don't support yet */
> -    ASSERT(!c->c1.tuntap);
> -
> -    ALLOC_OBJ(tt, struct tuntap);
> -
> -    *tt =3D dco_create_socket(sock->info.lsa->current_remote,
> -                            sock->bind_local,
> -                            sock->info.lsa->bind_local,
> -                            c->options.dev_node,
> -                            &c->gc,
> -                            get_server_poll_remaining_time(sock->server_=
poll_timeout),
> -                            signal_received);
> -
> -    /* This state is used by signal handler which does teardown,
> -     * so it has to be set before return */
> -    c->c1.tuntap =3D tt;
> +    if (!c->c1.tuntap)
> +    {
> +        struct tuntap *tt;
> +        ALLOC_OBJ(tt, struct tuntap);
> +
> +        *tt =3D create_dco_handle(c->options.dev_node, &c->gc);
> +
> +        /* Ensure we can "safely" cast the handle to a socket */
> +        static_assert(sizeof(sock->sd) =3D=3D sizeof(tt->hand), "HANDLE =
and SOCKET size differs");
> +
> +        c->c1.tuntap =3D tt;
> +    }
> +
> +    bool res =3D dco_create_socket(c->c1.tuntap->hand,
> +                                 sock->info.lsa->current_remote,
> +                                 sock->bind_local, sock->info.lsa->bind_=
local,
> +                                 get_server_poll_remaining_time(sock->se=
rver_poll_timeout),
> +                                 signal_received);
> +    if (!res)
> +    {
> +        close_tun_handle(c->c1.tuntap);
> +    }
> +
>     sock->info.dco_installed =3D true;
>=20
>     if (*signal_received)
> @@ -2152,10 +2158,7 @@ create_socket_dco_win(struct context *c, struct li=
nk_socket *sock,
>         return;
>     }
>=20
> -    /* Ensure we can "safely" cast the handle to a socket */
> -    static_assert(sizeof(sock->sd) =3D=3D sizeof(tt->hand), "HANDLE and =
SOCKET size differs");
> -    sock->sd =3D (SOCKET)tt->hand;
> -
> +    sock->sd =3D (SOCKET)c->c1.tuntap->hand;
>     linksock_print_addr(sock);
> }
> #endif /* if defined(_WIN32) */
> --=20
> 2.23.0.windows.1
>=20

