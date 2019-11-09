From: Simon Rozman <simon@...2293...>
Date: Sat, 9 Nov 2019 11:21:25 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10BDA4B8B9@...2294...>
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-5-git-send-email-lstipakov@...277...>
In-Reply-To: <1573148729-27339-5-git-send-email-lstipakov@...277...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0021_01D596F8.330F3C70"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] wintun: ring buffers based I/O
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

------=_NextPart_000_0021_01D596F8.330F3C70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
 
> -----Original Message-----
> From: Lev Stipakov [mailto:lstipakov@...277...]
> Sent: Thursday, November 7, 2019 6:45 PM
> To: openvpn-devel@lists.sourceforge.net
> Cc: Lev Stipakov <lev@...515...>
> Subject: [Openvpn-devel] [PATCH v2 4/7] wintun: ring buffers based I/O
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c index
> 8451706..0be8b6d 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1256,12 +1256,30 @@ read_incoming_tun(struct context *c)
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
>  #else
> -    ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
> -    ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
> -    c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf),
> MAX_RW_SIZE_TUN(&c->c2.frame));
> +        ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
> +        ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
> +        c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf),
> +MAX_RW_SIZE_TUN(&c->c2.frame)); #endif #ifdef _WIN32
> +    }
>  #endif

This #ifdef dance is a bit convoluted. I suggest simplification.

>  #ifdef PACKET_TRUNCATION_CHECK
> @@ -2103,7 +2121,21 @@ io_wait_dowork(struct context *c, const unsigned
> int flags)
>       * Configure event wait based on socket, tuntap flags.
>       */
>      socket_set(c->c2.link_socket, c->c2.event_set, socket, (void
*)&socket_shift,
> NULL);
> -    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift,
NULL);
> +
> +#ifdef _WIN32
> +    if (c->c1.tuntap && c->c1.tuntap->wintun)
> +    {
> +        /* add ring buffer event */
> +        struct rw_handle rw = {.read = c->c1.tuntap->send_tail_moved };
> +        event_ctl(c->c2.event_set, &rw, EVENT_READ, (void *)&tun_shift);
> +    }
> +    else
> +    {
> +#endif
> +        tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void
> +*)&tun_shift, NULL); #ifdef _WIN32
> +    }
> +#endif

This #ifdef dance is a bit convoluted. I suggest simplification.

> +static inline int
> +write_wintun(struct tuntap *tt, struct buffer *buf) {
> +    struct tun_ring *ring = tt->receive_ring;
> +    ULONG head = ring->head;
> +    ULONG tail = ring->tail;
> +    ULONG aligned_packet_size;
> +    ULONG buf_space;
> +    struct TUN_PACKET *packet;
> +
> +    if ((head > WINTUN_RING_CAPACITY) || (tail >=
> WINTUN_RING_CAPACITY))

Should be `...head >= WINTUN_RING_CAPACITY...`

Regards,
Simon

------=_NextPart_000_0021_01D596F8.330F3C70
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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

------=_NextPart_000_0021_01D596F8.330F3C70--

