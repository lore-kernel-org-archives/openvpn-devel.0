From: Simon Rozman <simon@...2293...>
Date: Tue, 17 Dec 2019 13:10:49 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10D05C9401@...2294...>
References: <20191216105608.395-1-lstipakov@...277...>
 <20191217124410.81-1-lstipakov@...277...>
In-Reply-To: <20191217124410.81-1-lstipakov@...277...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=2.16.840.1.101.3.4.2.1;
 protocol="application/x-pkcs7-signature";
 boundary="----=_NextPart_000_0020_01D5B4E3.C7C8F730"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v8 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

------=_NextPart_000_0020_01D5B4E3.C7C8F730
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have stare-reviewed the code, then run it back and forth with different
config files. Works as advertised.

Note that this patch contains controversial impersonate_as_system() which we
will remove or #ifdef in the patches to follow.

Acked-By: Simon Rozman <simon@...2293...>

Best regards,
Simon

> -----Original Message-----
> From: Lev Stipakov <lstipakov@...277...>
> Sent: Tuesday, December 17, 2019 1:44 PM
> To: openvpn-devel@lists.sourceforge.net
> Cc: Lev Stipakov <lev@...515...>
> Subject: [Openvpn-devel] [PATCH v8 4/7] wintun: ring buffers based I/O
> 
> From: Lev Stipakov <lev@...515...>
> 
> Implemented according to Wintun documentation and reference client code.
> 
> Wintun uses ring buffers to communicate between kernel driver and user
> process. Client allocates send and receive ring buffers, creates events
> and passes it to kernel driver under LocalSystem privileges.
> 
> When data is available for read, wintun modifies "tail" pointer of send
> ring and signals via event.
> User process reads data from "head" to "tail" and updates "head"
> pointer.
> 
> When user process is ready to write, it writes to receive ring, updates
> "tail" pointer and signals to kernel via event.
> 
> In openvpn code we add send ring's event to event loop.
> Before performing io wait, we compare "head" and "tail"
> pointers of send ring and if they're different, we skip io wait and
> perform read.
> 
> This also adds ring buffers support to tcp and udp server code.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> 
>  v8:
>   - make DeviceIoControl result check more robust
>   - fix struct tun_ring layout
> 
>  v7:
>   - fix comments (no code changes)
> 
>  v6:
>   - added a sanity check to write_wintun() to avoid
>     writing malformed IPv4/6 packet, which causes
>     "ring buffer is out of capacity" error.
> 
>  v5:
>   - fix crash at ring buffer registration on Win7
>     (passing NULL to DeviceIOControl, reported by kitsune1)
> 
>  v4:
>   - added helper function tuntap_ring_empty()
>   - refactored event handling, got rid of separate
>     event_ctl() call for wintun and send/receive_tail_moved
>     members
>   - added wintun_ prefix for ring buffer variables
>   - added a comment explaining the size of wintun-specific buffers
> 
>  v3:
>   - simplified convoluted #ifdefs
>   - replaced "greater than" with "greater or equal than"
> 
>  v2:
>   - rebased on top of master
> 
>  src/openvpn/forward.c |  29 +++++++-
>  src/openvpn/forward.h |  38 +++++++++-
>  src/openvpn/mtcp.c    |  19 ++++-
>  src/openvpn/mudp.c    |   7 +-
>  src/openvpn/options.c |   4 +-
>  src/openvpn/syshead.h |   1 +
>  src/openvpn/tun.c     |  62 +++++++++++++++-
>  src/openvpn/tun.h     | 169 +++++++++++++++++++++++++++++++++++++++++-
>  src/openvpn/win32.c   | 122 ++++++++++++++++++++++++++++++
>  src/openvpn/win32.h   |  50 +++++++++++++
>  10 files changed, 490 insertions(+), 11 deletions(-)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c index
> 8451706b..6b823613 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1256,8 +1256,24 @@ read_incoming_tun(struct context *c)
>      perf_push(PERF_READ_IN_TUN);
> 
>      c->c2.buf = c->c2.buffers->read_tun_buf;
> +
>  #ifdef _WIN32
> -    read_tun_buffered(c->c1.tuntap, &c->c2.buf);
> +    if (c->c1.tuntap->wintun)
> +    {
> +        read_wintun(c->c1.tuntap, &c->c2.buf);
> +        if (c->c2.buf.len == -1)
> +        {
> +            register_signal(c, SIGHUP, "tun-abort");
> +            c->persist.restart_sleep_seconds = 1;
> +            msg(M_INFO, "Wintun read error, restarting");
> +            perf_pop();
> +            return;
> +        }
> +    }
> +    else
> +    {
> +        read_tun_buffered(c->c1.tuntap, &c->c2.buf);
> +    }
>  #else
>      ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
>      ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame))); @@ -
> 2099,6 +2115,17 @@ io_wait_dowork(struct context *c, const unsigned int
> flags)
>          tuntap |= EVENT_READ;
>      }
> 
> +#ifdef _WIN32
> +    if (tuntap_is_wintun(c->c1.tuntap))
> +    {
> +        /*
> +         * With wintun we are only interested in read event. Ring
> buffer is
> +         * always ready for write, so we don't do wait.
> +         */
> +        tuntap = EVENT_READ;
> +    }
> +#endif
> +
>      /*
>       * Configure event wait based on socket, tuntap flags.
>       */
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h index
> 48202c07..b711ff00 100644
> --- a/src/openvpn/forward.h
> +++ b/src/openvpn/forward.h
> @@ -375,6 +375,12 @@ p2p_iow_flags(const struct context *c)
>      {
>          flags |= IOW_TO_TUN;
>      }
> +#ifdef _WIN32
> +    if (tuntap_ring_empty(c->c1.tuntap))
> +    {
> +        flags &= ~IOW_READ_TUN;
> +    }
> +#endif
>      return flags;
>  }
> 
> @@ -403,8 +409,36 @@ io_wait(struct context *c, const unsigned int
> flags)
>      }
>      else
>      {
> -        /* slow path */
> -        io_wait_dowork(c, flags);
> +#ifdef _WIN32
> +        bool skip_iowait = flags & IOW_TO_TUN;
> +        if (flags & IOW_READ_TUN)
> +        {
> +            /*
> +             * don't read from tun if we have pending write to link,
> +             * since every tun read overwrites to_link buffer filled
> +             * by previous tun read
> +             */
> +            skip_iowait = !(flags & IOW_TO_LINK);
> +        }
> +        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
> +        {
> +            unsigned int ret = 0;
> +            if (flags & IOW_TO_TUN)
> +            {
> +                ret |= TUN_WRITE;
> +            }
> +            if (flags & IOW_READ_TUN)
> +            {
> +                ret |= TUN_READ;
> +            }
> +            c->c2.event_set_status = ret;
> +        }
> +        else
> +#endif
> +        {
> +            /* slow path */
> +            io_wait_dowork(c, flags);
> +        }
>      }
>  }
> 
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c index
> abe20593..ee28a710 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -269,8 +269,25 @@ multi_tcp_wait(const struct context *c,
>                 struct multi_tcp *mtcp)
>  {
>      int status;
> +    unsigned int *persistent = &mtcp->tun_rwflags;
>      socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
> MTCP_SOCKET);
> -    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp-
> >tun_rwflags);
> +
> +#ifdef _WIN32
> +    if (tuntap_is_wintun(c->c1.tuntap))
> +    {
> +        if (!tuntap_ring_empty(c->c1.tuntap))
> +        {
> +            /* there is data in wintun ring buffer, read it immediately
> */
> +            mtcp->esr[0].arg = MTCP_TUN;
> +            mtcp->esr[0].rwflags = EVENT_READ;
> +            mtcp->n_esr = 1;
> +            return 1;
> +        }
> +        persistent = NULL;
> +    }
> +#endif
> +    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
> +
>  #ifdef ENABLE_MANAGEMENT
>      if (management)
>      {
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c index
> b7f061a2..6a29ccc8 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -278,7 +278,12 @@ p2mp_iow_flags(const struct multi_context *m)
>      {
>          flags |= IOW_READ;
>      }
> -
> +#ifdef _WIN32
> +    if (tuntap_ring_empty(m->top.c1.tuntap))
> +    {
> +        flags &= ~IOW_READ_TUN;
> +    }
> +#endif
>      return flags;
>  }
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
> 49affc29..cebcbb07 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3016,10 +3016,10 @@ options_postprocess_mutate_invariant(struct
> options *options)
>          options->ifconfig_noexec = false;
>      }
> 
> -    /* for wintun kernel doesn't send DHCP requests, so use ipapi to
> set IP address and netmask */
> +    /* for wintun kernel doesn't send DHCP requests, so use netsh to
> + set IP address and netmask */
>      if (options->wintun)
>      {
> -        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
> +        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
>      }
> 
>      remap_redirect_gateway_flags(options);
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h index
> 899aa59e..e9accb52 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -39,6 +39,7 @@
>  #ifdef _WIN32
>  #include <windows.h>
>  #include <winsock2.h>
> +#include <tlhelp32.h>
>  #define sleep(x) Sleep((x)*1000)
>  #define random rand
>  #define srandom srand
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c index
> 599fd817..3f66b216 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -775,9 +775,27 @@ init_tun_post(struct tuntap *tt,  #ifdef _WIN32
>      overlapped_io_init(&tt->reads, frame, FALSE, true);
>      overlapped_io_init(&tt->writes, frame, TRUE, true);
> -    tt->rw_handle.read = tt->reads.overlapped.hEvent;
> -    tt->rw_handle.write = tt->writes.overlapped.hEvent;
>      tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
> +
> +    if (tt->wintun)
> +    {
> +        tt->wintun_send_ring = malloc(sizeof(struct tun_ring));
> +        tt->wintun_receive_ring = malloc(sizeof(struct tun_ring));
> +        if ((tt->wintun_send_ring == NULL) || (tt->wintun_receive_ring
> == NULL))
> +        {
> +            msg(M_FATAL, "Cannot allocate memory for ring buffer");
> +        }
> +        ZeroMemory(tt->wintun_send_ring, sizeof(struct tun_ring));
> +        ZeroMemory(tt->wintun_receive_ring, sizeof(struct tun_ring));
> +
> +        tt->rw_handle.read = CreateEvent(NULL, FALSE, FALSE, NULL);
> +        tt->rw_handle.write = CreateEvent(NULL, FALSE, FALSE, NULL);
> +    }
> +    else
> +    {
> +        tt->rw_handle.read = tt->reads.overlapped.hEvent;
> +        tt->rw_handle.write = tt->writes.overlapped.hEvent;
> +    }
>  #endif
>  }
> 
> @@ -6177,6 +6195,34 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>              tt->ipapi_context_defined = true;
>          }
>      }
> +
> +    if (tt->wintun)
> +    {
> +        if (tt->options.msg_channel)
> +        {
> +            /* TODO */
> +        }
> +        else
> +        {
> +            if (!impersonate_as_system())
> +            {
> +                msg(M_FATAL, "ERROR:  Failed to impersonate as SYSTEM,
> make sure process is running under privileged account");
> +            }
> +            if (!register_ring_buffers(tt->hand,
> +                                       tt->wintun_send_ring,
> +                                       tt->wintun_receive_ring,
> +                                       tt->rw_handle.read,
> +                                       tt->rw_handle.write))
> +            {
> +                msg(M_FATAL, "ERROR:  Failed to register ring buffers:
> %lu", GetLastError());
> +            }
> +            if (!RevertToSelf())
> +            {
> +                msg(M_FATAL, "ERROR:  RevertToSelf error: %lu",
> GetLastError());
> +            }
> +        }
> +    }
> +
>      /*netcmd_semaphore_release ();*/
>      gc_free(&gc);
>  }
> @@ -6315,6 +6361,18 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t
> *ctx)
>          free(tt->actual_name);
>      }
> 
> +    if (tt->wintun)
> +    {
> +        CloseHandle(tt->rw_handle.read);
> +        CloseHandle(tt->rw_handle.write);
> +    }
> +
> +    free(tt->wintun_receive_ring);
> +    free(tt->wintun_send_ring);
> +
> +    tt->wintun_receive_ring = NULL;
> +    tt->wintun_send_ring = NULL;
> +
>      clear_tuntap(tt);
>      free(tt);
>      gc_free(&gc);
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h index
> 66b75d93..10f687c5 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -182,6 +182,9 @@ struct tuntap
> 
>      bool wintun; /* true if wintun is used instead of tap-windows6 */
>      int standby_iter;
> +
> +    struct tun_ring *wintun_send_ring;
> +    struct tun_ring *wintun_receive_ring;
>  #else  /* ifdef _WIN32 */
>      int fd; /* file descriptor for TUN/TAP dev */  #endif @@ -211,6
> +214,20 @@ tuntap_defined(const struct tuntap *tt)  #endif  }
> 
> +#ifdef _WIN32
> +inline bool
> +tuntap_is_wintun(struct tuntap *tt)
> +{
> +    return tt && tt->wintun;
> +}
> +
> +inline bool
> +tuntap_ring_empty(struct tuntap *tt)
> +{
> +    return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head ==
> +tt->wintun_send_ring->tail); } #endif
> +
>  /*
>   * Function prototypes
>   */
> @@ -478,10 +495,158 @@ read_tun_buffered(struct tuntap *tt, struct
> buffer *buf)
>      return tun_finalize(tt->hand, &tt->reads, buf);  }
> 
> +static inline ULONG
> +wintun_ring_packet_align(ULONG size)
> +{
> +    return (size + (WINTUN_PACKET_ALIGN - 1)) & ~(WINTUN_PACKET_ALIGN -
> +1); }
> +
> +static inline ULONG
> +wintun_ring_wrap(ULONG value)
> +{
> +    return value & (WINTUN_RING_CAPACITY - 1); }
> +
> +static inline void
> +read_wintun(struct tuntap *tt, struct buffer* buf) {
> +    struct tun_ring *ring = tt->wintun_send_ring;
> +    ULONG head = ring->head;
> +    ULONG tail = ring->tail;
> +    ULONG content_len;
> +    struct TUN_PACKET *packet;
> +    ULONG aligned_packet_size;
> +
> +    *buf = tt->reads.buf_init;
> +    buf->len = 0;
> +
> +    if ((head >= WINTUN_RING_CAPACITY) || (tail >=
> WINTUN_RING_CAPACITY))
> +    {
> +        msg(M_INFO, "Wintun: ring capacity exceeded");
> +        buf->len = -1;
> +        return;
> +    }
> +
> +    if (head == tail)
> +    {
> +        /* nothing to read */
> +        return;
> +    }
> +
> +    content_len = wintun_ring_wrap(tail - head);
> +    if (content_len < sizeof(struct TUN_PACKET_HEADER))
> +    {
> +        msg(M_INFO, "Wintun: incomplete packet header in send ring");
> +        buf->len = -1;
> +        return;
> +    }
> +
> +    packet = (struct TUN_PACKET *) &ring->data[head];
> +    if (packet->size > WINTUN_MAX_PACKET_SIZE)
> +    {
> +        msg(M_INFO, "Wintun: packet too big in send ring");
> +        buf->len = -1;
> +        return;
> +    }
> +
> +    aligned_packet_size = wintun_ring_packet_align(sizeof(struct
> TUN_PACKET_HEADER) + packet->size);
> +    if (aligned_packet_size > content_len)
> +    {
> +        msg(M_INFO, "Wintun: incomplete packet in send ring");
> +        buf->len = -1;
> +        return;
> +    }
> +
> +    buf_write(buf, packet->data, packet->size);
> +
> +    head = wintun_ring_wrap(head + aligned_packet_size);
> +    ring->head = head;
> +}
> +
> +static inline bool
> +is_ip_packet_valid(const struct buffer *buf) {
> +    const struct openvpn_iphdr* ih = (const struct openvpn_iphdr
> +*)BPTR(buf);
> +
> +    if (OPENVPN_IPH_GET_VER(ih->version_len) == 4)
> +    {
> +        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
> +        {
> +            return false;
> +        }
> +    }
> +    else if (OPENVPN_IPH_GET_VER(ih->version_len) == 6)
> +    {
> +        if (BLEN(buf) < sizeof(struct openvpn_ipv6hdr))
> +        {
> +            return false;
> +        }
> +    }
> +    else
> +    {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static inline int
> +write_wintun(struct tuntap *tt, struct buffer *buf) {
> +    struct tun_ring *ring = tt->wintun_receive_ring;
> +    ULONG head = ring->head;
> +    ULONG tail = ring->tail;
> +    ULONG aligned_packet_size;
> +    ULONG buf_space;
> +    struct TUN_PACKET *packet;
> +
> +    /* wintun marks ring as corrupted (overcapacity) if it receives
> invalid IP packet */
> +    if (!is_ip_packet_valid(buf))
> +    {
> +        msg(D_LOW, "write_wintun(): drop invalid IP packet");
> +        return 0;
> +    }
> +
> +    if ((head >= WINTUN_RING_CAPACITY) || (tail >=
> WINTUN_RING_CAPACITY))
> +    {
> +        msg(M_INFO, "write_wintun(): head/tail value is over
> capacity");
> +        return -1;
> +    }
> +
> +    aligned_packet_size = wintun_ring_packet_align(sizeof(struct
> TUN_PACKET_HEADER) + BLEN(buf));
> +    buf_space = wintun_ring_wrap(head - tail - WINTUN_PACKET_ALIGN);
> +    if (aligned_packet_size > buf_space)
> +    {
> +        msg(M_INFO, "write_wintun(): ring is full");
> +        return 0;
> +    }
> +
> +    /* copy packet size and data into ring */
> +    packet = (struct TUN_PACKET* )&ring->data[tail];
> +    packet->size = BLEN(buf);
> +    memcpy(packet->data, BPTR(buf), BLEN(buf));
> +
> +    /* move ring tail */
> +    ring->tail = wintun_ring_wrap(tail + aligned_packet_size);
> +    if (ring->alertable != 0)
> +    {
> +        SetEvent(tt->rw_handle.write);
> +    }
> +
> +    return BLEN(buf);
> +}
> +
>  static inline int
>  write_tun_buffered(struct tuntap *tt, struct buffer *buf)  {
> -    return tun_write_win32(tt, buf);
> +    if (tt->wintun)
> +    {
> +        return write_wintun(tt, buf);
> +    }
> +    else
> +    {
> +        return tun_write_win32(tt, buf);
> +    }
>  }
> 
>  #else  /* ifdef _WIN32 */
> @@ -544,7 +709,7 @@ tun_set(struct tuntap *tt,
>              }
>          }
>  #ifdef _WIN32
> -        if (rwflags & EVENT_READ)
> +        if (!tt->wintun && (rwflags & EVENT_READ))
>          {
>              tun_read_queue(tt, 0);
>          }
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c index
> eb4c0307..24dae7d6 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -1493,4 +1493,126 @@ send_msg_iservice(HANDLE pipe, const void *data,
> size_t size,
>      return ret;
>  }
> 
> +bool
> +impersonate_as_system()
> +{
> +    HANDLE thread_token, process_snapshot, winlogon_process,
> winlogon_token, duplicated_token;
> +    PROCESSENTRY32 entry;
> +    BOOL ret;
> +    DWORD pid = 0;
> +    TOKEN_PRIVILEGES privileges;
> +
> +    CLEAR(entry);
> +    CLEAR(privileges);
> +
> +    entry.dwSize = sizeof(PROCESSENTRY32);
> +
> +    privileges.PrivilegeCount = 1;
> +    privileges.Privileges->Attributes = SE_PRIVILEGE_ENABLED;
> +
> +    if (!LookupPrivilegeValue(NULL, SE_DEBUG_NAME,
> &privileges.Privileges[0].Luid))
> +    {
> +        return false;
> +    }
> +
> +    if (!ImpersonateSelf(SecurityImpersonation))
> +    {
> +        return false;
> +    }
> +
> +    if (!OpenThreadToken(GetCurrentThread(), TOKEN_ADJUST_PRIVILEGES,
> FALSE, &thread_token))
> +    {
> +        RevertToSelf();
> +        return false;
> +    }
> +    if (!AdjustTokenPrivileges(thread_token, FALSE, &privileges,
> sizeof(privileges), NULL, NULL))
> +    {
> +        CloseHandle(thread_token);
> +        RevertToSelf();
> +        return false;
> +    }
> +    CloseHandle(thread_token);
> +
> +    process_snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
> +    if (process_snapshot == INVALID_HANDLE_VALUE)
> +    {
> +        RevertToSelf();
> +        return false;
> +    }
> +    for (ret = Process32First(process_snapshot, &entry); ret; ret =
> Process32Next(process_snapshot, &entry))
> +    {
> +        if (!_stricmp(entry.szExeFile, "winlogon.exe"))
> +        {
> +            pid = entry.th32ProcessID;
> +            break;
> +        }
> +    }
> +    CloseHandle(process_snapshot);
> +    if (!pid)
> +    {
> +        RevertToSelf();
> +        return false;
> +    }
> +
> +    winlogon_process = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE,
> pid);
> +    if (!winlogon_process)
> +    {
> +        RevertToSelf();
> +        return false;
> +    }
> +
> +    if (!OpenProcessToken(winlogon_process, TOKEN_IMPERSONATE |
> TOKEN_DUPLICATE, &winlogon_token))
> +    {
> +        CloseHandle(winlogon_process);
> +        RevertToSelf();
> +        return false;
> +    }
> +    CloseHandle(winlogon_process);
> +
> +    if (!DuplicateToken(winlogon_token, SecurityImpersonation,
> &duplicated_token))
> +    {
> +        CloseHandle(winlogon_token);
> +        RevertToSelf();
> +        return false;
> +    }
> +    CloseHandle(winlogon_token);
> +
> +    if (!SetThreadToken(NULL, duplicated_token))
> +    {
> +        CloseHandle(duplicated_token);
> +        RevertToSelf();
> +        return false;
> +    }
> +    CloseHandle(duplicated_token);
> +
> +    return true;
> +}
> +
> +bool
> +register_ring_buffers(HANDLE device,
> +                      struct tun_ring* send_ring,
> +                      struct tun_ring* receive_ring,
> +                      HANDLE send_tail_moved,
> +                      HANDLE receive_tail_moved) {
> +    struct tun_register_rings rr;
> +    BOOL res;
> +    DWORD bytes_returned;
> +
> +    ZeroMemory(&rr, sizeof(rr));
> +
> +    rr.send.ring = send_ring;
> +    rr.send.ring_size = sizeof(struct tun_ring);
> +    rr.send.tail_moved = send_tail_moved;
> +
> +    rr.receive.ring = receive_ring;
> +    rr.receive.ring_size = sizeof(struct tun_ring);
> +    rr.receive.tail_moved = receive_tail_moved;
> +
> +    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr,
> sizeof(rr),
> +                          NULL, 0, &bytes_returned, NULL);
> +
> +    return res != FALSE;
> +}
> +
>  #endif /* ifdef _WIN32 */
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h index
> 4814bbc5..5fe95f47 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -25,6 +25,8 @@
>  #ifndef OPENVPN_WIN32_H
>  #define OPENVPN_WIN32_H
> 
> +#include <winioctl.h>
> +
>  #include "mtu.h"
>  #include "openvpn-msg.h"
>  #include "argv.h"
> @@ -323,5 +325,53 @@ bool send_msg_iservice(HANDLE pipe, const void
> *data, size_t size,  int  openvpn_execve(const struct argv *a, const
> struct env_set *es, const unsigned int flags);
> 
> +/*
> + * Values below are taken from Wireguard Windows client
> + *
> +https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_w
> +indows.go#L14
> + */
> +#define WINTUN_RING_CAPACITY 0x800000
> +#define WINTUN_RING_TRAILING_BYTES 0x10000 #define
> +WINTUN_MAX_PACKET_SIZE 0xffff #define WINTUN_PACKET_ALIGN 4
> +
> +struct tun_ring
> +{
> +    volatile ULONG head;
> +    volatile ULONG tail;
> +    volatile LONG alertable;
> +    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES]; };
> +
> +struct tun_register_rings
> +{
> +    struct
> +    {
> +        ULONG ring_size;
> +        struct tun_ring *ring;
> +        HANDLE tail_moved;
> +    } send, receive;
> +};
> +
> +struct TUN_PACKET_HEADER
> +{
> +    uint32_t size;
> +};
> +
> +struct TUN_PACKET
> +{
> +    uint32_t size;
> +    UCHAR data[WINTUN_MAX_PACKET_SIZE]; };
> +
> +#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U,
> +METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
> +
> +bool impersonate_as_system();
> +
> +bool register_ring_buffers(HANDLE device,
> +                           struct tun_ring *send_ring,
> +                           struct tun_ring *receive_ring,
> +                           HANDLE send_tail_moved,
> +                           HANDLE receive_tail_moved);
> +
>  #endif /* ifndef OPENVPN_WIN32_H */
>  #endif /* ifdef _WIN32 */
> --
> 2.17.1
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

------=_NextPart_000_0020_01D5B4E3.C7C8F730
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AwMwJzAlBggrBgEFBQcCARYZaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3BzLzAIBgYEAIswAQIwGAYI
KwYBBQUHAQMEDDAKMAgGBgQAjkYBATAaBgNVHREEEzARgQ9zaW1vbkByb3ptYW4uc2kwge4GA1Ud
HwSB5jCB4zBWoFSgUqRQME4xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1dGlv
bnMxETAPBgNVBAsTCHNpZ2VuLWNhMQ8wDQYDVQQDEwZDUkw0NTUwgYiggYWggYKGV2xkYXA6Ly94
NTAwLmdvdi5zaS9vdT1zaWdlbi1jYSxvPXN0YXRlLWluc3RpdHV0aW9ucyxjPXNpP2NlcnRpZmlj
YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZYYnaHR0cDovL3d3dy5zaWdlbi1jYS5zaS9jcmwvc2lnZW4t
Y2EuY3JsMCsGA1UdEAQkMCKADzIwMTYwMjE5MTc1NDQxWoEPMjAyMTAyMTkyMTM4MTVaMB8GA1Ud
IwQYMBaAFHF7igYfMQVVq2ASd0cgHgOIGOyJMB0GA1UdDgQWBBS7/7AHyQYI0e8GOPmwTc1ZTNw5
lzAJBgNVHRMEAjAAMBkGCSqGSIb2fQdBAAQMMAobBFY4LjEDAgOoMA0GCSqGSIb3DQEBBQUAA4IB
AQBBUL4KG1Z1oBIIdKIZs9yJxnJg/LfEPVvzNH8+CCqegq0D6k48Doo72oVEiskjqggdbUGj30uA
H8PjCD5kLGVoDwh5a2atQ3qQzaYA/lj2Js2f4fdXNn60vRp7XzbGsQdwYYecIrKzO5x6XVAIRb+T
HZNjXL3VX6vOozwBQv/+dx1P9H/rMUn7d8ci7v4PeqShbWbWwi6ez19cZvSKSkz/lWf4tj8QbA0n
WeUBlk3Bx6/TRda7kwXzcFExt+ROGt0YJjbZCN3kd7swcRvRT6gEi9L6n1XLghwPSYhzZjaL5fXv
I11JuSoQCy13XWBkq35Moo4iY19wanS1W6UM8Yq0MIIF5TCCBE2gAwIBAgINAKZovVEAAAAAVx3Q
6DANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3Zl
bmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QwHhcN
MTYwNTI0MTE1ODI3WhcNMjEwNjI3MjIwMDAwWjA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3Rh
dGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALDlZbLArGSW8ogbs+2e5ALGTyuIzi6KUYB1rxBb8ss4ZpuiDm00R5alkhGv9jVH
onciDM4WiGKq00luGLwuRNi+xp7CGhmsQY78MAcC8sZq1FsjAO9BNNikc2PfIpIzhAGljfODXPq4
1Ho13+z4bQ/gTO2tnDp9htalCJS+fXoRH/6FP1RaiGOHnKWxp07Nt0Rzr8+KSWsf483XSU1aKxfm
XHazu3K5byfSm4kViN8QX3YhAWrHFTEK0ZxY+CgWBW3ZTtmh1wcgy0smiU2Ssqe6lujjWI8inAGW
WsT3MU0LSbXheGHiVBgGu55UNH4MPuvutYAf3RaEHWg4Zmdz+JECAwEAAaOCAkMwggI/MBIGA1Ud
EwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEwLwYEVR0gADAnMCUGCCsG
AQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUFBwEBBF0wWzA2BggrBgEF
BQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJvb3QuY3J0MCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwHQYDVR0OBBYEFHF7igYfMQVVq2ASd0cgHgOIGOyJ
MIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9zaS10
cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qsb3Jn
YW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zlbmlq
YSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJTSTEc
MBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAU
BgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4IAmMw
DQYJKoZIhvcNAQELBQADggGBAHuvNSPhY4qcirWJkTwkqaOPqOSV06J/ZepFQfUEJ87TlrGjp4XR
5FLktTAEY/7R4Sgeb2K8OWEl/Koc1BbH6+uyZYvfa+WnnJEWeWOmyPy/vooO7eZyOVvaORxurWOL
CCVDW2wBkbtUoKZaUyzgP+ZPPGRV8GFlbZLCzGmArMGXJXe8t/XNiJDLehGqSWT49NYjyYQdIgI+
qi9W+A6BSUQ9jsMdYJqKhXQcosfH51sc6gZVxTKMr3PsItsa8XFiNazECAAFr0ms7HB6zb8QvHRF
eBGk/CLrW4VkZEBN/JtuyhvgktQ2BvuGtauEvHZQAYpMSh35D7pwtavRMpmhaAsQb4yPqhIMcztw
RqsKPBhWoaFEVZ+Vn3wxap5h/oAhocifNzkWJTNWjxnoPM2eNz2uWFJsgsNhlwteUvnq7+bKTNte
SKWKr6pI+GUsZhmCh5URpUnqUanp0Uie0MD9f3tiOLOp711sNb0xwi+VdDuDB37IddOIsfhPBood
wpoFrTGCAyEwggMdAgEBMEUwPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0
aW9uczERMA8GA1UECxMIc2lnZW4tY2ECBDtKDS4wDQYJYIZIAWUDBAIBBQCgggGtMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTIxNzEzMTA0N1owLwYJKoZIhvcN
AQkEMSIEINmifFdivDm+mimHziE1HRPGeLw9hHdLMhuVpCuj6iDyMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBAGjnWsUiVO3tyYM+7ov8sQun
oaYlT3oXutOk80WRUNHb3kH2os/8qRCnliozF7iKwt1rVGOEdiK7nxV1rvwzXBagracciBdIcxzz
Pmk0etHbUyTqbwK+HVqNT5t66U0Ry1Wd9MTdA5AO4BkHi3ygAjugSJznmkqK7LgFX0B+4SK95Ix1
1CoQqmFnd8VKiSSzrdzx1FuE7N/f9s2x4xTtOnFyiq/X0z7em9fqhDYBSsjb+yaypzMVlEszcxBw
s0S8zGV/vyapvhgFD8WlpLQivug2PonGg2HzhXnYmJ4WatwZ791kSdhDMw5iIZd9sRN/kSBmdmij
zimYcMZQ+w+rWXQAAAAAAAA=

------=_NextPart_000_0020_01D5B4E3.C7C8F730--

