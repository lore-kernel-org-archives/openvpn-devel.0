References: <6cf2ad26-d6e6-50a7-cb2c-d15a5ff4a198@...1856...>
 <20171112084830.22912-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3c4eb1cc-e1a3-1e7a-5f30-d4c594d4d673@...1856...>
Date: Sun, 12 Nov 2017 15:31:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171112084830.22912-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6] merge *-inline.h files with their
 main header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

On 12-11-17 09:48, Antonio Quartulli wrote:
> *-inline.h files are not very useful anymore.
> In the attempt of cleaning up the code some more,
> merge them into their main header files.
> 
> At the same time, move functions from fowrard.h
> to forward.c, when they are used only in the latter.
> 
> No functional change is part of this patch.
> 
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> v4: pf_c2c/addr_test() has been made static again
> v5: no change
> v6: move functions from forward.h to forward.c when used only by
>     the latter (as suggested by Steffan)
> 
> 
>  src/openvpn/Makefile.am             |   8 +-
>  src/openvpn/forward-inline.h        | 341 ------------------------------------
>  src/openvpn/forward.c               | 238 ++++++++++++++++++++++++-
>  src/openvpn/forward.h               |  87 ++++++++-
>  src/openvpn/init.c                  |   4 +-
>  src/openvpn/mtcp.c                  |   2 +-
>  src/openvpn/mudp.c                  |   2 +-
>  src/openvpn/multi.c                 |   4 +-
>  src/openvpn/occ-inline.h            |  95 ----------
>  src/openvpn/occ.c                   |   4 +-
>  src/openvpn/occ.h                   |  61 +++++++
>  src/openvpn/openvpn.c               |   2 -
>  src/openvpn/openvpn.h               |   2 +-
>  src/openvpn/openvpn.vcxproj         |   4 -
>  src/openvpn/openvpn.vcxproj.filters |  12 --
>  src/openvpn/pf-inline.h             |  67 -------
>  src/openvpn/pf.c                    |   2 +-
>  src/openvpn/pf.h                    |  39 +++++
>  src/openvpn/ping-inline.h           |  64 -------
>  src/openvpn/ping.c                  |   1 -
>  src/openvpn/ping.h                  |  37 ++++
>  21 files changed, 469 insertions(+), 607 deletions(-)
>  delete mode 100644 src/openvpn/forward-inline.h
>  delete mode 100644 src/openvpn/occ-inline.h
>  delete mode 100644 src/openvpn/pf-inline.h
>  delete mode 100644 src/openvpn/ping-inline.h
> 
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index fcc22d68..babc0adb 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -55,7 +55,7 @@ openvpn_SOURCES = \
>  	error.c error.h \
>  	event.c event.h \
>  	fdmisc.c fdmisc.h \
> -	forward.c forward.h forward-inline.h \
> +	forward.c forward.h \
>  	fragment.c fragment.h \
>  	gremlin.c gremlin.h \
>  	helper.c helper.h \
> @@ -80,7 +80,7 @@ openvpn_SOURCES = \
>  	mudp.c mudp.h \
>  	multi.c multi.h \
>  	ntlm.c ntlm.h \
> -	occ.c occ.h occ-inline.h \
> +	occ.c occ.h \
>  	openssl_compat.h \
>  	pkcs11.c pkcs11.h pkcs11_backend.h \
>  	pkcs11_openssl.c \
> @@ -90,8 +90,8 @@ openvpn_SOURCES = \
>  	otime.c otime.h \
>  	packet_id.c packet_id.h \
>  	perf.c perf.h \
> -	pf.c pf.h pf-inline.h \
> -	ping.c ping.h ping-inline.h \
> +	pf.c pf.h \
> +	ping.c ping.h \
>  	plugin.c plugin.h \
>  	pool.c pool.h \
>  	proto.c proto.h \
> diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
> deleted file mode 100644
> index ab83ea40..00000000
> --- a/src/openvpn/forward-inline.h
> +++ /dev/null
> @@ -1,341 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single TCP/UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - */
> -
> -#ifndef FORWARD_INLINE_H
> -#define FORWARD_INLINE_H
> -
> -/*
> - * Inline functions
> - */
> -
> -/*
> - * Does TLS session need service?
> - */
> -static inline void
> -check_tls(struct context *c)
> -{
> -#if defined(ENABLE_CRYPTO)
> -    void check_tls_dowork(struct context *c);
> -
> -    if (c->c2.tls_multi)
> -    {
> -        check_tls_dowork(c);
> -    }
> -#endif
> -}
> -
> -/*
> - * TLS errors are fatal in TCP mode.
> - * Also check for --tls-exit trigger.
> - */
> -static inline void
> -check_tls_errors(struct context *c)
> -{
> -#if defined(ENABLE_CRYPTO)
> -    void check_tls_errors_co(struct context *c);
> -
> -    void check_tls_errors_nco(struct context *c);
> -
> -    if (c->c2.tls_multi && c->c2.tls_exit_signal)
> -    {
> -        if (link_socket_connection_oriented(c->c2.link_socket))
> -        {
> -            if (c->c2.tls_multi->n_soft_errors)
> -            {
> -                check_tls_errors_co(c);
> -            }
> -        }
> -        else
> -        {
> -            if (c->c2.tls_multi->n_hard_errors)
> -            {
> -                check_tls_errors_nco(c);
> -            }
> -        }
> -    }
> -#endif /* if defined(ENABLE_CRYPTO) */
> -}
> -
> -/*
> - * Check for possible incoming configuration
> - * messages on the control channel.
> - */
> -static inline void
> -check_incoming_control_channel(struct context *c)
> -{
> -#if P2MP
> -    void check_incoming_control_channel_dowork(struct context *c);
> -
> -    if (tls_test_payload_len(c->c2.tls_multi) > 0)
> -    {
> -        check_incoming_control_channel_dowork(c);
> -    }
> -#endif
> -}
> -
> -/*
> - * Options like --up-delay need to be triggered by this function which
> - * checks for connection establishment.
> - */
> -static inline void
> -check_connection_established(struct context *c)
> -{
> -    void check_connection_established_dowork(struct context *c);
> -
> -    if (event_timeout_defined(&c->c2.wait_for_connect))
> -    {
> -        check_connection_established_dowork(c);
> -    }
> -}
> -
> -/*
> - * Should we add routes?
> - */
> -static inline void
> -check_add_routes(struct context *c)
> -{
> -    void check_add_routes_dowork(struct context *c);
> -
> -    if (event_timeout_trigger(&c->c2.route_wakeup, &c->c2.timeval, ETT_DEFAULT))
> -    {
> -        check_add_routes_dowork(c);
> -    }
> -}
> -
> -/*
> - * Should we exit due to inactivity timeout?
> - */
> -static inline void
> -check_inactivity_timeout(struct context *c)
> -{
> -    void check_inactivity_timeout_dowork(struct context *c);
> -
> -    if (c->options.inactivity_timeout
> -        && event_timeout_trigger(&c->c2.inactivity_interval, &c->c2.timeval, ETT_DEFAULT))
> -    {
> -        check_inactivity_timeout_dowork(c);
> -    }
> -}
> -
> -#if P2MP
> -
> -static inline void
> -check_server_poll_timeout(struct context *c)
> -{
> -    void check_server_poll_timeout_dowork(struct context *c);
> -
> -    if (c->options.ce.connect_timeout
> -        && event_timeout_trigger(&c->c2.server_poll_interval, &c->c2.timeval, ETT_DEFAULT))
> -    {
> -        check_server_poll_timeout_dowork(c);
> -    }
> -}
> -
> -/*
> - * Scheduled exit?
> - */
> -static inline void
> -check_scheduled_exit(struct context *c)
> -{
> -    void check_scheduled_exit_dowork(struct context *c);
> -
> -    if (event_timeout_defined(&c->c2.scheduled_exit))
> -    {
> -        if (event_timeout_trigger(&c->c2.scheduled_exit, &c->c2.timeval, ETT_DEFAULT))
> -        {
> -            check_scheduled_exit_dowork(c);
> -        }
> -    }
> -}
> -#endif /* if P2MP */
> -
> -/*
> - * Should we write timer-triggered status file.
> - */
> -static inline void
> -check_status_file(struct context *c)
> -{
> -    void check_status_file_dowork(struct context *c);
> -
> -    if (c->c1.status_output)
> -    {
> -        if (status_trigger_tv(c->c1.status_output, &c->c2.timeval))
> -        {
> -            check_status_file_dowork(c);
> -        }
> -    }
> -}
> -
> -#ifdef ENABLE_FRAGMENT
> -/*
> - * Should we deliver a datagram fragment to remote?
> - */
> -static inline void
> -check_fragment(struct context *c)
> -{
> -    void check_fragment_dowork(struct context *c);
> -
> -    if (c->c2.fragment)
> -    {
> -        check_fragment_dowork(c);
> -    }
> -}
> -#endif
> -
> -#if P2MP
> -
> -/*
> - * see if we should send a push_request in response to --pull
> - */
> -static inline void
> -check_push_request(struct context *c)
> -{
> -    void check_push_request_dowork(struct context *c);
> -
> -    if (event_timeout_trigger(&c->c2.push_request_interval, &c->c2.timeval, ETT_DEFAULT))
> -    {
> -        check_push_request_dowork(c);
> -    }
> -}
> -
> -#endif
> -
> -#ifdef ENABLE_CRYPTO
> -/*
> - * Should we persist our anti-replay packet ID state to disk?
> - */
> -static inline void
> -check_packet_id_persist_flush(struct context *c)
> -{
> -    if (packet_id_persist_enabled(&c->c1.pid_persist)
> -        && event_timeout_trigger(&c->c2.packet_id_persist_interval, &c->c2.timeval, ETT_DEFAULT))
> -    {
> -        packet_id_persist_save(&c->c1.pid_persist);
> -    }
> -}
> -#endif
> -
> -/*
> - * Set our wakeup to 0 seconds, so we will be rescheduled
> - * immediately.
> - */
> -static inline void
> -context_immediate_reschedule(struct context *c)
> -{
> -    c->c2.timeval.tv_sec = 0;  /* ZERO-TIMEOUT */
> -    c->c2.timeval.tv_usec = 0;
> -}
> -
> -static inline void
> -context_reschedule_sec(struct context *c, int sec)
> -{
> -    if (sec < 0)
> -    {
> -        sec = 0;
> -    }
> -    if (sec < c->c2.timeval.tv_sec)
> -    {
> -        c->c2.timeval.tv_sec = sec;
> -        c->c2.timeval.tv_usec = 0;
> -    }
> -}
> -
> -static inline struct link_socket_info *
> -get_link_socket_info(struct context *c)
> -{
> -    if (c->c2.link_socket_info)
> -    {
> -        return c->c2.link_socket_info;
> -    }
> -    else
> -    {
> -        return &c->c2.link_socket->info;
> -    }
> -}
> -
> -static inline void
> -register_activity(struct context *c, const int size)
> -{
> -    if (c->options.inactivity_timeout)
> -    {
> -        c->c2.inactivity_bytes += size;
> -        if (c->c2.inactivity_bytes >= c->options.inactivity_minimum_bytes)
> -        {
> -            c->c2.inactivity_bytes = 0;
> -            event_timeout_reset(&c->c2.inactivity_interval);
> -        }
> -    }
> -}
> -
> -/*
> - * Return the io_wait() flags appropriate for
> - * a point-to-point tunnel.
> - */
> -static inline unsigned int
> -p2p_iow_flags(const struct context *c)
> -{
> -    unsigned int flags = (IOW_SHAPER|IOW_CHECK_RESIDUAL|IOW_FRAG|IOW_READ|IOW_WAIT_SIGNAL);
> -    if (c->c2.to_link.len > 0)
> -    {
> -        flags |= IOW_TO_LINK;
> -    }
> -    if (c->c2.to_tun.len > 0)
> -    {
> -        flags |= IOW_TO_TUN;
> -    }
> -    return flags;
> -}
> -
> -/*
> - * This is the core I/O wait function, used for all I/O waits except
> - * for TCP in server mode.
> - */
> -static inline void
> -io_wait(struct context *c, const unsigned int flags)
> -{
> -    void io_wait_dowork(struct context *c, const unsigned int flags);
> -
> -    if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
> -    {
> -        /* fast path -- only for TUN/TAP/UDP writes */
> -        unsigned int ret = 0;
> -        if (flags & IOW_TO_TUN)
> -        {
> -            ret |= TUN_WRITE;
> -        }
> -        if (flags & (IOW_TO_LINK|IOW_MBUF))
> -        {
> -            ret |= SOCKET_WRITE;
> -        }
> -        c->c2.event_set_status = ret;
> -    }
> -    else
> -    {
> -        /* slow path */
> -        io_wait_dowork(c, flags);
> -    }
> -}
> -
> -#define CONNECTION_ESTABLISHED(c) (get_link_socket_info(c)->connection_established)
> -
> -#endif /* EVENT_INLINE_H */
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 1b7455bb..86494ecb 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -35,6 +35,9 @@
>  #include "gremlin.h"
>  #include "mss.h"
>  #include "event.h"
> +#include "occ.h"
> +#include "pf.h"
> +#include "ping.h"
>  #include "ps.h"
>  #include "dhcp.h"
>  #include "common.h"
> @@ -42,9 +45,6 @@
>  
>  #include "memdbg.h"
>  
> -#include "forward-inline.h"
> -#include "occ-inline.h"
> -#include "ping-inline.h"
>  #include "mstats.h"
>  
>  counter_type link_read_bytes_global;  /* GLOBAL */
> @@ -77,6 +77,238 @@ show_wait_status(struct context *c)
>  
>  #endif /* ifdef ENABLE_DEBUG */
>  
> +/*
> + * Does TLS session need service?
> + */
> +static inline void
> +check_tls(struct context *c)
> +{
> +#if defined(ENABLE_CRYPTO)
> +    void check_tls_dowork(struct context *c);
> +
> +    if (c->c2.tls_multi)
> +    {
> +        check_tls_dowork(c);
> +    }
> +#endif
> +}
> +
> +/*
> + * TLS errors are fatal in TCP mode.
> + * Also check for --tls-exit trigger.
> + */
> +static inline void
> +check_tls_errors(struct context *c)
> +{
> +#if defined(ENABLE_CRYPTO)
> +    void check_tls_errors_co(struct context *c);
> +
> +    void check_tls_errors_nco(struct context *c);
> +
> +    if (c->c2.tls_multi && c->c2.tls_exit_signal)
> +    {
> +        if (link_socket_connection_oriented(c->c2.link_socket))
> +        {
> +            if (c->c2.tls_multi->n_soft_errors)
> +            {
> +                check_tls_errors_co(c);
> +            }
> +        }
> +        else
> +        {
> +            if (c->c2.tls_multi->n_hard_errors)
> +            {
> +                check_tls_errors_nco(c);
> +            }
> +        }
> +    }
> +#endif /* if defined(ENABLE_CRYPTO) */
> +}
> +
> +/*
> + * Check for possible incoming configuration
> + * messages on the control channel.
> + */
> +static inline void
> +check_incoming_control_channel(struct context *c)
> +{
> +#if P2MP
> +    void check_incoming_control_channel_dowork(struct context *c);
> +
> +    if (tls_test_payload_len(c->c2.tls_multi) > 0)
> +    {
> +        check_incoming_control_channel_dowork(c);
> +    }
> +#endif
> +}
> +
> +/*
> + * Options like --up-delay need to be triggered by this function which
> + * checks for connection establishment.
> + */
> +static inline void
> +check_connection_established(struct context *c)
> +{
> +    void check_connection_established_dowork(struct context *c);
> +
> +    if (event_timeout_defined(&c->c2.wait_for_connect))
> +    {
> +        check_connection_established_dowork(c);
> +    }
> +}
> +
> +/*
> + * Should we add routes?
> + */
> +static inline void
> +check_add_routes(struct context *c)
> +{
> +    void check_add_routes_dowork(struct context *c);
> +
> +    if (event_timeout_trigger(&c->c2.route_wakeup, &c->c2.timeval, ETT_DEFAULT))
> +    {
> +        check_add_routes_dowork(c);
> +    }
> +}
> +
> +/*
> + * Should we exit due to inactivity timeout?
> + */
> +static inline void
> +check_inactivity_timeout(struct context *c)
> +{
> +    void check_inactivity_timeout_dowork(struct context *c);
> +
> +    if (c->options.inactivity_timeout
> +        && event_timeout_trigger(&c->c2.inactivity_interval, &c->c2.timeval, ETT_DEFAULT))
> +    {
> +        check_inactivity_timeout_dowork(c);
> +    }
> +}
> +
> +#if P2MP
> +
> +static inline void
> +check_server_poll_timeout(struct context *c)
> +{
> +    void check_server_poll_timeout_dowork(struct context *c);
> +
> +    if (c->options.ce.connect_timeout
> +        && event_timeout_trigger(&c->c2.server_poll_interval, &c->c2.timeval, ETT_DEFAULT))
> +    {
> +        check_server_poll_timeout_dowork(c);
> +    }
> +}
> +
> +/*
> + * Scheduled exit?
> + */
> +static inline void
> +check_scheduled_exit(struct context *c)
> +{
> +    void check_scheduled_exit_dowork(struct context *c);
> +
> +    if (event_timeout_defined(&c->c2.scheduled_exit))
> +    {
> +        if (event_timeout_trigger(&c->c2.scheduled_exit, &c->c2.timeval, ETT_DEFAULT))
> +        {
> +            check_scheduled_exit_dowork(c);
> +        }
> +    }
> +}
> +#endif /* if P2MP */
> +
> +/*
> + * Should we write timer-triggered status file.
> + */
> +static inline void
> +check_status_file(struct context *c)
> +{
> +    void check_status_file_dowork(struct context *c);
> +
> +    if (c->c1.status_output)
> +    {
> +        if (status_trigger_tv(c->c1.status_output, &c->c2.timeval))
> +        {
> +            check_status_file_dowork(c);
> +        }
> +    }
> +}
> +
> +#ifdef ENABLE_FRAGMENT
> +/*
> + * Should we deliver a datagram fragment to remote?
> + */
> +static inline void
> +check_fragment(struct context *c)
> +{
> +    void check_fragment_dowork(struct context *c);
> +
> +    if (c->c2.fragment)
> +    {
> +        check_fragment_dowork(c);
> +    }
> +}
> +#endif
> +
> +#if P2MP
> +
> +/*
> + * see if we should send a push_request in response to --pull
> + */
> +static inline void
> +check_push_request(struct context *c)
> +{
> +    void check_push_request_dowork(struct context *c);
> +
> +    if (event_timeout_trigger(&c->c2.push_request_interval, &c->c2.timeval, ETT_DEFAULT))
> +    {
> +        check_push_request_dowork(c);
> +    }
> +}
> +
> +#endif
> +
> +#ifdef ENABLE_CRYPTO
> +/*
> + * Should we persist our anti-replay packet ID state to disk?
> + */
> +static inline void
> +check_packet_id_persist_flush(struct context *c)
> +{
> +    if (packet_id_persist_enabled(&c->c1.pid_persist)
> +        && event_timeout_trigger(&c->c2.packet_id_persist_interval, &c->c2.timeval, ETT_DEFAULT))
> +    {
> +        packet_id_persist_save(&c->c1.pid_persist);
> +    }
> +}
> +#endif
> +
> +/*
> + * Set our wakeup to 0 seconds, so we will be rescheduled
> + * immediately.
> + */
> +static inline void
> +context_immediate_reschedule(struct context *c)
> +{
> +    c->c2.timeval.tv_sec = 0;  /* ZERO-TIMEOUT */
> +    c->c2.timeval.tv_usec = 0;
> +}
> +
> +static inline void
> +context_reschedule_sec(struct context *c, int sec)
> +{
> +    if (sec < 0)
> +    {
> +        sec = 0;
> +    }
> +    if (sec < c->c2.timeval.tv_sec)
> +    {
> +        c->c2.timeval.tv_sec = sec;
> +        c->c2.timeval.tv_usec = 0;
> +    }
> +}
> +
>  /*
>   * In TLS mode, let TLS level respond to any control-channel
>   * packets which were received, or prepare any packets for
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
> index 9fde5a30..6f155fce 100644
> --- a/src/openvpn/forward.h
> +++ b/src/openvpn/forward.h
> @@ -31,9 +31,8 @@
>  #ifndef FORWARD_H
>  #define FORWARD_H
>  
> -#include "openvpn.h"
> -#include "occ.h"
> -#include "ping.h"
> +/* the following macros must be defined before including any other header
> + * file */
>  
>  #define TUN_OUT(c)      (BLEN(&(c)->c2.to_tun) > 0)
>  #define LINK_OUT(c)     (BLEN(&(c)->c2.to_link) > 0)
> @@ -47,6 +46,10 @@
>  
>  #define TO_LINK_DEF(c)  (LINK_OUT(c) || TO_LINK_FRAG(c))
>  
> +#include "openvpn.h"
> +#include "occ.h"
> +#include "ping.h"
> +
>  #define IOW_TO_TUN          (1<<0)
>  #define IOW_TO_LINK         (1<<1)
>  #define IOW_READ_TUN        (1<<2)
> @@ -262,4 +265,82 @@ void schedule_exit(struct context *c, const int n_seconds, const int signal);
>  
>  #endif
>  
> +static inline struct link_socket_info *
> +get_link_socket_info(struct context *c)
> +{
> +    if (c->c2.link_socket_info)
> +    {
> +        return c->c2.link_socket_info;
> +    }
> +    else
> +    {
> +        return &c->c2.link_socket->info;
> +    }
> +}
> +
> +static inline void
> +register_activity(struct context *c, const int size)
> +{
> +    if (c->options.inactivity_timeout)
> +    {
> +        c->c2.inactivity_bytes += size;
> +        if (c->c2.inactivity_bytes >= c->options.inactivity_minimum_bytes)
> +        {
> +            c->c2.inactivity_bytes = 0;
> +            event_timeout_reset(&c->c2.inactivity_interval);
> +        }
> +    }
> +}
> +
> +/*
> + * Return the io_wait() flags appropriate for
> + * a point-to-point tunnel.
> + */
> +static inline unsigned int
> +p2p_iow_flags(const struct context *c)
> +{
> +    unsigned int flags = (IOW_SHAPER|IOW_CHECK_RESIDUAL|IOW_FRAG|IOW_READ|IOW_WAIT_SIGNAL);
> +    if (c->c2.to_link.len > 0)
> +    {
> +        flags |= IOW_TO_LINK;
> +    }
> +    if (c->c2.to_tun.len > 0)
> +    {
> +        flags |= IOW_TO_TUN;
> +    }
> +    return flags;
> +}
> +
> +/*
> + * This is the core I/O wait function, used for all I/O waits except
> + * for TCP in server mode.
> + */
> +static inline void
> +io_wait(struct context *c, const unsigned int flags)
> +{
> +    void io_wait_dowork(struct context *c, const unsigned int flags);
> +
> +    if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
> +    {
> +        /* fast path -- only for TUN/TAP/UDP writes */
> +        unsigned int ret = 0;
> +        if (flags & IOW_TO_TUN)
> +        {
> +            ret |= TUN_WRITE;
> +        }
> +        if (flags & (IOW_TO_LINK|IOW_MBUF))
> +        {
> +            ret |= SOCKET_WRITE;
> +        }
> +        c->c2.event_set_status = ret;
> +    }
> +    else
> +    {
> +        /* slow path */
> +        io_wait_dowork(c, flags);
> +    }
> +}
> +
> +#define CONNECTION_ESTABLISHED(c) (get_link_socket_info(c)->connection_established)
> +
>  #endif /* FORWARD_H */
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 1ed2c55e..2e34f547 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -41,6 +41,7 @@
>  #include "otime.h"
>  #include "pool.h"
>  #include "gremlin.h"
> +#include "occ.h"
>  #include "pkcs11.h"
>  #include "ps.h"
>  #include "lladdr.h"
> @@ -48,11 +49,10 @@
>  #include "mstats.h"
>  #include "ssl_verify.h"
>  #include "tls_crypt.h"
> -#include "forward-inline.h"
> +#include "forward.h"
>  
>  #include "memdbg.h"
>  
> -#include "occ-inline.h"
>  
>  static struct context *static_context; /* GLOBAL */
>  
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
> index 3cb52113..015d6b89 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -32,7 +32,7 @@
>  #if P2MP_SERVER
>  
>  #include "multi.h"
> -#include "forward-inline.h"
> +#include "forward.h"
>  
>  #include "memdbg.h"
>  
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index eb28ca2b..a4cd6bf8 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -33,7 +33,7 @@
>  
>  #include "multi.h"
>  #include <inttypes.h>
> -#include "forward-inline.h"
> +#include "forward.h"
>  
>  #include "memdbg.h"
>  
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 5c2c8e69..a97eed6e 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -36,10 +36,12 @@
>  
>  #if P2MP_SERVER
>  
> +#include "forward.h"
>  #include "multi.h"
>  #include "push.h"
>  #include "misc.h"
>  #include "otime.h"
> +#include "pf.h"
>  #include "gremlin.h"
>  #include "mstats.h"
>  #include "ssl_verify.h"
> @@ -47,8 +49,6 @@
>  
>  #include "memdbg.h"
>  
> -#include "forward-inline.h"
> -#include "pf-inline.h"
>  
>  /*#define MULTI_DEBUG_EVENT_LOOP*/
>  
> diff --git a/src/openvpn/occ-inline.h b/src/openvpn/occ-inline.h
> deleted file mode 100644
> index 0fa8e5ba..00000000
> --- a/src/openvpn/occ-inline.h
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single TCP/UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - */
> -
> -#ifndef OCC_INLINE_H
> -#define OCC_INLINE_H
> -
> -#ifdef ENABLE_OCC
> -
> -/*
> - * Inline functions
> - */
> -
> -static inline int
> -occ_reset_op(void)
> -{
> -    return -1;
> -}
> -
> -/*
> - * Should we send an OCC_REQUEST message?
> - */
> -static inline void
> -check_send_occ_req(struct context *c)
> -{
> -    void check_send_occ_req_dowork(struct context *c);
> -
> -    if (event_timeout_defined(&c->c2.occ_interval)
> -        && event_timeout_trigger(&c->c2.occ_interval,
> -                                 &c->c2.timeval,
> -                                 (!TO_LINK_DEF(c) && c->c2.occ_op < 0) ? ETT_DEFAULT : 0))
> -    {
> -        check_send_occ_req_dowork(c);
> -    }
> -}
> -
> -/*
> - * Should we send an MTU load test?
> - */
> -static inline void
> -check_send_occ_load_test(struct context *c)
> -{
> -    void check_send_occ_load_test_dowork(struct context *c);
> -
> -    if (event_timeout_defined(&c->c2.occ_mtu_load_test_interval)
> -        && event_timeout_trigger(&c->c2.occ_mtu_load_test_interval,
> -                                 &c->c2.timeval,
> -                                 (!TO_LINK_DEF(c) && c->c2.occ_op < 0) ? ETT_DEFAULT : 0))
> -    {
> -        check_send_occ_load_test_dowork(c);
> -    }
> -}
> -
> -/*
> - * Should we send an OCC message?
> - */
> -static inline void
> -check_send_occ_msg(struct context *c)
> -{
> -    void check_send_occ_msg_dowork(struct context *c);
> -
> -    if (c->c2.occ_op >= 0)
> -    {
> -        if (!TO_LINK_DEF(c))
> -        {
> -            check_send_occ_msg_dowork(c);
> -        }
> -        else
> -        {
> -            tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
> -        }
> -    }
> -}
> -
> -#endif /* ifdef ENABLE_OCC */
> -#endif /* ifndef OCC_INLINE_H */
> diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
> index 40f7e768..5bec2b15 100644
> --- a/src/openvpn/occ.c
> +++ b/src/openvpn/occ.c
> @@ -32,11 +32,9 @@
>  #ifdef ENABLE_OCC
>  
>  #include "occ.h"
> -
> +#include "forward.h"
>  #include "memdbg.h"
>  
> -#include "forward-inline.h"
> -#include "occ-inline.h"
>  
>  /*
>   * This random string identifies an OpenVPN
> diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
> index 12d7bc57..369ebac4 100644
> --- a/src/openvpn/occ.h
> +++ b/src/openvpn/occ.h
> @@ -90,5 +90,66 @@ is_occ_msg(const struct buffer *buf)
>  
>  void process_received_occ_msg(struct context *c);
>  
> +static inline int
> +occ_reset_op(void)
> +{
> +    return -1;
> +}
> +
> +/*
> + * Should we send an OCC_REQUEST message?
> + */
> +static inline void
> +check_send_occ_req(struct context *c)
> +{
> +    void check_send_occ_req_dowork(struct context *c);
> +
> +    if (event_timeout_defined(&c->c2.occ_interval)
> +        && event_timeout_trigger(&c->c2.occ_interval,
> +                                 &c->c2.timeval,
> +                                 (!TO_LINK_DEF(c) && c->c2.occ_op < 0) ? ETT_DEFAULT : 0))
> +    {
> +        check_send_occ_req_dowork(c);
> +    }
> +}
> +
> +/*
> + * Should we send an MTU load test?
> + */
> +static inline void
> +check_send_occ_load_test(struct context *c)
> +{
> +    void check_send_occ_load_test_dowork(struct context *c);
> +
> +    if (event_timeout_defined(&c->c2.occ_mtu_load_test_interval)
> +        && event_timeout_trigger(&c->c2.occ_mtu_load_test_interval,
> +                                 &c->c2.timeval,
> +                                 (!TO_LINK_DEF(c) && c->c2.occ_op < 0) ? ETT_DEFAULT : 0))
> +    {
> +        check_send_occ_load_test_dowork(c);
> +    }
> +}
> +
> +/*
> + * Should we send an OCC message?
> + */
> +static inline void
> +check_send_occ_msg(struct context *c)
> +{
> +    void check_send_occ_msg_dowork(struct context *c);
> +
> +    if (c->c2.occ_op >= 0)
> +    {
> +        if (!TO_LINK_DEF(c))
> +        {
> +            check_send_occ_msg_dowork(c);
> +        }
> +        else
> +        {
> +            tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
> +        }
> +    }
> +}
> +
>  #endif /* ifdef ENABLE_OCC */
>  #endif /* ifndef OCC_H */
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index e237ee50..d25bc093 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -37,8 +37,6 @@
>  
>  #include "memdbg.h"
>  
> -#include "forward-inline.h"
> -
>  #define P2P_CHECK_SIG() EVENT_LOOP_CHECK_SIGNAL(c, process_signal_p2p, c);
>  
>  static bool
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 9262e68b..a7e133d9 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -42,10 +42,10 @@
>  #include "sig.h"
>  #include "misc.h"
>  #include "mbuf.h"
> +#include "pf.h"
>  #include "pool.h"
>  #include "plugin.h"
>  #include "manage.h"
> -#include "pf.h"
>  
>  /*
>   * Our global key schedules, packaged thusly
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index d1c0fdec..30cceb34 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -193,7 +193,6 @@
>      <ClInclude Include="error.h" />
>      <ClInclude Include="event.h" />
>      <ClInclude Include="fdmisc.h" />
> -    <ClInclude Include="forward-inline.h" />
>      <ClInclude Include="forward.h" />
>      <ClInclude Include="fragment.h" />
>      <ClInclude Include="gremlin.h" />
> @@ -217,16 +216,13 @@
>      <ClInclude Include="mudp.h" />
>      <ClInclude Include="multi.h" />
>      <ClInclude Include="ntlm.h" />
> -    <ClInclude Include="occ-inline.h" />
>      <ClInclude Include="occ.h" />
>      <ClInclude Include="openvpn.h" />
>      <ClInclude Include="options.h" />
>      <ClInclude Include="otime.h" />
>      <ClInclude Include="packet_id.h" />
>      <ClInclude Include="perf.h" />
> -    <ClInclude Include="pf-inline.h" />
>      <ClInclude Include="pf.h" />
> -    <ClInclude Include="ping-inline.h" />
>      <ClInclude Include="ping.h" />
>      <ClInclude Include="pkcs11.h" />
>      <ClInclude Include="pkcs11_backend.h" />
> diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
> index 30df5ec2..4152236d 100644
> --- a/src/openvpn/openvpn.vcxproj.filters
> +++ b/src/openvpn/openvpn.vcxproj.filters
> @@ -284,9 +284,6 @@
>      <ClInclude Include="fdmisc.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> -    <ClInclude Include="forward-inline.h">
> -      <Filter>Header Files</Filter>
> -    </ClInclude>
>      <ClInclude Include="forward.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> @@ -356,9 +353,6 @@
>      <ClInclude Include="ntlm.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> -    <ClInclude Include="occ-inline.h">
> -      <Filter>Header Files</Filter>
> -    </ClInclude>
>      <ClInclude Include="occ.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> @@ -377,15 +371,9 @@
>      <ClInclude Include="perf.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> -    <ClInclude Include="pf-inline.h">
> -      <Filter>Header Files</Filter>
> -    </ClInclude>
>      <ClInclude Include="pf.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> -    <ClInclude Include="ping-inline.h">
> -      <Filter>Header Files</Filter>
> -    </ClInclude>
>      <ClInclude Include="ping.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
> deleted file mode 100644
> index 3ba90ccf..00000000
> --- a/src/openvpn/pf-inline.h
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single TCP/UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - */
> -
> -#if defined(ENABLE_PF) && !defined(PF_INLINE_H)
> -#define PF_INLINE_H
> -
> -/*
> - * Inline functions
> - */
> -
> -#define PCT_SRC  1
> -#define PCT_DEST 2
> -static inline bool
> -pf_c2c_test(const struct pf_context *src_pf, const struct tls_multi *src,
> -            const struct pf_context *dest_pf, const struct tls_multi *dest,
> -            const char *prefix)
> -{
> -    bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type, const char *prefix);
> -
> -    return (!src_pf->enabled || pf_cn_test(src_pf->pfs, dest, PCT_DEST, prefix))
> -           && (!dest_pf->enabled || pf_cn_test(dest_pf->pfs, src, PCT_SRC,
> -                                               prefix));
> -}
> -
> -static inline bool
> -pf_addr_test(const struct pf_context *src_pf, const struct context *src,
> -             const struct mroute_addr *dest, const char *prefix)
> -{
> -    bool pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest, const char *prefix);
> -
> -    if (src_pf->enabled)
> -    {
> -        return pf_addr_test_dowork(src, dest, prefix);
> -    }
> -    else
> -    {
> -        return true;
> -    }
> -}
> -
> -static inline bool
> -pf_kill_test(const struct pf_set *pfs)
> -{
> -    return pfs->kill;
> -}
> -
> -#endif /* if defined(ENABLE_PF) && !defined(PF_INLINE_H) */
> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 5cb002bf..12eeb2d0 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -35,9 +35,9 @@
>  
>  #include "init.h"
>  #include "memdbg.h"
> +#include "pf.h"
>  #include "ssl_verify.h"
>  
> -#include "pf-inline.h"
>  
>  static void
>  pf_destroy(struct pf_set *pfs)
> diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
> index 414c85b8..a53ea7e4 100644
> --- a/src/openvpn/pf.h
> +++ b/src/openvpn/pf.h
> @@ -31,6 +31,9 @@
>  
>  #define PF_MAX_LINE_LEN 256
>  
> +#define PCT_SRC  1
> +#define PCT_DEST 2
> +
>  struct context;
>  
>  struct ipv4_subnet {
> @@ -101,4 +104,40 @@ void pf_context_print(const struct pf_context *pfc, const char *prefix, const in
>  
>  #endif
>  
> +bool pf_addr_test_dowork(const struct context *src,
> +                         const struct mroute_addr *dest, const char *prefix);
> +
> +static inline bool
> +pf_addr_test(const struct pf_context *src_pf, const struct context *src,
> +             const struct mroute_addr *dest, const char *prefix)
> +{
> +    if (src_pf->enabled)
> +    {
> +        return pf_addr_test_dowork(src, dest, prefix);
> +    }
> +    else
> +    {
> +        return true;
> +    }
> +}
> +
> +bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type,
> +                const char *prefix);
> +
> +static inline bool
> +pf_c2c_test(const struct pf_context *src_pf, const struct tls_multi *src,
> +            const struct pf_context *dest_pf, const struct tls_multi *dest,
> +            const char *prefix)
> +{
> +    return (!src_pf->enabled || pf_cn_test(src_pf->pfs, dest, PCT_DEST, prefix))
> +           && (!dest_pf->enabled || pf_cn_test(dest_pf->pfs, src, PCT_SRC,
> +                                               prefix));
> +}
> +
> +static inline bool
> +pf_kill_test(const struct pf_set *pfs)
> +{
> +    return pfs->kill;
> +}
> +
>  #endif /* if defined(ENABLE_PF) && !defined(OPENVPN_PF_H) */
> diff --git a/src/openvpn/ping-inline.h b/src/openvpn/ping-inline.h
> deleted file mode 100644
> index 0642b851..00000000
> --- a/src/openvpn/ping-inline.h
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single TCP/UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - */
> -
> -#ifndef PING_INLINE_H
> -#define PING_INLINE_H
> -
> -/*
> - * Should we exit or restart due to ping (or other authenticated packet)
> - * not received in n seconds?
> - */
> -static inline void
> -check_ping_restart(struct context *c)
> -{
> -    void check_ping_restart_dowork(struct context *c);
> -
> -    if (c->options.ping_rec_timeout
> -        && event_timeout_trigger(&c->c2.ping_rec_interval,
> -                                 &c->c2.timeval,
> -                                 (!c->options.ping_timer_remote
> -                                  || link_socket_actual_defined(&c->c1.link_socket_addr.actual))
> -                                 ? ETT_DEFAULT : 15))
> -    {
> -        check_ping_restart_dowork(c);
> -    }
> -}
> -
> -/*
> - * Should we ping the remote?
> - */
> -static inline void
> -check_ping_send(struct context *c)
> -{
> -    void check_ping_send_dowork(struct context *c);
> -
> -    if (c->options.ping_send_timeout
> -        && event_timeout_trigger(&c->c2.ping_send_interval,
> -                                 &c->c2.timeval,
> -                                 !TO_LINK_DEF(c) ? ETT_DEFAULT : 1))
> -    {
> -        check_ping_send_dowork(c);
> -    }
> -}
> -
> -#endif /* ifndef PING_INLINE_H */
> diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
> index 728d6c2a..10cd5a5e 100644
> --- a/src/openvpn/ping.c
> +++ b/src/openvpn/ping.c
> @@ -33,7 +33,6 @@
>  
>  #include "memdbg.h"
>  
> -#include "ping-inline.h"
>  
>  /*
>   * This random string identifies an OpenVPN ping packet.
> diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
> index 5bd5c089..9c5ef8e1 100644
> --- a/src/openvpn/ping.h
> +++ b/src/openvpn/ping.h
> @@ -43,4 +43,41 @@ is_ping_msg(const struct buffer *buf)
>      return buf_string_match(buf, ping_string, PING_STRING_SIZE);
>  }
>  
> +/*
> + * Should we exit or restart due to ping (or other authenticated packet)
> + * not received in n seconds?
> + */
> +static inline void
> +check_ping_restart(struct context *c)
> +{
> +    void check_ping_restart_dowork(struct context *c);
> +
> +    if (c->options.ping_rec_timeout
> +        && event_timeout_trigger(&c->c2.ping_rec_interval,
> +                                 &c->c2.timeval,
> +                                 (!c->options.ping_timer_remote
> +                                  || link_socket_actual_defined(&c->c1.link_socket_addr.actual))
> +                                 ? ETT_DEFAULT : 15))
> +    {
> +        check_ping_restart_dowork(c);
> +    }
> +}
> +
> +/*
> + * Should we ping the remote?
> + */
> +static inline void
> +check_ping_send(struct context *c)
> +{
> +    void check_ping_send_dowork(struct context *c);
> +
> +    if (c->options.ping_send_timeout
> +        && event_timeout_trigger(&c->c2.ping_send_interval,
> +                                 &c->c2.timeval,
> +                                 !TO_LINK_DEF(c) ? ETT_DEFAULT : 1))
> +    {
> +        check_ping_send_dowork(c);
> +    }
> +}
> +
>  #endif
> 

This looks good now.

Tested-by: Steffan Karger <steffan@...1856...>
Reviewed-by: Steffan Karger <steffan@...1856...>
Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

