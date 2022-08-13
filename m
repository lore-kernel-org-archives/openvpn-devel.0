MIME-Version: 1.0
References: <20220813204224.22576-1-a@...2181...>
In-Reply-To: <20220813204224.22576-1-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 13 Aug 2022 23:59:40 +0300
Message-ID: <CAGyAFMXwgmzXZaYkXiREoF5Xu8vmwVW7Nydm8jjay7E=tV8o8A@...278...>
Content-Type: multipart/alternative; boundary="000000000000036d2105e625ae48"
Subject: Re: [Openvpn-devel] [PATCH v101 1/7] dco-win: introduce low-level
 code for handling ovpn-dco-win in Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000036d2105e625ae48
Content-Type: text/plain; charset="UTF-8"

I stared at the code, tested with tap-windows6 with this commit and with
dco driver with the latest commit in dco branch, works as expected.

All my concerns are resolved. I am still not sure if it worth to split
implementation into two parts - this commit introduces set of functions
which are not called yet - I am OK with that if it makes code easier to
review.

Disclaimer: I contributed some code to this commit, so I might be slightly
biased.

Acked-by: Lev Stipakov <lstipakov@...277...>


la 13. elok. 2022 klo 23.43 Antonio Quartulli (a@...2181...) kirjoitti:

> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>
> Changes from v100:
> * rebased (fixed conflict in configure.ac)
> * fixed access to disable_dco member in dco.c
> * renamed ovpn-dco-win.h to ovpn_dco_win.h
> * make tun_open_device and close_tun_handle non static
> * add ASSERT(0) to functions that should not be called on Windows
> * remove real_tun_init member (unused now)
> ---
>  config-msvc.h                       |   2 +
>  configure.ac                        |   9 +-
>  dev-tools/special-files.lst         |   1 +
>  src/openvpn/Makefile.am             |   4 +-
>  src/openvpn/dco.c                   |   2 +-
>  src/openvpn/dco_internal.h          |   1 +
>  src/openvpn/dco_win.c               | 400 ++++++++++++++++++++++++++++
>  src/openvpn/dco_win.h               |  57 ++++
>  src/openvpn/openvpn.vcxproj         |   3 +
>  src/openvpn/openvpn.vcxproj.filters |   9 +
>  src/openvpn/ovpn_dco_win.h          | 108 ++++++++
>  src/openvpn/tun.c                   |   4 +-
>  src/openvpn/tun.h                   |  10 +-
>  13 files changed, 602 insertions(+), 8 deletions(-)
>  create mode 100644 src/openvpn/dco_win.c
>  create mode 100644 src/openvpn/dco_win.h
>  create mode 100644 src/openvpn/ovpn_dco_win.h
>
> diff --git a/config-msvc.h b/config-msvc.h
> index b08beb52..b621f3fb 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -87,3 +87,5 @@ typedef uint16_t in_port_t;
>  #ifdef HAVE_CONFIG_MSVC_LOCAL_H
>  #include <config-msvc-local.h>
>  #endif
> +
> +#define ENABLE_DCO 1
> diff --git a/configure.ac b/configure.ac
> index f715b404..be31889e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -144,7 +144,7 @@ AC_ARG_ENABLE(
>
>  AC_ARG_ENABLE(
>         [dco],
> -       [AS_HELP_STRING([--enable-dco], [enable data channel offload
> support using ovpn-dco kernel module @<:@default=no@:>@])],
> +       [AS_HELP_STRING([--enable-dco], [enable data channel offload
> support using the ovpn-dco kernel module (always enabled on Windows)
> @<:@default=no@:>@])],
>         ,
>         [enable_dco="no"]
>  )
> @@ -328,6 +328,7 @@ case "$host" in
>                 ;;
>         *-mingw*)
>                 AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
> +               AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on
> Windows])
>                 AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
>                 CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
>                 CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_VISTA
> -D_WIN32_WINNT=_WIN32_WINNT_VISTA"
> @@ -772,7 +773,6 @@ if test "$enable_dco" = "yes"; then
>  dnl
>  dnl Include generic netlink library used to talk to ovpn-dco
>  dnl
> -
>         case "$host" in
>                 *-*-linux*)
>                         PKG_CHECK_MODULES([LIBNL_GENL],
> @@ -792,8 +792,11 @@ dnl
>                         AC_DEFINE(ENABLE_DCO, 1, [Enable data channel
> offload for FreeBSD])
>                         AC_MSG_NOTICE([Enabled ovpn-dco support for
> FreeBSD])
>                         ;;
> +               *-mingw*)
> +                       AC_MSG_NOTICE([NOTE: --enable-dco ignored on
> Windows because it's always enabled])
> +                       ;;
>                 *)
> -                       AC_MSG_NOTICE([Ignoring --enable-dco on non Linux
> platform])
> +                       AC_MSG_NOTICE([Ignoring --enable-dco on non
> supported platform])
>                         ;;
>         esac
>  fi
> diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst
> index 33e830d7..e5f2fc27 100644
> --- a/dev-tools/special-files.lst
> +++ b/dev-tools/special-files.lst
> @@ -2,3 +2,4 @@ E:doc/doxygen/doc_key_generation.h     # @verbatim section
> gets mistreated, excl
>  E:src/compat/compat-lz4.c              # Preserve LZ4 upstream formatting
>  E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
>  E:src/openvpn/ovpn_dco_linux.h         # Preserve ovpn-dco upstream
> formatting
> +E:src/openvpn/ovpn_dco_win.h           # Preserve ovpn-dco-win upstream
> formatting
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 2a139b23..936d038c 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -56,6 +56,7 @@ openvpn_SOURCES = \
>         dco.c dco.h dco_internal.h \
>         dco_freebsd.c dco_freebsd.h \
>         dco_linux.c dco_linux.h \
> +       dco_win.c dco_win.h \
>         dhcp.c dhcp.h \
>         dns.c dns.h \
>         env_set.c env_set.h \
> @@ -79,6 +80,7 @@ openvpn_SOURCES = \
>         memdbg.h \
>         misc.c misc.h \
>         ovpn_dco_linux.h \
> +       ovpn_dco_win.h \
>         platform.c platform.h \
>         console.c console.h console_builtin.c console_systemd.c \
>         mroute.c mroute.h \
> @@ -152,5 +154,5 @@ openvpn_LDADD = \
>         $(OPTIONAL_INOTIFY_LIBS)
>  if WIN32
>  openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
> ring_buffer.h
> -openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
> -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
> +openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
> -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
>  endif
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index ef204767..b342bee1 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -289,7 +289,7 @@ dco_check_option_conflict(int msglevel, const struct
> options *o)
>       * specified at all. In the latter case, later logic will most likely
> stop
>       * OpenVPN, so no need to print any message here.
>       */
> -    if (o->tuntap_options.disable_dco || !o->dev)
> +    if (!dco_enabled(o) || !o->dev)
>      {
>          return false;
>      }
> diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
> index 728e3092..b973d743 100644
> --- a/src/openvpn/dco_internal.h
> +++ b/src/openvpn/dco_internal.h
> @@ -29,6 +29,7 @@
>
>  #include "dco_freebsd.h"
>  #include "dco_linux.h"
> +#include "dco_win.h"
>
>  /**
>   * This file contains the internal DCO API definition.
> diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
> new file mode 100644
> index 00000000..28bcccd4
> --- /dev/null
> +++ b/src/openvpn/dco_win.c
> @@ -0,0 +1,400 @@
> +/*
> + *  Interface to ovpn-win-dco networking code
> + *
> + *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
> + *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#if defined(_WIN32)
> +
> +#include "syshead.h"
> +
> +#include "dco.h"
> +#include "tun.h"
> +#include "crypto.h"
> +#include "ssl_common.h"
> +
> +#include <bcrypt.h>
> +#include <winsock2.h>
> +#include <ws2tcpip.h>
> +
> +#if defined(__MINGW32__)
> +const IN_ADDR in4addr_any = { 0 };
> +#endif
> +
> +static struct tuntap
> +create_dco_handle(const char *devname, struct gc_arena *gc)
> +{
> +    struct tuntap tt = { .windows_driver = WINDOWS_DRIVER_DCO };
> +    const char *device_guid;
> +
> +    tun_open_device(&tt, devname, &device_guid, gc);
> +
> +    return tt;
> +}
> +
> +bool
> +ovpn_dco_init(int mode, dco_context_t *dco)
> +{
> +    return true;
> +}
> +
> +int
> +open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
> +{
> +    ASSERT(0);
> +    return 0;
> +}
> +
> +static void
> +dco_wait_ready(DWORD idx)
> +{
> +    for (int i = 0; i < 20; ++i)
> +    {
> +        MIB_IPINTERFACE_ROW row = {.InterfaceIndex = idx, .Family =
> AF_INET};
> +        if (GetIpInterfaceEntry(&row) != ERROR_NOT_FOUND)
> +        {
> +            break;
> +        }
> +        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
> +        Sleep(50);
> +    }
> +}
> +
> +void
> +dco_start_tun(struct tuntap *tt)
> +{
> +    msg(D_DCO_DEBUG, "%s", __func__);
> +
> +    /* reference the tt object inside the DCO context, because the latter
> will
> +     * be passed around
> +     */
> +    tt->dco.tt = tt;
> +
> +    DWORD bytes_returned = 0;
> +    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
> +                         &bytes_returned, NULL))
> +    {
> +        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed");
> +    }
> +
> +    /* Sometimes IP Helper API, which we use for setting IP address etc,
> +     * complains that interface is not found. Give it some time to settle
> +     */
> +    dco_wait_ready(tt->adapter_index);
> +}
> +
> +static int
> +dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int
> *signal_received)
> +{
> +    DWORD timeout_msec = timeout * 1000;
> +    const int poll_interval_ms = 50;
> +
> +    while (timeout_msec > 0)
> +    {
> +        timeout_msec -= poll_interval_ms;
> +
> +        DWORD transferred;
> +        if (GetOverlappedResultEx(handle, ov, &transferred,
> poll_interval_ms, FALSE) != 0)
> +        {
> +            /* TCP connection established by dco */
> +            return 0;
> +        }
> +
> +        DWORD err = GetLastError();
> +        if ((err != WAIT_TIMEOUT) && (err != ERROR_IO_INCOMPLETE))
> +        {
> +            /* dco reported connection error */
> +            msg(M_NONFATAL | M_ERRNO, "dco connect error");
> +            *signal_received = SIGUSR1;
> +            return -1;
> +        }
> +
> +        get_signal(signal_received);
> +        if (*signal_received)
> +        {
> +            return -1;
> +        }
> +
> +        management_sleep(0);
> +    }
> +
> +    /* we end up here when timeout occurs in userspace */
> +    msg(M_NONFATAL, "dco connect timeout");
> +    *signal_received = SIGUSR1;
> +
> +    return -1;
> +}
> +
> +struct tuntap
> +dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
> +                  struct addrinfo *bind, const char *devname,
> +                  struct gc_arena *gc, int timeout,
> +                  volatile int *signal_received)
> +{
> +    msg(D_DCO_DEBUG, "%s", __func__);
> +
> +    OVPN_NEW_PEER peer = { 0 };
> +
> +    struct sockaddr *local = NULL;
> +    struct sockaddr *remote = remoteaddr->ai_addr;
> +
> +    if (remoteaddr->ai_protocol == IPPROTO_TCP
> +        || remoteaddr->ai_socktype == SOCK_STREAM)
> +    {
> +        peer.Proto = OVPN_PROTO_TCP;
> +    }
> +    else
> +    {
> +        peer.Proto = OVPN_PROTO_UDP;
> +    }
> +
> +    if (bind_local)
> +    {
> +        /* Use first local address with correct address family */
> +        while (bind && !local)
> +        {
> +            if (bind->ai_family == remote->sa_family)
> +            {
> +                local = bind->ai_addr;
> +            }
> +            bind = bind->ai_next;
> +        }
> +    }
> +
> +    if (bind_local && !local)
> +    {
> +        msg(M_FATAL, "DCO: Socket bind failed: Address to bind lacks %s
> record",
> +            addr_family_name(remote->sa_family));
> +    }
> +
> +    if (remote->sa_family == AF_INET6)
> +    {
> +        peer.Remote.Addr6 = *((SOCKADDR_IN6 *)(remoteaddr->ai_addr));
> +        if (local)
> +        {
> +            peer.Local.Addr6 = *((SOCKADDR_IN6 *)local);
> +        }
> +        else
> +        {
> +            peer.Local.Addr6.sin6_addr = in6addr_any;
> +            peer.Local.Addr6.sin6_port = 0;
> +            peer.Local.Addr6.sin6_family = AF_INET6;
> +        }
> +    }
> +    else if (remote->sa_family == AF_INET)
> +    {
> +        peer.Remote.Addr4 = *((SOCKADDR_IN *)(remoteaddr->ai_addr));
> +        if (local)
> +        {
> +            peer.Local.Addr4 = *((SOCKADDR_IN *)local);
> +        }
> +        else
> +        {
> +            peer.Local.Addr4.sin_addr = in4addr_any;
> +            peer.Local.Addr4.sin_port = 0;
> +            peer.Local.Addr4.sin_family = AF_INET;
> +        }
> +    }
> +    else
> +    {
> +        ASSERT(0);
> +    }
> +
> +    struct tuntap tt = create_dco_handle(devname, gc);
> +
> +    OVERLAPPED ov = { 0 };
> +    if (!DeviceIoControl(tt.hand, OVPN_IOCTL_NEW_PEER, &peer,
> sizeof(peer), NULL, 0, NULL, &ov))
> +    {
> +        DWORD err = GetLastError();
> +        if (err != ERROR_IO_PENDING)
> +        {
> +            msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_PEER) failed");
> +        }
> +        else
> +        {
> +            if (dco_connect_wait(tt.hand, &ov, timeout, signal_received)
> < 0)
> +            {
> +                close_tun_handle(&tt);
> +            }
> +        }
> +    }
> +    return tt;
> +}
> +
> +int
> +dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
> +             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
> +             struct in_addr *remote_in4, struct in6_addr *remote_in6)
> +{
> +    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
> +    return 0;
> +}
> +
> +int
> +dco_del_peer(dco_context_t *dco, unsigned int peerid)
> +{
> +    msg(D_DCO_DEBUG, "%s: peer-id %d - not implemented", __func__,
> peerid);
> +    return 0;
> +}
> +
> +int
> +dco_set_peer(dco_context_t *dco, unsigned int peerid,
> +             int keepalive_interval, int keepalive_timeout, int mss)
> +{
> +    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
> +        peerid, keepalive_interval, keepalive_timeout, mss);
> +
> +    OVPN_SET_PEER peer;
> +
> +    peer.KeepaliveInterval =  keepalive_interval;
> +    peer.KeepaliveTimeout = keepalive_timeout;
> +    peer.MSS = mss;
> +
> +    DWORD bytes_returned = 0;
> +    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_PEER, &peer,
> +                         sizeof(peer), NULL, 0, &bytes_returned, NULL))
> +    {
> +        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_PEER)
> failed");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +int
> +dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
> +            dco_key_slot_t slot,
> +            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
> +            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
> +            const char *ciphername)
> +{
> +    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
> +        __func__, slot, keyid, peerid, ciphername);
> +
> +    const int nonce_len = 8;
> +    size_t key_len = cipher_kt_key_size(ciphername);
> +
> +    OVPN_CRYPTO_DATA crypto_data;
> +    ZeroMemory(&crypto_data, sizeof(crypto_data));
> +
> +    crypto_data.CipherAlg = dco_get_cipher(ciphername);
> +    crypto_data.KeyId = keyid;
> +    crypto_data.PeerId = peerid;
> +    crypto_data.KeySlot = slot;
> +
> +    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
> +    crypto_data.Encrypt.KeyLen = (char)key_len;
> +    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
> +
> +    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
> +    crypto_data.Decrypt.KeyLen = (char)key_len;
> +    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
> +
> +    ASSERT(crypto_data.CipherAlg > 0);
> +
> +    DWORD bytes_returned = 0;
> +
> +    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data,
> +                         sizeof(crypto_data), NULL, 0, &bytes_returned,
> NULL))
> +    {
> +        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
> +        return -1;
> +    }
> +    return 0;
> +}
> +int
> +dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
> +{
> +    msg(D_DCO, "%s: peer-id %d, slot %d called but ignored", __func__,
> peerid,
> +        slot);
> +    /* FIXME: Implement in driver first */
> +    return 0;
> +}
> +
> +int
> +dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
> +{
> +    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
> +
> +    DWORD bytes_returned = 0;
> +    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SWAP_KEYS, NULL, 0,
> NULL, 0,
> +                         &bytes_returned, NULL))
> +    {
> +        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +bool
> +dco_available(int msglevel)
> +{
> +    return true;
> +}
> +
> +int
> +dco_do_read(dco_context_t *dco)
> +{
> +    /* no-op on windows */
> +    ASSERT(0);
> +    return 0;
> +}
> +
> +int
> +dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
> +{
> +    /* no-op on windows */
> +    ASSERT(0);
> +    return 0;
> +}
> +
> +void
> +dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
> +{
> +    /* no-op on windows */
> +    ASSERT(0);
> +}
> +
> +const char *
> +dco_get_supported_ciphers()
> +{
> +    /*
> +     * this API can be called either from user mode or kernel mode,
> +     * which enables us to probe driver's chachapoly support
> +     * (available starting from Windows 11)
> +     */
> +
> +    BCRYPT_ALG_HANDLE h;
> +    NTSTATUS status = BCryptOpenAlgorithmProvider(&h,
> L"CHACHA20_POLY1305", NULL, 0);
> +    if (BCRYPT_SUCCESS(status))
> +    {
> +        BCryptCloseAlgorithmProvider(h, 0);
> +        return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
> +    }
> +    else
> +    {
> +        return "AES-128-GCM:AES-256-GCM:AES-192-GCM";
> +    }
> +}
> +
> +#endif /* defined(_WIN32) */
> diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
> new file mode 100644
> index 00000000..348fc568
> --- /dev/null
> +++ b/src/openvpn/dco_win.h
> @@ -0,0 +1,57 @@
> +/*
> + *  Interface to ovpn-win-dco networking code
> + *
> + *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
> + *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef DCO_WIN_H
> +#define DCO_WIN_H
> +
> +#if defined(ENABLE_DCO) && defined(_WIN32)
> +
> +#include "buffer.h"
> +#include "ovpn_dco_win.h"
> +
> +typedef OVPN_KEY_SLOT dco_key_slot_t;
> +typedef OVPN_CIPHER_ALG dco_cipher_t;
> +
> +struct dco_context {
> +    struct tuntap *tt;
> +};
> +
> +typedef struct dco_context dco_context_t;
> +
> +struct tuntap
> +dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
> +                  struct addrinfo *bind, const char *devname,
> +                  struct gc_arena *gc, int timeout,
> +                  volatile int *signal_received);
> +
> +void
> +dco_start_tun(struct tuntap *tt);
> +
> +#else /* if defined(ENABLE_DCO) && defined(_WIN32) */
> +
> +static inline void
> +dco_start_tun(struct tuntap *tt)
> +{
> +    ASSERT(false);
> +}
> +
> +#endif /* defined(_WIN32) */
> +#endif /* ifndef DCO_H */
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index 0b3db7c7..ccd29cd8 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -278,6 +278,7 @@
>      <ClCompile Include="cryptoapi.c" />
>      <ClCompile Include="dco.c" />
>      <ClCompile Include="dco_linux.c" />
> +    <ClCompile Include="dco_win.c" />
>      <ClCompile Include="dhcp.c" />
>      <ClCompile Include="dns.c" />
>      <ClCompile Include="env_set.c" />
> @@ -367,6 +368,7 @@
>      <ClInclude Include="dco.h" />
>      <ClInclude Include="dco_internal.h" />
>      <ClInclude Include="dco_linux.h" />
> +    <ClInclude Include="dco_win.h" />
>      <ClInclude Include="dhcp.h" />
>      <ClInclude Include="dns.h" />
>      <ClInclude Include="env_set.h" />
> @@ -402,6 +404,7 @@
>      <ClInclude Include="options.h" />
>      <ClInclude Include="otime.h" />
>      <ClInclude Include="ovpn_dco_linux.h" />
> +    <ClInclude Include="ovpn_dco_win.h" />
>      <ClInclude Include="packet_id.h" />
>      <ClInclude Include="perf.h" />
>      <ClInclude Include="ping.h" />
> diff --git a/src/openvpn/openvpn.vcxproj.filters
> b/src/openvpn/openvpn.vcxproj.filters
> index 16905079..bf0ba708 100644
> --- a/src/openvpn/openvpn.vcxproj.filters
> +++ b/src/openvpn/openvpn.vcxproj.filters
> @@ -42,6 +42,9 @@
>      <ClCompile Include="dco_linux.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> +    <ClCompile Include="dco_win.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
>      <ClCompile Include="dhcp.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> @@ -314,6 +317,9 @@
>      <ClInclude Include="dco_linux.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> +    <ClInclude Include="dco_win.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
>      <ClInclude Include="dhcp.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> @@ -416,6 +422,9 @@
>      <ClInclude Include="ovpn_dco_linux.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> +    <ClInclude Include="ovpn_dco_win.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
>      <ClInclude Include="packet_id.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
> new file mode 100644
> index 00000000..1ebd51a7
> --- /dev/null
> +++ b/src/openvpn/ovpn_dco_win.h
> @@ -0,0 +1,108 @@
> +/*
> + *  ovpn-dco-win OpenVPN protocol accelerator for Windows
> + *
> + *  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
> + *
> + *  Author:    Lev Stipakov <lev@...515...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> along
> + *  with this program; if not, write to the Free Software Foundation,
> Inc.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + *  This particular file (uapi.h) is also licensed using the MIT license
> (see COPYRIGHT.MIT).
> + */
> +
> +#pragma once
> +#ifndef _KERNEL_MODE
> +#include <winsock2.h>
> +#endif
> +#include <ws2def.h>
> +#include <ws2ipdef.h>
> +
> +typedef enum {
> +       OVPN_PROTO_UDP,
> +       OVPN_PROTO_TCP
> +} OVPN_PROTO;
> +
> +typedef struct _OVPN_NEW_PEER {
> +       union {
> +               SOCKADDR_IN Addr4;
> +               SOCKADDR_IN6 Addr6;
> +       } Local;
> +
> +       union {
> +               SOCKADDR_IN Addr4;
> +               SOCKADDR_IN6 Addr6;
> +       } Remote;
> +
> +       OVPN_PROTO Proto;
> +} OVPN_NEW_PEER, * POVPN_NEW_PEER;
> +
> +typedef struct _OVPN_STATS {
> +       LONG LostInControlPackets;
> +       LONG LostOutControlPackets;
> +
> +       LONG LostInDataPackets;
> +       LONG LostOutDataPackets;
> +
> +       LONG ReceivedDataPackets;
> +       LONG ReceivedControlPackets;
> +
> +       LONG SentControlPackets;
> +       LONG SentDataPackets;
> +
> +       LONG64 TransportBytesSent;
> +       LONG64 TransportBytesReceived;
> +
> +       LONG64 TunBytesSent;
> +       LONG64 TunBytesReceived;
> +} OVPN_STATS, * POVPN_STATS;
> +
> +typedef enum _OVPN_KEY_SLOT {
> +       OVPN_KEY_SLOT_PRIMARY,
> +       OVPN_KEY_SLOT_SECONDARY
> +} OVPN_KEY_SLOT;
> +
> +typedef enum _OVPN_CIPHER_ALG {
> +       OVPN_CIPHER_ALG_NONE,
> +       OVPN_CIPHER_ALG_AES_GCM,
> +       OVPN_CIPHER_ALG_CHACHA20_POLY1305
> +} OVPN_CIPHER_ALG;
> +
> +typedef struct _OVPN_KEY_DIRECTION
> +{
> +       unsigned char Key[32];
> +       unsigned char KeyLen; // 16/24/32 ->
> AES-128-GCM/AES-192-GCM/AES-256-GCM
> +       unsigned char NonceTail[8];
> +} OVPN_KEY_DIRECTION;
> +
> +typedef struct _OVPN_CRYPTO_DATA {
> +       OVPN_KEY_DIRECTION Encrypt;
> +       OVPN_KEY_DIRECTION Decrypt;
> +       OVPN_KEY_SLOT KeySlot;
> +       OVPN_CIPHER_ALG CipherAlg;
> +       unsigned char KeyId;
> +       int PeerId;
> +} OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;
> +
> +typedef struct _OVPN_SET_PEER {
> +       LONG KeepaliveInterval;
> +       LONG KeepaliveTimeout;
> +       LONG MSS;
> +} OVPN_SET_PEER, * POVPN_SET_PEER;
> +
> +#define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1,
> METHOD_BUFFERED, FILE_ANY_ACCESS)
> +#define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2,
> METHOD_BUFFERED, FILE_ANY_ACCESS)
> +#define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3,
> METHOD_BUFFERED, FILE_ANY_ACCESS)
> +#define OVPN_IOCTL_SWAP_KEYS    CTL_CODE(FILE_DEVICE_UNKNOWN, 4,
> METHOD_BUFFERED, FILE_ANY_ACCESS)
> +#define OVPN_IOCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5,
> METHOD_BUFFERED, FILE_ANY_ACCESS)
> +#define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6,
> METHOD_BUFFERED, FILE_ANY_ACCESS)
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 1651eeea..93cf0301 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6532,7 +6532,7 @@ tun_try_open_device(struct tuntap *tt, const char
> *device_guid, const struct dev
>      return true;
>  }
>
> -static void
> +void
>  tun_open_device(struct tuntap *tt, const char *dev_node, const char
> **device_guid, struct gc_arena *gc)
>  {
>      const struct tap_reg *tap_reg = get_tap_reg(gc);
> @@ -6824,7 +6824,7 @@ netsh_delete_address_dns(const struct tuntap *tt,
> bool ipv6, struct gc_arena *gc
>      argv_free(&argv);
>  }
>
> -static void
> +void
>  close_tun_handle(struct tuntap *tt)
>  {
>      const char *adaptertype = print_windows_driver(tt->windows_driver);
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index 661e4d01..de2f68fc 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -48,7 +48,8 @@
>  enum windows_driver_type {
>      WINDOWS_DRIVER_UNSPECIFIED,
>      WINDOWS_DRIVER_TAP_WINDOWS6,
> -    WINDOWS_DRIVER_WINTUN
> +    WINDOWS_DRIVER_WINTUN,
> +    WINDOWS_DRIVER_DCO
>  };
>  #endif
>
> @@ -64,6 +65,8 @@ struct tuntap_options {
>      /* --ip-win32 options */
>      bool ip_win32_defined;
>
> +    bool disable_dco;
> +
>  #define IPW32_SET_MANUAL       0   /* "--ip-win32 manual" */
>  #define IPW32_SET_NETSH        1   /* "--ip-win32 netsh" */
>  #define IPW32_SET_IPAPI        2   /* "--ip-win32 ipapi" */
> @@ -259,6 +262,11 @@ void open_tun(const char *dev, const char *dev_type,
> const char *dev_node,
>
>  void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
>
> +void tun_open_device(struct tuntap *tt, const char *dev_node,
> +                     const char **device_guid, struct gc_arena *gc);
> +
> +void close_tun_handle(struct tuntap *tt);
> +
>  int write_tun(struct tuntap *tt, uint8_t *buf, int len);
>
>  int read_tun(struct tuntap *tt, uint8_t *buf, int len);
> --
> 2.35.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000036d2105e625ae48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I stared at the code, tested with tap-windows6 with this c=
ommit and with dco driver with the latest commit=C2=A0in dco branch, works =
as expected.<div><br></div><div>All my concerns are resolved. I am still no=
t sure if it worth to split implementation into two parts - this commit int=
roduces set of functions which are not called yet - I am OK with that if it=
 makes code easier to review.</div><div><br></div><div>Disclaimer: I contri=
buted some code to this commit, so I might be slightly biased.</div><div><b=
r></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1354...=
..">lstipakov@...277...</a>&gt;=C2=A0</div><div><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">la 13. elok. 2022=
 klo 23.43 Antonio Quartulli (<a href=3D"mailto:a@...2181...">a@...2181...<=
/a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=
=3D"_blank">a@...2181...</a>&gt;<br>
---<br>
<br>
Changes from v100:<br>
* rebased (fixed conflict in <a href=3D"http://configure.ac" rel=3D"norefer=
rer" target=3D"_blank">configure.ac</a>)<br>
* fixed access to disable_dco member in dco.c<br>
* renamed ovpn-dco-win.h to ovpn_dco_win.h<br>
* make tun_open_device and close_tun_handle non static<br>
* add ASSERT(0) to functions that should not be called on Windows<br>
* remove real_tun_init member (unused now)<br>
---<br>
=C2=A0config-msvc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-<br>
=C2=A0dev-tools/special-files.lst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
=C2=A0src/openvpn/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0src/openvpn/dco.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0src/openvpn/dco_internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
=C2=A0src/openvpn/dco_win.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 400 ++++++++++++++++++++++++++++<br>
=C2=A0src/openvpn/dco_win.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 57 ++++<br>
=C2=A0src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A03 +<br>
=C2=A0src/openvpn/openvpn.vcxproj.filters |=C2=A0 =C2=A09 +<br>
=C2=A0src/openvpn/ovpn_dco_win.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 108 ++=
++++++<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 10 +-<br>
=C2=A013 files changed, 602 insertions(+), 8 deletions(-)<br>
=C2=A0create mode 100644 src/openvpn/dco_win.c<br>
=C2=A0create mode 100644 src/openvpn/dco_win.h<br>
=C2=A0create mode 100644 src/openvpn/ovpn_dco_win.h<br>
<br>
diff --git a/config-msvc.h b/config-msvc.h<br>
index b08beb52..b621f3fb 100644<br>
--- a/config-msvc.h<br>
+++ b/config-msvc.h<br>
@@ -87,3 +87,5 @@ typedef uint16_t in_port_t;<br>
=C2=A0#ifdef HAVE_CONFIG_MSVC_LOCAL_H<br>
=C2=A0#include &lt;config-msvc-local.h&gt;<br>
=C2=A0#endif<br>
+<br>
+#define ENABLE_DCO 1<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index f715b404..be31889e 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -144,7 +144,7 @@ AC_ARG_ENABLE(<br>
<br>
=C2=A0AC_ARG_ENABLE(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [dco],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--enable-dco], [enable data ch=
annel offload support using ovpn-dco kernel module @&lt;:@default=3Dno@:&gt=
;@])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--enable-dco], [enable data ch=
annel offload support using the ovpn-dco kernel module (always enabled on W=
indows) @&lt;:@default=3Dno@:&gt;@])],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_dco=3D&quot;no&quot;]<br>
=C2=A0)<br>
@@ -328,6 +328,7 @@ case &quot;$host&quot; in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *-mingw*)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE([TARGET_W=
IN32], [1], [Are we running WIN32?])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE([ENABLE_D=
CO], [1], [DCO is always enabled on Windows])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE_UNQUOTED(=
[TARGET_PREFIX], [&quot;W&quot;], [Target prefix])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPPFLAGS=3D&quot;${=
CPPFLAGS} -DWIN32_LEAN_AND_MEAN&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPPFLAGS=3D&quot;${=
CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA=
&quot;<br>
@@ -772,7 +773,6 @@ if test &quot;$enable_dco&quot; =3D &quot;yes&quot;; th=
en<br>
=C2=A0dnl<br>
=C2=A0dnl Include generic netlink library used to talk to ovpn-dco<br>
=C2=A0dnl<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &quot;$host&quot; in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *-*-linux*)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PKG_CHECK_MODULES([LIBNL_GENL],<br>
@@ -792,8 +792,11 @@ dnl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBS=
D])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*-mingw*)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_NOTICE([NOTE: --enable-dco ignored on Windows because it&#=
39;s always enabled])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_NOTICE([Ignoring --enable-dco on non Linux platform])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_NOTICE([Ignoring --enable-dco on non supported platform])<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 esac<br>
=C2=A0fi<br>
diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst<br>
index 33e830d7..e5f2fc27 100644<br>
--- a/dev-tools/special-files.lst<br>
+++ b/dev-tools/special-files.lst<br>
@@ -2,3 +2,4 @@ E:doc/doxygen/doc_key_generation.h=C2=A0 =C2=A0 =C2=A0# @ve=
rbatim section gets mistreated, excl<br>
=C2=A0E:src/compat/compat-lz4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # Preserve LZ4 upstream formatting<br>
=C2=A0E:src/compat/compat-lz4.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # Preserve LZ4 upstream formatting<br>
=C2=A0E:src/openvpn/ovpn_dco_linux.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Pre=
serve ovpn-dco upstream formatting<br>
+E:src/openvpn/ovpn_dco_win.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Pre=
serve ovpn-dco-win upstream formatting<br>
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am<br>
index 2a139b23..936d038c 100644<br>
--- a/src/openvpn/Makefile.am<br>
+++ b/src/openvpn/Makefile.am<br>
@@ -56,6 +56,7 @@ openvpn_SOURCES =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dco.c dco.h dco_internal.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dco_freebsd.c dco_freebsd.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dco_linux.c dco_linux.h \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dco_win.c dco_win.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dhcp.c dhcp.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dns.c dns.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 env_set.c env_set.h \<br>
@@ -79,6 +80,7 @@ openvpn_SOURCES =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memdbg.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 misc.c misc.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ovpn_dco_linux.h \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ovpn_dco_win.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform.c platform.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 console.c console.h console_builtin.c console_s=
ystemd.c \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mroute.c mroute.h \<br>
@@ -152,5 +154,5 @@ openvpn_LDADD =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_INOTIFY_LIBS)<br>
=C2=A0if WIN32<br>
=C2=A0openvpn_SOURCES +=3D openvpn_win32_resources.rc block_dns.c block_dns=
.h ring_buffer.h<br>
-openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm=
 -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi<br>
+openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm=
 -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt<br>
=C2=A0endif<br>
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c<br>
index ef204767..b342bee1 100644<br>
--- a/src/openvpn/dco.c<br>
+++ b/src/openvpn/dco.c<br>
@@ -289,7 +289,7 @@ dco_check_option_conflict(int msglevel, const struct op=
tions *o)<br>
=C2=A0 =C2=A0 =C2=A0 * specified at all. In the latter case, later logic wi=
ll most likely stop<br>
=C2=A0 =C2=A0 =C2=A0 * OpenVPN, so no need to print any message here.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (o-&gt;tuntap_options.disable_dco || !o-&gt;dev)<br>
+=C2=A0 =C2=A0 if (!dco_enabled(o) || !o-&gt;dev)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h<br>
index 728e3092..b973d743 100644<br>
--- a/src/openvpn/dco_internal.h<br>
+++ b/src/openvpn/dco_internal.h<br>
@@ -29,6 +29,7 @@<br>
<br>
=C2=A0#include &quot;dco_freebsd.h&quot;<br>
=C2=A0#include &quot;dco_linux.h&quot;<br>
+#include &quot;dco_win.h&quot;<br>
<br>
=C2=A0/**<br>
=C2=A0 * This file contains the internal DCO API definition.<br>
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c<br>
new file mode 100644<br>
index 00000000..28bcccd4<br>
--- /dev/null<br>
+++ b/src/openvpn/dco_win.c<br>
@@ -0,0 +1,400 @@<br>
+/*<br>
+ *=C2=A0 Interface to ovpn-win-dco networking code<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020-2022 Arne Schwabe &lt;<a href=3D"mailto:arne@...220...=
..1227..." target=3D"_blank">arne@...1227...</a>&gt;<br>
+ *=C2=A0 Copyright (C) 2020-2022 OpenVPN Inc &lt;<a href=3D"mailto:sales@...220...=
..515..." target=3D"_blank">sales@...515...</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software; you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License version 2<br>
+ *=C2=A0 as published by the Free Software Foundation.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program (see the file COPYING included with this<=
br>
+ *=C2=A0 distribution); if not, write to the Free Software Foundation, Inc=
.,<br>
+ *=C2=A0 59 Temple Place, Suite 330, Boston, MA=C2=A0 02111-1307=C2=A0 USA=
<br>
+ */<br>
+<br>
+#ifdef HAVE_CONFIG_H<br>
+#include &quot;config.h&quot;<br>
+#elif defined(_MSC_VER)<br>
+#include &quot;config-msvc.h&quot;<br>
+#endif<br>
+<br>
+#if defined(_WIN32)<br>
+<br>
+#include &quot;syshead.h&quot;<br>
+<br>
+#include &quot;dco.h&quot;<br>
+#include &quot;tun.h&quot;<br>
+#include &quot;crypto.h&quot;<br>
+#include &quot;ssl_common.h&quot;<br>
+<br>
+#include &lt;bcrypt.h&gt;<br>
+#include &lt;winsock2.h&gt;<br>
+#include &lt;ws2tcpip.h&gt;<br>
+<br>
+#if defined(__MINGW32__)<br>
+const IN_ADDR in4addr_any =3D { 0 };<br>
+#endif<br>
+<br>
+static struct tuntap<br>
+create_dco_handle(const char *devname, struct gc_arena *gc)<br>
+{<br>
+=C2=A0 =C2=A0 struct tuntap tt =3D { .windows_driver =3D WINDOWS_DRIVER_DC=
O };<br>
+=C2=A0 =C2=A0 const char *device_guid;<br>
+<br>
+=C2=A0 =C2=A0 tun_open_device(&amp;tt, devname, &amp;device_guid, gc);<br>
+<br>
+=C2=A0 =C2=A0 return tt;<br>
+}<br>
+<br>
+bool<br>
+ovpn_dco_init(int mode, dco_context_t *dco)<br>
+{<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+int<br>
+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)<b=
r>
+{<br>
+=C2=A0 =C2=A0 ASSERT(0);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static void<br>
+dco_wait_ready(DWORD idx)<br>
+{<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 20; ++i)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIB_IPINTERFACE_ROW row =3D {.InterfaceIndex =
=3D idx, .Family =3D AF_INET};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetIpInterfaceEntry(&amp;row) !=3D ERROR_N=
OT_FOUND)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;interface %ld not yet r=
eady, retrying&quot;, idx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sleep(50);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void<br>
+dco_start_tun(struct tuntap *tt)<br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);<br>
+<br>
+=C2=A0 =C2=A0 /* reference the tt object inside the DCO context, because t=
he latter will<br>
+=C2=A0 =C2=A0 =C2=A0* be passed around<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 tt-&gt;<a href=3D"http://dco.tt" rel=3D"noreferrer" target=
=3D"_blank">dco.tt</a> =3D tt;<br>
+<br>
+=C2=A0 =C2=A0 DWORD bytes_returned =3D 0;<br>
+=C2=A0 =C2=A0 if (!DeviceIoControl(tt-&gt;hand, OVPN_IOCTL_START_VPN, NULL=
, 0, NULL, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;bytes_returned, NULL))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_ST=
ART_VPN) failed&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Sometimes IP Helper API, which we use for setting IP addr=
ess etc,<br>
+=C2=A0 =C2=A0 =C2=A0* complains that interface is not found. Give it some =
time to settle<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 dco_wait_ready(tt-&gt;adapter_index);<br>
+}<br>
+<br>
+static int<br>
+dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int =
*signal_received)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD timeout_msec =3D timeout * 1000;<br>
+=C2=A0 =C2=A0 const int poll_interval_ms =3D 50;<br>
+<br>
+=C2=A0 =C2=A0 while (timeout_msec &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout_msec -=3D poll_interval_ms;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD transferred;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetOverlappedResultEx(handle, ov, &amp;tra=
nsferred, poll_interval_ms, FALSE) !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TCP connection established by=
 dco */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD err =3D GetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((err !=3D WAIT_TIMEOUT) &amp;&amp; (err !=
=3D ERROR_IO_INCOMPLETE))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* dco reported connection error=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL | M_ERRNO, &quot;=
dco connect error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *signal_received =3D SIGUSR1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_signal(signal_received);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*signal_received)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 management_sleep(0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* we end up here when timeout occurs in userspace */<br>
+=C2=A0 =C2=A0 msg(M_NONFATAL, &quot;dco connect timeout&quot;);<br>
+=C2=A0 =C2=A0 *signal_received =3D SIGUSR1;<br>
+<br>
+=C2=A0 =C2=A0 return -1;<br>
+}<br>
+<br>
+struct tuntap<br>
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct addr=
info *bind, const char *devname,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gc_a=
rena *gc, int timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 volatile in=
t *signal_received)<br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);<br>
+<br>
+=C2=A0 =C2=A0 OVPN_NEW_PEER peer =3D { 0 };<br>
+<br>
+=C2=A0 =C2=A0 struct sockaddr *local =3D NULL;<br>
+=C2=A0 =C2=A0 struct sockaddr *remote =3D remoteaddr-&gt;ai_addr;<br>
+<br>
+=C2=A0 =C2=A0 if (remoteaddr-&gt;ai_protocol =3D=3D IPPROTO_TCP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || remoteaddr-&gt;ai_socktype =3D=3D SOCK_STRE=
AM)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Proto =3D OVPN_PROTO_TCP;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Proto =3D OVPN_PROTO_UDP;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (bind_local)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use first local address with correct addres=
s family */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (bind &amp;&amp; !local)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bind-&gt;ai_family =3D=3D re=
mote-&gt;sa_family)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local =3D bind-&gt=
;ai_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bind =3D bind-&gt;ai_next;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (bind_local &amp;&amp; !local)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;DCO: Socket bind failed: Ad=
dress to bind lacks %s record&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr_family_name(remote-&gt;sa_f=
amily));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (remote-&gt;sa_family =3D=3D AF_INET6)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Remote.Addr6 =3D *((SOCKADDR_IN6 *)(remot=
eaddr-&gt;ai_addr));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr6 =3D *((SOCKADDR=
_IN6 *)local);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr6.sin6_addr =3D i=
n6addr_any;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr6.sin6_port =3D 0=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr6.sin6_family =3D=
 AF_INET6;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (remote-&gt;sa_family =3D=3D AF_INET)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Remote.Addr4 =3D *((SOCKADDR_IN *)(remote=
addr-&gt;ai_addr));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr4 =3D *((SOCKADDR=
_IN *)local);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr4.sin_addr =3D in=
4addr_any;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr4.sin_port =3D 0;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer.Local.Addr4.sin_family =3D =
AF_INET;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 struct tuntap tt =3D create_dco_handle(devname, gc);<br>
+<br>
+=C2=A0 =C2=A0 OVERLAPPED ov =3D { 0 };<br>
+=C2=A0 =C2=A0 if (!DeviceIoControl(tt.hand, OVPN_IOCTL_NEW_PEER, &amp;peer=
, sizeof(peer), NULL, 0, NULL, &amp;ov))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD err =3D GetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D ERROR_IO_PENDING)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;DeviceIoControl=
(OVPN_IOCTL_NEW_PEER) failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dco_connect_wait(tt.hand, &a=
mp;ov, timeout, signal_received) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close_tun_handle(&=
amp;tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return tt;<br>
+}<br>
+<br>
+int<br>
+dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr *localaddr=
, struct sockaddr *remoteaddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr *remote_in4=
, struct in6_addr *remote_in6)<br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d&quot;, __func__=
, peerid, sd);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int<br>
+dco_del_peer(dco_context_t *dco, unsigned int peerid)<br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;%s: peer-id %d - not implemented&quot=
;, __func__, peerid);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int<br>
+dco_set_peer(dco_context_t *dco, unsigned int peerid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int keepalive_interval, in=
t keepalive_timeout, int mss)<br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss =
%d&quot;, __func__,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 peerid, keepalive_interval, keepalive_timeout,=
 mss);<br>
+<br>
+=C2=A0 =C2=A0 OVPN_SET_PEER peer;<br>
+<br>
+=C2=A0 =C2=A0 peer.KeepaliveInterval =3D=C2=A0 keepalive_interval;<br>
+=C2=A0 =C2=A0 peer.KeepaliveTimeout =3D keepalive_timeout;<br>
+=C2=A0 =C2=A0 peer.MSS =3D mss;<br>
+<br>
+=C2=A0 =C2=A0 DWORD bytes_returned =3D 0;<br>
+=C2=A0 =C2=A0 if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SET_PEE=
R, &amp;peer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sizeof(peer), NULL, 0, &amp;bytes_returned, NULL))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OV=
PN_IOCTL_SET_PEER) failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int<br>
+dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dco_key_slot_t slot,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t *encrypt_key, cons=
t uint8_t *encrypt_iv,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t *decrypt_key, cons=
t uint8_t *decrypt_iv,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *ciphername)<br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, c=
ipher %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, slot, keyid, peerid, ciphername);<br>
+<br>
+=C2=A0 =C2=A0 const int nonce_len =3D 8;<br>
+=C2=A0 =C2=A0 size_t key_len =3D cipher_kt_key_size(ciphername);<br>
+<br>
+=C2=A0 =C2=A0 OVPN_CRYPTO_DATA crypto_data;<br>
+=C2=A0 =C2=A0 ZeroMemory(&amp;crypto_data, sizeof(crypto_data));<br>
+<br>
+=C2=A0 =C2=A0 crypto_data.CipherAlg =3D dco_get_cipher(ciphername);<br>
+=C2=A0 =C2=A0 crypto_data.KeyId =3D keyid;<br>
+=C2=A0 =C2=A0 crypto_data.PeerId =3D peerid;<br>
+=C2=A0 =C2=A0 crypto_data.KeySlot =3D slot;<br>
+<br>
+=C2=A0 =C2=A0 CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);<b=
r>
+=C2=A0 =C2=A0 crypto_data.Encrypt.KeyLen =3D (char)key_len;<br>
+=C2=A0 =C2=A0 CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_=
len);<br>
+<br>
+=C2=A0 =C2=A0 CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);<b=
r>
+=C2=A0 =C2=A0 crypto_data.Decrypt.KeyLen =3D (char)key_len;<br>
+=C2=A0 =C2=A0 CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_=
len);<br>
+<br>
+=C2=A0 =C2=A0 ASSERT(crypto_data.CipherAlg &gt; 0);<br>
+<br>
+=C2=A0 =C2=A0 DWORD bytes_returned =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_NEW_KEY=
, &amp;crypto_data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sizeof(crypto_data), NULL, 0, &amp;bytes_returned, NULL))<=
br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_NE=
W_KEY) failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+int<br>
+dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)<=
br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO, &quot;%s: peer-id %d, slot %d called but ignored&=
quot;, __func__, peerid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot);<br>
+=C2=A0 =C2=A0 /* FIXME: Implement in driver first */<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int<br>
+dco_swap_keys(dco_context_t *dco, unsigned int peer_id)<br>
+{<br>
+=C2=A0 =C2=A0 msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer_=
id);<br>
+<br>
+=C2=A0 =C2=A0 DWORD bytes_returned =3D 0;<br>
+=C2=A0 =C2=A0 if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SWAP_KE=
YS, NULL, 0, NULL, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;bytes_returned, NULL))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_SW=
AP_KEYS) failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+bool<br>
+dco_available(int msglevel)<br>
+{<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+int<br>
+dco_do_read(dco_context_t *dco)<br>
+{<br>
+=C2=A0 =C2=A0 /* no-op on windows */<br>
+=C2=A0 =C2=A0 ASSERT(0);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int<br>
+dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)<br>
+{<br>
+=C2=A0 =C2=A0 /* no-op on windows */<br>
+=C2=A0 =C2=A0 ASSERT(0);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+void<br>
+dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)<br>
+{<br>
+=C2=A0 =C2=A0 /* no-op on windows */<br>
+=C2=A0 =C2=A0 ASSERT(0);<br>
+}<br>
+<br>
+const char *<br>
+dco_get_supported_ciphers()<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* this API can be called either from user mode or kern=
el mode,<br>
+=C2=A0 =C2=A0 =C2=A0* which enables us to probe driver&#39;s chachapoly su=
pport<br>
+=C2=A0 =C2=A0 =C2=A0* (available starting from Windows 11)<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 BCRYPT_ALG_HANDLE h;<br>
+=C2=A0 =C2=A0 NTSTATUS status =3D BCryptOpenAlgorithmProvider(&amp;h, L&qu=
ot;CHACHA20_POLY1305&quot;, NULL, 0);<br>
+=C2=A0 =C2=A0 if (BCRYPT_SUCCESS(status))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 BCryptCloseAlgorithmProvider(h, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;AES-128-GCM:AES-256-GCM:AES-192-G=
CM:CHACHA20-POLY1305&quot;;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;AES-128-GCM:AES-256-GCM:AES-192-G=
CM&quot;;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+#endif /* defined(_WIN32) */<br>
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h<br>
new file mode 100644<br>
index 00000000..348fc568<br>
--- /dev/null<br>
+++ b/src/openvpn/dco_win.h<br>
@@ -0,0 +1,57 @@<br>
+/*<br>
+ *=C2=A0 Interface to ovpn-win-dco networking code<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020-2022 Arne Schwabe &lt;<a href=3D"mailto:arne@...220...=
..1227..." target=3D"_blank">arne@...1227...</a>&gt;<br>
+ *=C2=A0 Copyright (C) 2020-2022 OpenVPN Inc &lt;<a href=3D"mailto:sales@...220...=
..515..." target=3D"_blank">sales@...515...</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software; you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License version 2<br>
+ *=C2=A0 as published by the Free Software Foundation.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program (see the file COPYING included with this<=
br>
+ *=C2=A0 distribution); if not, write to the Free Software Foundation, Inc=
.,<br>
+ *=C2=A0 59 Temple Place, Suite 330, Boston, MA=C2=A0 02111-1307=C2=A0 USA=
<br>
+ */<br>
+<br>
+#ifndef DCO_WIN_H<br>
+#define DCO_WIN_H<br>
+<br>
+#if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32)<br>
+<br>
+#include &quot;buffer.h&quot;<br>
+#include &quot;ovpn_dco_win.h&quot;<br>
+<br>
+typedef OVPN_KEY_SLOT dco_key_slot_t;<br>
+typedef OVPN_CIPHER_ALG dco_cipher_t;<br>
+<br>
+struct dco_context {<br>
+=C2=A0 =C2=A0 struct tuntap *tt;<br>
+};<br>
+<br>
+typedef struct dco_context dco_context_t;<br>
+<br>
+struct tuntap<br>
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct addr=
info *bind, const char *devname,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gc_a=
rena *gc, int timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 volatile in=
t *signal_received);<br>
+<br>
+void<br>
+dco_start_tun(struct tuntap *tt);<br>
+<br>
+#else /* if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */<br>
+<br>
+static inline void<br>
+dco_start_tun(struct tuntap *tt)<br>
+{<br>
+=C2=A0 =C2=A0 ASSERT(false);<br>
+}<br>
+<br>
+#endif /* defined(_WIN32) */<br>
+#endif /* ifndef DCO_H */<br>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj<br>
index 0b3db7c7..ccd29cd8 100644<br>
--- a/src/openvpn/openvpn.vcxproj<br>
+++ b/src/openvpn/openvpn.vcxproj<br>
@@ -278,6 +278,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;cryptoapi.c&quot; /&gt;<b=
r>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;dco.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;dco_linux.c&quot; /&gt;<b=
r>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;dco_win.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;dhcp.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;dns.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;env_set.c&quot; /&gt;<br>
@@ -367,6 +368,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;dco.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;dco_internal.h&quot; /&gt=
;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;dco_linux.h&quot; /&gt;<b=
r>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;dco_win.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;dhcp.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;dns.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;env_set.h&quot; /&gt;<br>
@@ -402,6 +404,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;options.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;otime.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;ovpn_dco_linux.h&quot; /&=
gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;ovpn_dco_win.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;packet_id.h&quot; /&gt;<b=
r>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;perf.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;ping.h&quot; /&gt;<br>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxp=
roj.filters<br>
index 16905079..bf0ba708 100644<br>
--- a/src/openvpn/openvpn.vcxproj.filters<br>
+++ b/src/openvpn/openvpn.vcxproj.filters<br>
@@ -42,6 +42,9 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;dco_linux.c&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;dco_win.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;dhcp.c&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
@@ -314,6 +317,9 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;dco_linux.h&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;dco_win.h&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClInclude&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;dhcp.h&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>
@@ -416,6 +422,9 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;ovpn_dco_linux.h&quot;&gt=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;ovpn_dco_win.h&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClInclude&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;packet_id.h&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h<br>
new file mode 100644<br>
index 00000000..1ebd51a7<br>
--- /dev/null<br>
+++ b/src/openvpn/ovpn_dco_win.h<br>
@@ -0,0 +1,108 @@<br>
+/*<br>
+ *=C2=A0 ovpn-dco-win OpenVPN protocol accelerator for Windows<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020-2021 OpenVPN Inc &lt;<a href=3D"mailto:sales@...220...=
..515..." target=3D"_blank">sales@...515...</a>&gt;<br>
+ *<br>
+ *=C2=A0 Author:=C2=A0 =C2=A0 Lev Stipakov &lt;<a href=3D"mailto:lev@...1387...=
5..." target=3D"_blank">lev@...515...</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software; you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License version 2<br>
+ *=C2=A0 as published by the Free Software Foundation.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
 along<br>
+ *=C2=A0 with this program; if not, write to the Free Software Foundation,=
 Inc.,<br>
+ *=C2=A0 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+ *<br>
+ *=C2=A0 This particular file (uapi.h) is also licensed using the MIT lice=
nse (see COPYRIGHT.MIT).<br>
+ */<br>
+<br>
+#pragma once<br>
+#ifndef _KERNEL_MODE<br>
+#include &lt;winsock2.h&gt;<br>
+#endif<br>
+#include &lt;ws2def.h&gt;<br>
+#include &lt;ws2ipdef.h&gt;<br>
+<br>
+typedef enum {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_PROTO_UDP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_PROTO_TCP<br>
+} OVPN_PROTO;<br>
+<br>
+typedef struct _OVPN_NEW_PEER {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SOCKADDR_IN Addr4;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SOCKADDR_IN6 Addr6;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} Local;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SOCKADDR_IN Addr4;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SOCKADDR_IN6 Addr6;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} Remote;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_PROTO Proto;<br>
+} OVPN_NEW_PEER, * POVPN_NEW_PEER;<br>
+<br>
+typedef struct _OVPN_STATS {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG LostInControlPackets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG LostOutControlPackets;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG LostInDataPackets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG LostOutDataPackets;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG ReceivedDataPackets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG ReceivedControlPackets;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG SentControlPackets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG SentDataPackets;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG64 TransportBytesSent;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG64 TransportBytesReceived;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG64 TunBytesSent;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG64 TunBytesReceived;<br>
+} OVPN_STATS, * POVPN_STATS;<br>
+<br>
+typedef enum _OVPN_KEY_SLOT {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_KEY_SLOT_PRIMARY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_KEY_SLOT_SECONDARY<br>
+} OVPN_KEY_SLOT;<br>
+<br>
+typedef enum _OVPN_CIPHER_ALG {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_CIPHER_ALG_NONE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_CIPHER_ALG_AES_GCM,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_CIPHER_ALG_CHACHA20_POLY1305<br>
+} OVPN_CIPHER_ALG;<br>
+<br>
+typedef struct _OVPN_KEY_DIRECTION<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char Key[32];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char KeyLen; // 16/24/32 -&gt; AES-128=
-GCM/AES-192-GCM/AES-256-GCM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char NonceTail[8];<br>
+} OVPN_KEY_DIRECTION;<br>
+<br>
+typedef struct _OVPN_CRYPTO_DATA {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_KEY_DIRECTION Encrypt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_KEY_DIRECTION Decrypt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_KEY_SLOT KeySlot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OVPN_CIPHER_ALG CipherAlg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char KeyId;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int PeerId;<br>
+} OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;<br>
+<br>
+typedef struct _OVPN_SET_PEER {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG KeepaliveInterval;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG KeepaliveTimeout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LONG MSS;<br>
+} OVPN_SET_PEER, * POVPN_SET_PEER;<br>
+<br>
+#define OVPN_IOCTL_NEW_PEER=C2=A0 =C2=A0 =C2=A0CTL_CODE(FILE_DEVICE_UNKNOW=
N, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)<br>
+#define OVPN_IOCTL_GET_STATS=C2=A0 =C2=A0 CTL_CODE(FILE_DEVICE_UNKNOWN, 2,=
 METHOD_BUFFERED, FILE_ANY_ACCESS)<br>
+#define OVPN_IOCTL_NEW_KEY=C2=A0 =C2=A0 =C2=A0 CTL_CODE(FILE_DEVICE_UNKNOW=
N, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)<br>
+#define OVPN_IOCTL_SWAP_KEYS=C2=A0 =C2=A0 CTL_CODE(FILE_DEVICE_UNKNOWN, 4,=
 METHOD_BUFFERED, FILE_ANY_ACCESS)<br>
+#define OVPN_IOCTL_SET_PEER=C2=A0 =C2=A0 =C2=A0CTL_CODE(FILE_DEVICE_UNKNOW=
N, 5, METHOD_BUFFERED, FILE_ANY_ACCESS)<br>
+#define OVPN_IOCTL_START_VPN=C2=A0 =C2=A0 CTL_CODE(FILE_DEVICE_UNKNOWN, 6,=
 METHOD_BUFFERED, FILE_ANY_ACCESS)<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 1651eeea..93cf0301 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -6532,7 +6532,7 @@ tun_try_open_device(struct tuntap *tt, const char *de=
vice_guid, const struct dev<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-static void<br>
+void<br>
=C2=A0tun_open_device(struct tuntap *tt, const char *dev_node, const char *=
*device_guid, struct gc_arena *gc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const struct tap_reg *tap_reg =3D get_tap_reg(gc);<br>
@@ -6824,7 +6824,7 @@ netsh_delete_address_dns(const struct tuntap *tt, boo=
l ipv6, struct gc_arena *gc<br>
=C2=A0 =C2=A0 =C2=A0argv_free(&amp;argv);<br>
=C2=A0}<br>
<br>
-static void<br>
+void<br>
=C2=A0close_tun_handle(struct tuntap *tt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *adaptertype =3D print_windows_driver(tt-&gt=
;windows_driver);<br>
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<br>
index 661e4d01..de2f68fc 100644<br>
--- a/src/openvpn/tun.h<br>
+++ b/src/openvpn/tun.h<br>
@@ -48,7 +48,8 @@<br>
=C2=A0enum windows_driver_type {<br>
=C2=A0 =C2=A0 =C2=A0WINDOWS_DRIVER_UNSPECIFIED,<br>
=C2=A0 =C2=A0 =C2=A0WINDOWS_DRIVER_TAP_WINDOWS6,<br>
-=C2=A0 =C2=A0 WINDOWS_DRIVER_WINTUN<br>
+=C2=A0 =C2=A0 WINDOWS_DRIVER_WINTUN,<br>
+=C2=A0 =C2=A0 WINDOWS_DRIVER_DCO<br>
=C2=A0};<br>
=C2=A0#endif<br>
<br>
@@ -64,6 +65,8 @@ struct tuntap_options {<br>
=C2=A0 =C2=A0 =C2=A0/* --ip-win32 options */<br>
=C2=A0 =C2=A0 =C2=A0bool ip_win32_defined;<br>
<br>
+=C2=A0 =C2=A0 bool disable_dco;<br>
+<br>
=C2=A0#define IPW32_SET_MANUAL=C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0/* &=
quot;--ip-win32 manual&quot; */<br>
=C2=A0#define IPW32_SET_NETSH=C2=A0 =C2=A0 =C2=A0 =C2=A0 1=C2=A0 =C2=A0/* &=
quot;--ip-win32 netsh&quot; */<br>
=C2=A0#define IPW32_SET_IPAPI=C2=A0 =C2=A0 =C2=A0 =C2=A0 2=C2=A0 =C2=A0/* &=
quot;--ip-win32 ipapi&quot; */<br>
@@ -259,6 +262,11 @@ void open_tun(const char *dev, const char *dev_type, c=
onst char *dev_node,<br>
<br>
=C2=A0void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);<br>
<br>
+void tun_open_device(struct tuntap *tt, const char *dev_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const char **device_guid, struct gc_arena *gc);<br>
+<br>
+void close_tun_handle(struct tuntap *tt);<br>
+<br>
=C2=A0int write_tun(struct tuntap *tt, uint8_t *buf, int len);<br>
<br>
=C2=A0int read_tun(struct tuntap *tt, uint8_t *buf, int len);<br>
-- <br>
2.35.1<br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000036d2105e625ae48--

