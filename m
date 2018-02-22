References: <1519275295-29121-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <6207e949-e116-a398-fafd-0ba870b5550e@...1435...>
Date: Thu, 22 Feb 2018 10:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <1519275295-29121-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH for-master v2] Fix format spec errors in
 Windows builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 22-02-18 05:54, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - "%ll" is not supported by Windows run time, so use PRIi64
>    and cast the variable to (int64_t) in output statements
>    (as in commit 9ba36639abcac4367c8227d2dd87b18fb56267c4)
> 
> - Fix an instance of wchar_t * printed using %s -- should be %ls.
> 
> - Cast variables to int or unsigned int to match the output
>   format spec when necessary.
> 
> - In route.c correct format of adapter_index (should be %lu) in a few
>   places and remove some unnecessary casts to (unsigned int). Not
>   all such instances are changed, only those related to adapter_index
>   (for consistency) or close-by contexts are edited.
> 
> Most of these errors are seen in current Windows cross-compile,
> but a few are triggered only if some DEBUG options are enabled.
> Some are not in Windows specific paths. But for consistency, all uses
> of %llu/%lld are removed. As these only affect log output, there are
> no potential side effects.
> 
> Replacing long long by int64_t also has the advantage of avoiding
> size ambiguity as long long is not guaranteed to be 64 bytes.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> v2: Use %lu for adapter_index instead of casting to (unsigned int).
>     For consistency, a few existing casts of this variable is
>     avoided. All in route.c and tun.c.
> 
>  src/openvpn/error.c       |  4 ++--
>  src/openvpn/event.c       |  8 ++++----
>  src/openvpn/forward.c     |  2 +-
>  src/openvpn/misc.c        |  2 +-
>  src/openvpn/multi.c       |  4 ++--
>  src/openvpn/otime.c       | 10 +++++-----
>  src/openvpn/packet_id.c   | 16 ++++++++--------
>  src/openvpn/reliable.c    |  4 ++--
>  src/openvpn/route.c       | 18 +++++++++---------
>  src/openvpn/shaper.c      |  4 ++--
>  src/openvpn/shaper.h      |  4 ++--
>  src/openvpn/socket.c      |  6 +++---
>  src/openvpn/ssl_openssl.c |  8 ++++----
>  src/openvpn/tun.c         | 22 +++++++++++-----------
>  14 files changed, 56 insertions(+), 56 deletions(-)
> 
> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index f337c44..d270ecb 100644
> --- a/src/openvpn/error.c
> +++ b/src/openvpn/error.c
> @@ -342,8 +342,8 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
>                  struct timeval tv;
>                  gettimeofday(&tv, NULL);
>  
> -                fprintf(fp, "%lld.%06ld %x %s%s%s%s",
> -                        (long long)tv.tv_sec,
> +                fprintf(fp, "%"PRIi64".%06ld %x %s%s%s%s",
> +                        (int64_t)tv.tv_sec,
>                          (long)tv.tv_usec,
>                          flags,
>                          prefix,
> diff --git a/src/openvpn/event.c b/src/openvpn/event.c
> index 925dc88..3727690 100644
> --- a/src/openvpn/event.c
> +++ b/src/openvpn/event.c
> @@ -1041,9 +1041,9 @@ se_wait_fast(struct event_set *es, const struct timeval *tv, struct event_set_re
>      struct timeval tv_tmp = *tv;
>      int stat;
>  
> -    dmsg(D_EVENT_WAIT, "SE_WAIT_FAST maxfd=%d tv=%lld/%ld",
> +    dmsg(D_EVENT_WAIT, "SE_WAIT_FAST maxfd=%d tv=%"PRIi64"/%ld",
>           ses->maxfd,
> -         (long long)tv_tmp.tv_sec,
> +         (int64_t)tv_tmp.tv_sec,
>           (long)tv_tmp.tv_usec);
>  
>      stat = select(ses->maxfd + 1, &ses->readfds, &ses->writefds, NULL, &tv_tmp);
> @@ -1065,8 +1065,8 @@ se_wait_scalable(struct event_set *es, const struct timeval *tv, struct event_se
>      fd_set write = ses->writefds;
>      int stat;
>  
> -    dmsg(D_EVENT_WAIT, "SE_WAIT_SCALEABLE maxfd=%d tv=%lld/%ld",
> -         ses->maxfd, (long long)tv_tmp.tv_sec, (long)tv_tmp.tv_usec);
> +    dmsg(D_EVENT_WAIT, "SE_WAIT_SCALEABLE maxfd=%d tv=%"PRIi64"/%ld",
> +         ses->maxfd, (int64_t)tv_tmp.tv_sec, (long)tv_tmp.tv_usec);
>  
>      stat = select(ses->maxfd + 1, &read, &write, NULL, &tv_tmp);
>  
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index b5b9684..7d9a338 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -610,7 +610,7 @@ check_coarse_timers_dowork(struct context *c)
>      process_coarse_timers(c);
>      c->c2.coarse_timer_wakeup = now + c->c2.timeval.tv_sec;
>  
> -    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %lld seconds", (long long)c->c2.timeval.tv_sec);
> +    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %"PRIi64" seconds", (int64_t)c->c2.timeval.tv_sec);
>  
>      /* Is the coarse timeout NOT the earliest one? */
>      if (c->c2.timeval.tv_sec > save.tv_sec)
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 23e272c..72ffc40 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -556,7 +556,7 @@ void
>  setenv_long_long(struct env_set *es, const char *name, long long value)
>  {
>      char buf[64];
> -    openvpn_snprintf(buf, sizeof(buf), "%lld", value);
> +    openvpn_snprintf(buf, sizeof(buf), "%"PRIi64, (int64_t)value);
>      setenv_str(es, name, buf);
>  }
>  
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index d5e8cbb..6a72a1d 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2383,13 +2383,13 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
>          multi_set_pending(m, ANY_OUT(&mi->context) ? mi : NULL);
>  
>  #ifdef MULTI_DEBUG_EVENT_LOOP
> -        printf("POST %s[%d] to=%d lo=%d/%d w=%lld/%ld\n",
> +        printf("POST %s[%d] to=%d lo=%d/%d w=%"PRIi64"/%ld\n",
>                 id(mi),
>                 (int) (mi == m->pending),
>                 mi ? mi->context.c2.to_tun.len : -1,
>                 mi ? mi->context.c2.to_link.len : -1,
>                 (mi && mi->context.c2.fragment) ? mi->context.c2.fragment->outgoing.len : -1,
> -               (long long)mi->context.c2.timeval.tv_sec,
> +               (int64_t)mi->context.c2.timeval.tv_sec,
>                 (long)mi->context.c2.timeval.tv_usec);
>  #endif
>      }
> diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
> index 3034277..e0b1b0e 100644
> --- a/src/openvpn/otime.c
> +++ b/src/openvpn/otime.c
> @@ -88,8 +88,8 @@ const char *
>  tv_string(const struct timeval *tv, struct gc_arena *gc)
>  {
>      struct buffer out = alloc_buf_gc(64, gc);
> -    buf_printf(&out, "[%lld/%ld]",
> -               (long long)tv->tv_sec,
> +    buf_printf(&out, "[%"PRIi64"/%ld]",
> +               (int64_t)tv->tv_sec,
>                 (long)tv->tv_usec);
>      return BSTR(&out);
>  }
> @@ -198,9 +198,9 @@ time_test(void)
>          t = time(NULL);
>          gettimeofday(&tv, NULL);
>  #if 1
> -        msg(M_INFO, "t=%lld s=%lld us=%ld",
> -            (long long)t,
> -            (long long)tv.tv_sec,
> +        msg(M_INFO, "t=%"PRIi64" s=%"PRIi64" us=%ld",
> +            (int64_t)t,
> +            (int64_t)tv.tv_sec,
>              (long)tv.tv_usec);
>  #endif
>      }
> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
> index b6ffa5a..dc44f36 100644
> --- a/src/openvpn/packet_id.c
> +++ b/src/openvpn/packet_id.c
> @@ -606,14 +606,14 @@ packet_id_debug_print(int msglevel,
>          }
>          buf_printf(&out, "%c", c);
>      }
> -    buf_printf(&out, "] %lld:" packet_id_format, (long long)p->time, (packet_id_print_type)p->id);
> +    buf_printf(&out, "] %"PRIi64":" packet_id_format, (int64_t)p->time, (packet_id_print_type)p->id);
>      if (pin)
>      {
> -        buf_printf(&out, " %lld:" packet_id_format, (long long)pin->time, (packet_id_print_type)pin->id);
> +        buf_printf(&out, " %"PRIi64":" packet_id_format, (int64_t)pin->time, (packet_id_print_type)pin->id);
>      }
>  
> -    buf_printf(&out, " t=%lld[%d]",
> -               (long long)prev_now,
> +    buf_printf(&out, " t=%"PRIi64"[%d]",
> +               (int64_t)prev_now,
>                 (int)(prev_now - tv.tv_sec));
>  
>      buf_printf(&out, " r=[%d,%d,%d,%d,%d]",
> @@ -666,8 +666,8 @@ packet_id_interactive_test(void)
>          {
>              packet_id_reap_test(&pid.rec);
>              test = packet_id_test(&pid.rec, &pin);
> -            printf("packet_id_test (%lld, " packet_id_format ") returned %d\n",
> -                   (long long)pin.time,
> +            printf("packet_id_test (%"PRIi64", " packet_id_format ") returned %d\n",
> +                   (int64_t)pin.time,
>                     (packet_id_print_type)pin.id,
>                     test);
>              if (test)
> @@ -679,8 +679,8 @@ packet_id_interactive_test(void)
>          {
>              long_form = (count < 20);
>              packet_id_alloc_outgoing(&pid.send, &pin, long_form);
> -            printf("(%lld(" packet_id_format "), %d)\n",
> -                   (long long)pin.time,
> +            printf("(%"PRIi64"(" packet_id_format "), %d)\n",
> +                   (int64_t)pin.time,
>                     (packet_id_print_type)pin.id,
>                     long_form);
>              if (pid.send.id == 10)
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index 5117641..b62ab54 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -762,14 +762,14 @@ reliable_debug_print(const struct reliable *rel, char *desc)
>      printf("********* struct reliable %s\n", desc);
>      printf("  initial_timeout=%d\n", (int)rel->initial_timeout);
>      printf("  packet_id=" packet_id_format "\n", rel->packet_id);
> -    printf("  now=%lld\n", (long long)now);
> +    printf("  now=%"PRIi64"\n", (int64_t)now);
>      for (i = 0; i < rel->size; ++i)
>      {
>          const struct reliable_entry *e = &rel->array[i];
>          if (e->active)
>          {
>              printf("  %d: packet_id=" packet_id_format " len=%d", i, e->packet_id, e->buf.len);
> -            printf(" next_try=%lld", (long long)e->next_try);
> +            printf(" next_try=%"PRIi64, (int64_t)e->next_try);
>              printf("\n");
>          }
>      }
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index ca8b182..12bca10 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1322,7 +1322,7 @@ print_default_gateway(const int msglevel,
>  #ifdef _WIN32
>          if (rgi->flags & RGI_IFACE_DEFINED)
>          {
> -            buf_printf(&out, " I=%u", (unsigned int)rgi->adapter_index);
> +            buf_printf(&out, " I=%lu", rgi->adapter_index);
>          }
>  #else
>          if (rgi->flags & RGI_IFACE_DEFINED)
> @@ -1353,7 +1353,7 @@ print_default_gateway(const int msglevel,
>  #ifdef _WIN32
>          if (rgi6->flags & RGI_IFACE_DEFINED)
>          {
> -            buf_printf(&out, " I=%u", (unsigned int)rgi6->adapter_index);
> +            buf_printf(&out, " I=%lu", rgi6->adapter_index);
>          }
>  #else
>          if (rgi6->flags & RGI_IFACE_DEFINED)
> @@ -1627,7 +1627,7 @@ add_route(struct route_ipv4 *r,
>          if (is_on_link(is_local_route, flags, rgi))
>          {
>              ai = rgi->adapter_index;
> -            argv_printf_cat(&argv, "IF %u", (unsigned int)ai);
> +            argv_printf_cat(&argv, "IF %lu", ai);
>          }
>  
>          argv_msg(D_ROUTE, &argv);
> @@ -1969,12 +1969,12 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
>          struct buffer out = alloc_buf_gc(64, &gc);
>          if (r6->adapter_index)          /* vpn server special route */
>          {
> -            buf_printf(&out, "interface=%d", r6->adapter_index );
> +            buf_printf(&out, "interface=%lu", r6->adapter_index );
>              gateway_needed = true;
>          }
>          else
>          {
> -            buf_printf(&out, "interface=%d", tt->adapter_index );
> +            buf_printf(&out, "interface=%lu", tt->adapter_index );
>          }
>          device = buf_bptr(&out);
>  
> @@ -2416,12 +2416,12 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
>          struct buffer out = alloc_buf_gc(64, &gc);
>          if (r6->adapter_index)          /* vpn server special route */
>          {
> -            buf_printf(&out, "interface=%d", r6->adapter_index );
> +            buf_printf(&out, "interface=%lu", r6->adapter_index );
>              gateway_needed = true;
>          }
>          else
>          {
> -            buf_printf(&out, "interface=%d", tt->adapter_index );
> +            buf_printf(&out, "interface=%lu", tt->adapter_index );
>          }
>          device = buf_bptr(&out);
>  
> @@ -2841,7 +2841,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
>          goto done;
>      }
>  
> -    msg( D_ROUTE, "GDG6: II=%d DP=%s/%d NH=%s",
> +    msg( D_ROUTE, "GDG6: II=%lu DP=%s/%d NH=%s",
>           BestRoute.InterfaceIndex,
>           print_in6_addr( BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, 0, &gc),
>           BestRoute.DestinationPrefix.PrefixLength,
> @@ -3002,7 +3002,7 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
>  
>      if (ack.error_number != NO_ERROR)
>      {
> -        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%lu]",
> +        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%d]",
>              (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
>              ack.error_number, rt->iface.index);
>          goto out;
> diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
> index 1bf72aa..92364f2 100644
> --- a/src/openvpn/shaper.c
> +++ b/src/openvpn/shaper.c
> @@ -76,8 +76,8 @@ shaper_soonest_event(struct timeval *tv, int delay)
>          }
>      }
>  #ifdef SHAPER_DEBUG
> -    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=%lld usec=%ld ret=%d",
> -         (long long)tv->tv_sec, (long)tv->tv_usec, (int)ret);
> +    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=%"PRIi64" usec=%ld ret=%d",
> +         (int64_t)tv->tv_sec, (long)tv->tv_usec, (int)ret);
>  #endif
>      return ret;
>  }
> diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
> index d290607..4efe398 100644
> --- a/src/openvpn/shaper.h
> +++ b/src/openvpn/shaper.h
> @@ -147,10 +147,10 @@ shaper_wrote_bytes(struct shaper *s, int nbytes)
>          tv_add(&s->wakeup, &tv);
>  
>  #ifdef SHAPER_DEBUG
> -        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=%d delay=%ld sec=%lld usec=%ld",
> +        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=%d delay=%ld sec=%"PRIi64" usec=%ld",
>               nbytes,
>               (long)tv.tv_usec,
> -             (long long)s->wakeup.tv_sec,
> +             (int64_t)s->wakeup.tv_sec,
>               (long)s->wakeup.tv_usec);
>  #endif
>      }
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 8445daa..211e744 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1122,7 +1122,7 @@ socket_do_accept(socket_descriptor_t sd,
>  
>      if (!socket_defined(new_sd))
>      {
> -        msg(D_LINK_ERRORS | M_ERRNO, "TCP: accept(%d) failed", sd);
> +        msg(D_LINK_ERRORS | M_ERRNO, "TCP: accept(%d) failed", (int)sd);
>      }
>      /* only valid if we have remote_len_af!=0 */
>      else if (remote_len_af && remote_len != remote_len_af)
> @@ -1875,12 +1875,12 @@ phase2_inetd(struct link_socket *sock, const struct frame *frame,
>                  sock->info.lsa->actual.dest.addr.sa.sa_family = local_addr.addr.sa.sa_family;
>                  dmsg(D_SOCKET_DEBUG, "inetd(%s): using sa_family=%d from getsockname(%d)",
>                       proto2ascii(sock->info.proto, sock->info.af, false),
> -                     local_addr.addr.sa.sa_family, sock->sd);
> +                     local_addr.addr.sa.sa_family, (int)sock->sd);
>              }
>              else
>              {
>                  msg(M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
> -                    proto2ascii(sock->info.proto, sock->info.af, false), sock->sd);
> +                    proto2ascii(sock->info.proto, sock->info.af, false), (int)sock->sd);
>              }
>          }
>  #else  /* ifdef HAVE_GETSOCKNAME */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index cd41513..d91458b 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1580,8 +1580,8 @@ bio_debug_data(const char *mode, BIO *bio, const uint8_t *buf, int len, const ch
>      if (len > 0)
>      {
>          open_biofp();
> -        fprintf(biofp, "BIO_%s %s time=%lld bio=" ptr_format " len=%d data=%s\n",
> -                mode, desc, (long long)time(NULL), (ptr_type)bio, len, format_hex(buf, len, 0, &gc));
> +        fprintf(biofp, "BIO_%s %s time=%"PRIi64" bio=" ptr_format " len=%d data=%s\n",
> +                mode, desc, (int64_t)time(NULL), (ptr_type)bio, len, format_hex(buf, len, 0, &gc));
>          fflush(biofp);
>      }
>      gc_free(&gc);
> @@ -1591,8 +1591,8 @@ static void
>  bio_debug_oc(const char *mode, BIO *bio)
>  {
>      open_biofp();
> -    fprintf(biofp, "BIO %s time=%lld bio=" ptr_format "\n",
> -            mode, (long long)time(NULL), (ptr_type)bio);
> +    fprintf(biofp, "BIO %s time=%"PRIi64" bio=" ptr_format "\n",
> +            mode, (int64_t)time(NULL), (ptr_type)bio);
>      fflush(biofp);
>  }
>  
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 253d884..8771bf3 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -125,7 +125,7 @@ do_address_service(const bool add, const short family, const struct tuntap *tt)
>  
>      if (ack.error_number != NO_ERROR)
>      {
> -        msg(M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%lu]",
> +        msg(M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%d]",
>              (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
>              ack.error_number, addr.iface.index);
>          goto out;
> @@ -3791,7 +3791,7 @@ get_panel_reg(struct gc_arena *gc)
>  
>              if (status != ERROR_SUCCESS || name_type != REG_SZ)
>              {
> -                dmsg(D_REGISTRY, "Error opening registry key: %s\\%s\\%s",
> +                dmsg(D_REGISTRY, "Error opening registry key: %s\\%s\\%ls",
>                       NETWORK_CONNECTIONS_KEY, connection_string, name_string);
>              }
>              else
> @@ -5560,7 +5560,7 @@ fork_dhcp_action(struct tuntap *tt)
>          {
>              buf_printf(&cmd, " --dhcp-renew");
>          }
> -        buf_printf(&cmd, " --dhcp-internal %u", (unsigned int)tt->adapter_index);
> +        buf_printf(&cmd, " --dhcp-internal %lu", tt->adapter_index);
>  
>          fork_to_self(BSTR(&cmd));
>          gc_free(&gc);
> @@ -6043,16 +6043,16 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>  
>              if (status == NO_ERROR)
>              {
> -                msg(M_INFO, "Successful ARP Flush on interface [%u] %s",
> -                    (unsigned int)index,
> +                msg(M_INFO, "Successful ARP Flush on interface [%lu] %s",
> +                    index,
>                      device_guid);
>              }
>              else if (status != -1)
>              {
> -                msg(D_TUNTAP_INFO, "NOTE: FlushIpNetTable failed on interface [%u] %s (status=%u) : %s",
> -                    (unsigned int)index,
> +                msg(D_TUNTAP_INFO, "NOTE: FlushIpNetTable failed on interface [%lu] %s (status=%lu) : %s",
> +                    index,
>                      device_guid,
> -                    (unsigned int)status,
> +                    status,
>                      strerror_win32(status, &gc));
>              }
>          }
> @@ -6123,12 +6123,12 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>              }
>              else
>              {
> -                msg(M_FATAL, "ERROR: AddIPAddress %s/%s failed on interface %s, index=%d, status=%u (windows error: '%s') -- %s",
> +                msg(M_FATAL, "ERROR: AddIPAddress %s/%s failed on interface %s, index=%lu, status=%lu (windows error: '%s') -- %s",
>                      print_in_addr_t(tt->local, 0, &gc),
>                      print_in_addr_t(tt->adapter_netmask, 0, &gc),
>                      device_guid,
> -                    (int)index,
> -                    (unsigned int)status,
> +                    index,
> +                    status,
>                      strerror_win32(status, &gc),
>                      error_suffix);
>              }
> 

Purely based on stare-at-code, this looks good.  So, for as far as
possible without testing:

Acked-by: Steffan Karger <steffan.karger@...1435...>

-Steffan

