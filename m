MIME-Version: 1.0
References: <1559746770-21285-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1559746770-21285-1-git-send-email-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 7 Jun 2019 17:29:34 +0300
Message-ID: <CAGyAFMUUFPcLeixEdatLAmqfAE8qBmENx+AbGn_wLzG927sy9A@...278...>
Content-Type: multipart/alternative; boundary="000000000000982229058abca93b"
Subject: Re: [Openvpn-devel] [PATCH] Wintun - experimental support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000982229058abca93b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If someone would like to test it - you can get a Windows binary from here:
https://ci.appveyor.com/api/buildjobs/w20knnbut89uoeuw/artifacts/msvc%2Fima=
ge%2Fbin.zip

Note that interactive service doesn't (yet) work with Wintun, you need to
run openvpn as a privileged process. For example, from Administrator
command prompt:

> c:\Temp\ovpn2_wintun>openvpn.exe --config lev.ovpn --windows-driver wintun

ke 5. kes=C3=A4k. 2019 klo 17.59 Lev Stipakov (lstipakov@...277...) kirjoit=
ti:

> From: Lev Stipakov <lev@...515...>
>
> This adds experimental support for Wintun,
> an alternative to tap-windows6 on Windows.
>
> To use wintun, specify
>
>   --windows-driver wintun
>
> as config option. Default value is "tap-windows6".
>
> Unlike tap-windows6, Wintun returns up to 256 packets,
> which have to be decapsulated and processed one by one.
> We do it by reading data into a new buffer, processing
> single packet and returning control to event loop
> to give it a chance to write processed packet to link.
>
> If there are no pending writes and there is data in wintun
> buffer, event loop triggers tun read. There we read single
> packet from wintun buffer or, if it is empty, read from
> tun driver.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/forward.c |  76 +++++++++++++++++-
>  src/openvpn/forward.h |  15 ++++
>  src/openvpn/init.c    |   7 ++
>  src/openvpn/openvpn.h |   4 +
>  src/openvpn/options.c |  36 ++++++++-
>  src/openvpn/options.h |   1 +
>  src/openvpn/socket.c  |   4 +-
>  src/openvpn/syshead.h |   1 +
>  src/openvpn/tun.c     | 212
> +++++++++++++++++++++++++++++++++-----------------
>  src/openvpn/tun.h     |  34 +++++++-
>  src/openvpn/win32.c   | 119 ++++++++++++++++++++++++++--
>  src/openvpn/win32.h   |  19 ++++-
>  12 files changed, 441 insertions(+), 87 deletions(-)
>
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index ad4c1f5..8077835 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -2182,6 +2182,52 @@ io_wait_dowork(struct context *c, const unsigned
> int flags)
>      dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", c->c2.event_set_statu=
s);
>  }
>
> +#ifdef _WIN32
> +/**
> + * This processes single packet from wintun buffer,
> + * which can contain up to 256 packets.
> + */
> +static void
> +process_incoming_wintun(struct context *c)
> +{
> +    struct buffer *buf =3D &c->c2.wintun_buf;
> +    uint32_t *size =3D NULL;
> +    int end_padding_len =3D 0;
> +
> +    /* get packet size */
> +    size =3D (uint32_t *)buf_read_alloc(buf, 4);
> +    if (size =3D=3D NULL)
> +    {
> +        return;
> +    }
> +
> +    /* skip start padding */
> +    if (!buf_advance(buf, 12))
> +    {
> +        return;
> +    }
> +
> +    /* copy packet */
> +    c->c2.buf =3D c->c2.buffers->read_tun_buf;
> +    buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame));
> +    buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame));
> +    if (!buf_copy_n(&c->c2.buf, buf, (int)*size))
> +    {
> +        return;
> +    }
> +
> +    /* this encrypts packet and puts it to c->c2.to_link buffer */
> +    process_incoming_tun(c);
> +
> +    /* skip end padding */
> +    end_padding_len =3D (16 - (*size & 15)) % 16;
> +    if (!buf_advance(buf, end_padding_len))
> +    {
> +        return;
> +    }
> +}
> +#endif
> +
>  void
>  process_io(struct context *c)
>  {
> @@ -2217,10 +2263,34 @@ process_io(struct context *c)
>      /* Incoming data on TUN device */
>      else if (status & TUN_READ)
>      {
> -        read_incoming_tun(c);
> -        if (!IS_SIG(c))
> +#ifdef _WIN32
> +        if (c->options.wintun)
> +        {
> +            /* only read from driver if there are no packets in buffer */
> +            if (BLEN(&c->c2.wintun_buf) =3D=3D 0)
> +            {
> +                read_incoming_tun(c);
> +                c->c2.wintun_buf =3D c->c2.buf;
> +            }
> +            if (!IS_SIG(c))
> +            {
> +                process_incoming_wintun(c);
> +            }
> +
> +            /*
> +             * We need to write processed wintun packet to link,
> +             * hence we give control back to event loop, which will
> +             * call us again if wintun buffer is not empty
> +             */
> +        }
> +        else
> +#endif
>          {
> -            process_incoming_tun(c);
> +            read_incoming_tun(c);
> +            if (!IS_SIG(c))
> +            {
> +                process_incoming_tun(c);
> +            }
>          }
>      }
>  }
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
> index 48202c0..ac3e932 100644
> --- a/src/openvpn/forward.h
> +++ b/src/openvpn/forward.h
> @@ -61,6 +61,7 @@
>  #define IOW_MBUF            (1<<7)
>  #define IOW_READ_TUN_FORCE  (1<<8)
>  #define IOW_WAIT_SIGNAL     (1<<9)
> +#define IOW_READ_WINTUN_BUF (1<<10)
>
>  #define IOW_READ            (IOW_READ_TUN|IOW_READ_LINK)
>
> @@ -375,6 +376,12 @@ p2p_iow_flags(const struct context *c)
>      {
>          flags |=3D IOW_TO_TUN;
>      }
> +#ifdef _WIN32
> +    if (c->c2.wintun_buf.len > 0)
> +    {
> +        flags |=3D IOW_READ_WINTUN_BUF;
> +    }
> +#endif
>      return flags;
>  }
>
> @@ -401,6 +408,14 @@ io_wait(struct context *c, const unsigned int flags)
>          }
>          c->c2.event_set_status =3D ret;
>      }
> +#ifdef _WIN32
> +    /* make sure we write to link before reading from wintun buffer,
> +     * otherwise we'll overwrite c2->to_link buffer and lose a packet */
> +    else if (!(flags & IOW_TO_LINK) && (flags & IOW_READ_WINTUN_BUF))
> +    {
> +        c->c2.event_set_status =3D TUN_READ;
> +    }
> +#endif
>      else
>      {
>          /* slow path */
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index ef26503..1625272 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1696,6 +1696,10 @@ do_init_tun(struct context *c)
>                              !c->options.ifconfig_nowarn,
>                              c->c2.es);
>
> +#ifdef _WIN32
> +    c->c1.tuntap->wintun =3D c->options.wintun;
> +#endif
> +
>      init_tun_post(c->c1.tuntap,
>                    &c->c2.frame,
>                    &c->options.tuntap_options);
> @@ -1738,6 +1742,9 @@ do_open_tun(struct context *c)
>      /* store (hide) interactive service handle in tuntap_options */
>      c->c1.tuntap->options.msg_channel =3D c->options.msg_channel;
>      msg(D_ROUTE, "interactive service msg_channel=3D%u", (unsigned int)
> c->options.msg_channel);
> +
> +    c->c1.tuntap->wintun =3D c->options.wintun;
> +
>  #endif
>
>      /* allocate route list structure */
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index d11f61d..d694666 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -382,6 +382,10 @@ struct context_2
>      struct buffer buf;
>      struct buffer to_tun;
>      struct buffer to_link;
> +#ifdef _WIN32
> +    /* contains up to 256 packets */
> +    struct buffer wintun_buf;
> +#endif
>
>      /* should we print R|W|r|w to console on packet transfers? */
>      bool log_rw;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e34b65b..534a6be 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -845,6 +845,7 @@ init_options(struct options *o, const bool init_gc)
>      o->tuntap_options.dhcp_masq_offset =3D 0;     /* use network address=
 as
> internal DHCP server address */
>      o->route_method =3D ROUTE_METHOD_ADAPTIVE;
>      o->block_outside_dns =3D false;
> +    o->wintun =3D false;
>  #endif
>  #if P2MP_SERVER
>      o->real_hash_size =3D 256;
> @@ -2937,6 +2938,12 @@ options_postprocess_mutate_invariant(struct options
> *options)
>          options->ifconfig_noexec =3D false;
>      }
>
> +    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set
> IP address and netmask */
> +    if (options->wintun)
> +    {
> +        options->tuntap_options.ip_win32_type =3D IPW32_SET_IPAPI;
> +    }
> +
>      remap_redirect_gateway_flags(options);
>  #endif
>
> @@ -3980,6 +3987,26 @@ foreign_option(struct options *o, char *argv[], int
> len, struct env_set *es)
>      }
>  }
>
> +#ifdef _WIN32
> +bool
> +parse_windows_driver(const char *str, const int msglevel)
> +{
> +    if (streq(str, "tap"))
> +    {
> +        return false;
> +    }
> +    else if (streq(str, "wintun"))
> +    {
> +        return true;
> +    }
> +    else
> +    {
> +        msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
> +        return false;
> +    }
> +}
> +#endif
> +
>  /*
>   * parse/print topology coding
>   */
> @@ -5220,6 +5247,13 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->dev_type =3D p[1];
>      }
> +#ifdef _WIN32
> +    else if (streq(p[0], "windows-driver") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        options->wintun =3D parse_windows_driver(p[1], M_FATAL);
> +    }
> +#endif
>      else if (streq(p[0], "dev-node") && p[1] && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> @@ -7217,7 +7251,7 @@ add_option(struct options *options,
>      else if (streq(p[0], "show-adapters") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> -        show_tap_win_adapters(M_INFO|M_NOPREFIX, M_WARN|M_NOPREFIX);
> +        show_tap_win_adapters(M_INFO|M_NOPREFIX, M_WARN|M_NOPREFIX,
> options->wintun);
>          openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
>      }
>      else if (streq(p[0], "show-net") && !p[1])
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index e2b3893..670b70a 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -614,6 +614,7 @@ struct options
>      bool show_net_up;
>      int route_method;
>      bool block_outside_dns;
> +    bool wintun;
>  #endif
>
>      bool use_peer_id;
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index c472cf1..4352869 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1635,8 +1635,8 @@ static void
>  socket_frame_init(const struct frame *frame, struct link_socket *sock)
>  {
>  #ifdef _WIN32
> -    overlapped_io_init(&sock->reads, frame, FALSE, false);
> -    overlapped_io_init(&sock->writes, frame, TRUE, false);
> +    overlapped_io_init(&sock->reads, frame, true, false, false);
> +    overlapped_io_init(&sock->writes, frame, false, false, false);
>      sock->rw_handle.read =3D sock->reads.overlapped.hEvent;
>      sock->rw_handle.write =3D sock->writes.overlapped.hEvent;
>  #endif
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index 2b4c49f..e7cbf25 100644
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
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index e929b50..5fd8339 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -788,8 +788,8 @@ init_tun_post(struct tuntap *tt,
>  {
>      tt->options =3D *options;
>  #ifdef _WIN32
> -    overlapped_io_init(&tt->reads, frame, FALSE, true);
> -    overlapped_io_init(&tt->writes, frame, TRUE, true);
> +    overlapped_io_init(&tt->reads, frame, true, true, tt->wintun);
> +    overlapped_io_init(&tt->writes, frame, false, true, tt->wintun);
>      tt->rw_handle.read =3D tt->reads.overlapped.hEvent;
>      tt->rw_handle.write =3D tt->writes.overlapped.hEvent;
>      tt->adapter_index =3D TUN_ADAPTER_INDEX_INVALID;
> @@ -3430,7 +3430,7 @@ tun_finalize(
>  }
>
>  const struct tap_reg *
> -get_tap_reg(struct gc_arena *gc)
> +get_tap_reg(struct gc_arena *gc, bool wintun)
>  {
>      HKEY adapter_key;
>      LONG status;
> @@ -3461,6 +3461,20 @@ get_tap_reg(struct gc_arena *gc)
>          char net_cfg_instance_id_string[] =3D "NetCfgInstanceId";
>          char net_cfg_instance_id[256];
>          DWORD data_type;
> +        char expected_component_id[256];
> +        char expected_root_component_id[256];
> +        char net_luid_index_string[] =3D "NetLuidIndex";
> +        DWORD luid_index;
> +
> +        if (wintun)
> +        {
> +            strcpy(expected_component_id, WINTUN_COMPONENT_ID);
> +        }
> +        else
> +        {
> +            strcpy(expected_component_id, TAP_WIN_COMPONENT_ID);
> +        }
> +        openvpn_snprintf(expected_root_component_id,
> sizeof(expected_root_component_id), "root\\%s", expected_component_id);
>
>          len =3D sizeof(enum_name);
>          status =3D RegEnumKeyEx(
> @@ -3525,13 +3539,27 @@ get_tap_reg(struct gc_arena *gc)
>
>                  if (status =3D=3D ERROR_SUCCESS && data_type =3D=3D REG_=
SZ)
>                  {
> -                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
> -                        !strcmp(component_id, "root\\"
> TAP_WIN_COMPONENT_ID))
> +                    if (!strcmp(component_id, expected_component_id) ||
> +                        !strcmp(component_id, expected_root_component_id=
))
>                      {
>                          struct tap_reg *reg;
>                          ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
>                          reg->guid =3D string_alloc(net_cfg_instance_id, =
gc);
>
> +                        len =3D sizeof(luid_index);
> +                        status =3D RegQueryValueEx(
> +                            unit_key,
> +                            net_luid_index_string,
> +                            NULL,
> +                            &data_type,
> +                            (LPBYTE)&luid_index,
> +                            &len);
> +
> +                        if (status =3D=3D ERROR_SUCCESS && data_type =3D=
=3D
> REG_DWORD)
> +                        {
> +                            reg->luid_index =3D luid_index;
> +                        }
> +
>                          /* link into return list */
>                          if (!first)
>                          {
> @@ -3744,7 +3772,7 @@ show_valid_win32_tun_subnets(void)
>  }
>
>  void
> -show_tap_win_adapters(int msglev, int warnlev)
> +show_tap_win_adapters(int msglev, int warnlev, bool wintun)
>  {
>      struct gc_arena gc =3D gc_new();
>
> @@ -3758,10 +3786,10 @@ show_tap_win_adapters(int msglev, int warnlev)
>      const struct tap_reg *tr1;
>      const struct panel_reg *pr;
>
> -    const struct tap_reg *tap_reg =3D get_tap_reg(&gc);
> +    const struct tap_reg *tap_reg =3D get_tap_reg(&gc, wintun);
>      const struct panel_reg *panel_reg =3D get_panel_reg(&gc);
>
> -    msg(msglev, "Available TAP-WIN32 adapters [name, GUID]:");
> +    msg(msglev, "Available %s adapters [name, GUID]:", wintun ? "WinTun"
> : "TAP-WIN32");
>
>      /* loop through each TAP-Windows adapter registry entry */
>      for (tr =3D tap_reg; tr !=3D NULL; tr =3D tr->next)
> @@ -3883,13 +3911,14 @@ at_least_one_tap_win(const struct tap_reg *tap_re=
g)
>  }
>
>  /*
> - * Get an adapter GUID and optional actual_name from the
> + * Get an adapter GUID, LUID index and optional actual_name from the
>   * registry for the TAP device # =3D device_number.
>   */
>  static const char *
>  get_unspecified_device_guid(const int device_number,
>                              char *actual_name,
>                              int actual_name_size,
> +                            int *luid_index,
>                              const struct tap_reg *tap_reg_src,
>                              const struct panel_reg *panel_reg_src,
>                              struct gc_arena *gc)
> @@ -3938,6 +3967,11 @@ get_unspecified_device_guid(const int device_numbe=
r,
>          }
>      }
>
> +    if (luid_index)
> +    {
> +        *luid_index =3D tap_reg->luid_index;
> +    }
> +
>      /* Save GUID for return value */
>      ret =3D alloc_buf_gc(256, gc);
>      buf_printf(&ret, "%s", tap_reg->guid);
> @@ -4536,7 +4570,7 @@ get_adapter_index_flexible(const char *name)  /*
> actual name or GUID */
>      }
>      if (index =3D=3D TUN_ADAPTER_INDEX_INVALID)
>      {
> -        const struct tap_reg *tap_reg =3D get_tap_reg(&gc);
> +        const struct tap_reg *tap_reg =3D get_tap_reg(&gc, false);
>          const struct panel_reg *panel_reg =3D get_panel_reg(&gc);
>          const char *guid =3D name_to_guid(name, tap_reg, panel_reg);
>          index =3D get_adapter_index_method_1(guid);
> @@ -4663,7 +4697,7 @@ void
>  tap_allow_nonadmin_access(const char *dev_node)
>  {
>      struct gc_arena gc =3D gc_new();
> -    const struct tap_reg *tap_reg =3D get_tap_reg(&gc);
> +    const struct tap_reg *tap_reg =3D get_tap_reg(&gc, false);
>      const struct panel_reg *panel_reg =3D get_panel_reg(&gc);
>      const char *device_guid =3D NULL;
>      HANDLE hand;
> @@ -4717,6 +4751,7 @@ tap_allow_nonadmin_access(const char *dev_node)
>                                                        actual_buffer,
>
>  sizeof(actual_buffer),
>                                                        tap_reg,
> +                                                      NULL,
>                                                        panel_reg,
>                                                        &gc);
>
> @@ -5239,7 +5274,7 @@ out:
>  static const char *
>  netsh_get_id(const char *dev_node, struct gc_arena *gc)
>  {
> -    const struct tap_reg *tap_reg =3D get_tap_reg(gc);
> +    const struct tap_reg *tap_reg =3D get_tap_reg(gc, false);
>      const struct panel_reg *panel_reg =3D get_panel_reg(gc);
>      struct buffer actual =3D alloc_buf_gc(256, gc);
>      const char *guid;
> @@ -5252,9 +5287,9 @@ netsh_get_id(const char *dev_node, struct gc_arena
> *gc)
>      }
>      else
>      {
> -        guid =3D get_unspecified_device_guid(0, BPTR(&actual),
> BCAP(&actual), tap_reg, panel_reg, gc);
> +        guid =3D get_unspecified_device_guid(0, BPTR(&actual),
> BCAP(&actual), NULL, tap_reg, panel_reg, gc);
>
> -        if (get_unspecified_device_guid(1, NULL, 0, tap_reg, panel_reg,
> gc)) /* ambiguous if more than one TAP-Windows adapter */
> +        if (get_unspecified_device_guid(1, NULL, 0, NULL, tap_reg,
> panel_reg, gc)) /* ambiguous if more than one TAP-Windows adapter */
>          {
>              guid =3D NULL;
>          }
> @@ -5528,6 +5563,7 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>      struct gc_arena gc =3D gc_new();
>      char device_path[256];
>      const char *device_guid =3D NULL;
> +    DWORD device_luid_index =3D 0;
>      DWORD len;
>      bool dhcp_masq =3D false;
>      bool dhcp_masq_post =3D false;
> @@ -5554,7 +5590,7 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>       * Lookup the device name in the registry, using the --dev-node high
> level name.
>       */
>      {
> -        const struct tap_reg *tap_reg =3D get_tap_reg(&gc);
> +        const struct tap_reg *tap_reg =3D get_tap_reg(&gc, tt->wintun);
>          const struct panel_reg *panel_reg =3D get_panel_reg(&gc);
>          char actual_buffer[256];
>
> @@ -5601,6 +5637,7 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>                  device_guid =3D get_unspecified_device_guid(device_numbe=
r,
>                                                            actual_buffer,
>
>  sizeof(actual_buffer),
> +
> &device_luid_index,
>                                                            tap_reg,
>                                                            panel_reg,
>                                                            &gc);
> @@ -5610,11 +5647,28 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>                      msg(M_FATAL, "All TAP-Windows adapters on this system
> are currently in use.");
>                  }
>
> -                /* Open Windows TAP-Windows adapter */
> -                openvpn_snprintf(device_path, sizeof(device_path),
> "%s%s%s",
> -                                 USERMODEDEVICEDIR,
> -                                 device_guid,
> -                                 TAP_WIN_SUFFIX);
> +                /* Open wintun / tap-windows6 adapter */
> +                if (tt->wintun)
> +                {
> +                    openvpn_snprintf(device_path, sizeof(device_path),
> "%sWINTUN%lu",
> +                                     USERMODEDEVICEDIR,
> +                                     device_luid_index);
> +                }
> +                else
> +                {
> +                    openvpn_snprintf(device_path, sizeof(device_path),
> "%s%s%s",
> +                                     USERMODEDEVICEDIR,
> +                                     device_guid,
> +                                     TAP_WIN_SUFFIX);
> +                }
> +
> +                if (tt->wintun)
> +                {
> +                    if (!impersonate_as_system())
> +                    {
> +                        msg(M_FATAL, "ERROR:  Failed to impersonate as
> SYSTEM, make sure process is running under privileged account");
> +                    }
> +                }
>
>                  tt->hand =3D CreateFile(
>                      device_path,
> @@ -5626,6 +5680,14 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>                      0
>                      );
>
> +                if (tt->wintun)
> +                {
> +                    if (!RevertToSelf())
> +                    {
> +                        msg(M_FATAL, "ERROR:  RevertToSelf error: %lu",
> GetLastError());
> +                    }
> +                }
> +
>                  if (tt->hand =3D=3D INVALID_HANDLE_VALUE)
>                  {
>                      msg(D_TUNTAP_INFO, "CreateFile failed on TAP device:
> %s", device_path);
> @@ -5644,12 +5706,14 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>          tt->actual_name =3D string_alloc(actual_buffer, NULL);
>      }
>
> -    msg(M_INFO, "TAP-WIN32 device [%s] opened: %s", tt->actual_name,
> device_path);
> +    msg(M_INFO, "%s device device [%s] opened: %s", tt->wintun ? "Wintun"
> : "TAP - WIN32", tt->actual_name, device_path);
>      tt->adapter_index =3D get_adapter_index(device_guid);
>
> -    /* get driver version info */
> +    if (!tt->wintun)
>      {
> +        /* get driver version info */
>          ULONG info[3];
> +        ULONG mtu;
>          CLEAR(info);
>          if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_VERSION,
>                              &info, sizeof(info),
> @@ -5684,11 +5748,8 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>          {
>              msg( M_FATAL, "ERROR:  Tap-Win32 driver version %d.%d is
> buggy regarding small IPv4 packets in TUN mode. Upgrade your Tap-Win32
> driver.", (int) info[0], (int) info[1] );
>          }
> -    }
>
> -    /* get driver MTU */
> -    {
> -        ULONG mtu;
> +        /* get driver MTU */
>          if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU,
>                              &mtu, sizeof(mtu),
>                              &mtu, sizeof(mtu), &len, NULL))
> @@ -5746,7 +5807,7 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>
>      /* set point-to-point mode if TUN device */
>
> -    if (tt->type =3D=3D DEV_TYPE_TUN)
> +    if (tt->type =3D=3D DEV_TYPE_TUN && !tt->wintun)
>      {
>          if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
>          {
> @@ -5834,71 +5895,80 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>              ep[2] =3D dhcp_masq_addr(tt->local, tt->adapter_netmask,
> tt->options.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
>          }
>
> -        /* lease time in seconds */
> -        ep[3] =3D (uint32_t) tt->options.dhcp_lease_time;
> +        if (!tt->wintun)
> +        {
> +            /* lease time in seconds */
> +            ep[3] =3D (uint32_t)tt->options.dhcp_lease_time;
>
> -        ASSERT(ep[3] > 0);
> +            ASSERT(ep[3] > 0);
>
>  #ifndef SIMULATE_DHCP_FAILED /* this code is disabled to simulate bad
> DHCP negotiation */
> -        if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,
> -                             ep, sizeof(ep),
> -                             ep, sizeof(ep), &len, NULL))
> -        {
> -            msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a
> DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
> -        }
> +            if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MAS=
Q,
> +                ep, sizeof(ep),
> +                ep, sizeof(ep), &len, NULL))
> +            {
> +                msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a
> DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
> +            }
>
> -        msg(M_INFO, "Notified TAP-Windows driver to set a DHCP IP/netmask
> of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
> -            print_in_addr_t(tt->local, 0, &gc),
> -            print_in_addr_t(tt->adapter_netmask, 0, &gc),
> -            device_guid,
> -            print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
> -            ep[3]
> +            msg(M_INFO, "Notified TAP-Windows driver to set a DHCP
> IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
> +                print_in_addr_t(tt->local, 0, &gc),
> +                print_in_addr_t(tt->adapter_netmask, 0, &gc),
> +                device_guid,
> +                print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
> +                ep[3]
>              );
>
> -        /* user-supplied DHCP options capability */
> -        if (tt->options.dhcp_options)
> -        {
> -            struct buffer buf =3D alloc_buf(256);
> -            if (build_dhcp_options_string(&buf, &tt->options))
> +            /* user-supplied DHCP options capability */
> +            if (tt->options.dhcp_options)
>              {
> -                msg(D_DHCP_OPT, "DHCP option string: %s",
> format_hex(BPTR(&buf), BLEN(&buf), 0, &gc));
> -                if (!DeviceIoControl(tt->hand,
> TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
> -                                     BPTR(&buf), BLEN(&buf),
> -                                     BPTR(&buf), BLEN(&buf), &len, NULL))
> +                struct buffer buf =3D alloc_buf(256);
> +                if (build_dhcp_options_string(&buf, &tt->options))
>                  {
> -                    msg(M_FATAL, "ERROR: The TAP-Windows driver rejected
> a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
> +                    msg(D_DHCP_OPT, "DHCP option string: %s",
> format_hex(BPTR(&buf), BLEN(&buf), 0, &gc));
> +                    if (!DeviceIoControl(tt->hand,
> TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
> +                        BPTR(&buf), BLEN(&buf),
> +                        BPTR(&buf), BLEN(&buf), &len, NULL))
> +                    {
> +                        msg(M_FATAL, "ERROR: The TAP-Windows driver
> rejected a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
> +                    }
>                  }
> +                else
> +                {
> +                    msg(M_WARN, "DHCP option string not set due to
> error");
> +                }
> +                free_buf(&buf);
>              }
> -            else
> -            {
> -                msg(M_WARN, "DHCP option string not set due to error");
> -            }
> -            free_buf(&buf);
> -        }
>  #endif /* ifndef SIMULATE_DHCP_FAILED */
> +        }
> +
> +
>      }
>
> -    /* set driver media status to 'connected' */
> +    if (!tt->wintun)
>      {
> -        ULONG status =3D TRUE;
> -        if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
> -                             &status, sizeof(status),
> -                             &status, sizeof(status), &len, NULL))
> +        /* set driver media status to 'connected' */
>          {
> -            msg(M_WARN, "WARNING: The TAP-Windows driver rejected a
> TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
> +            ULONG status =3D TRUE;
> +            if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATU=
S,
> +                &status, sizeof(status),
> +                &status, sizeof(status), &len, NULL))
> +            {
> +              msg(M_WARN, "WARNING: The TAP-Windows driver rejected a
> TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
> +            }
>          }
> -    }
>
> -    /* possible wait for adapter to come up */
> -    {
> -        int s =3D tt->options.tap_sleep;
> -        if (s > 0)
> +        /* possible wait for adapter to come up */
>          {
> -            msg(M_INFO, "Sleeping for %d seconds...", s);
> -            management_sleep(s);
> +            int s =3D tt->options.tap_sleep;
> +            if (s > 0)
> +            {
> +                msg(M_INFO, "Sleeping for %d seconds...", s);
> +                management_sleep(s);
> +            }
>          }
>      }
>
> +
>      /* possibly use IP Helper API to set IP address on adapter */
>      {
>          const DWORD index =3D tt->adapter_index;
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index 9ed8ef0..6591d59 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -37,6 +37,10 @@
>  #include "proto.h"
>  #include "misc.h"
>
> +#ifdef _WIN32
> +#define WINTUN_COMPONENT_ID "wintun"
> +#endif
> +
>  #if defined(_WIN32) || defined(TARGET_ANDROID)
>
>  #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
> @@ -174,6 +178,9 @@ struct tuntap
>       * ~0 if undefined */
>      DWORD adapter_index;
>
> +    bool wintun; /* true if wintun is used instead of tap-windows6 */
> +    char wintun_padding[16];
> +
>      int standby_iter;
>  #else  /* ifdef _WIN32 */
>      int fd; /* file descriptor for TUN/TAP dev */
> @@ -337,6 +344,7 @@ route_order(void)
>  struct tap_reg
>  {
>      const char *guid;
> +    DWORD luid_index;
>      struct tap_reg *next;
>  };
>
> @@ -374,7 +382,7 @@ DWORD adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>                            int *count,
>                            in_addr_t *netmask);
>
> -void show_tap_win_adapters(int msglev, int warnlev);
> +void show_tap_win_adapters(int msglev, int warnlev, bool wintun);
>
>  void show_adapters(int msglev);
>
> @@ -465,6 +473,30 @@ read_tun_buffered(struct tuntap *tt, struct buffer
> *buf)
>  static inline int
>  write_tun_buffered(struct tuntap *tt, struct buffer *buf)
>  {
> +    if (tt->wintun)
> +    {
> +        int len =3D BLEN(buf);
> +
> +        /* variable len end padding */
> +        int end_padding_len =3D 16 - (len & 15);
> +        if (!buf_write(buf, tt->wintun_padding, end_padding_len))
> +        {
> +            return -1;
> +        }
> +
> +        /* 12 bytes start padding */
> +        if (!buf_write_prepend(buf, tt->wintun_padding, 12))
> +        {
> +            return -1;
> +        }
> +
> +        /* 4 bytes size */
> +        if (!buf_write_prepend(buf, &len, 4))
> +        {
> +            return -1;
> +        }
> +    }
> +
>      return tun_write_win32(tt, buf);
>  }
>
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index eb4c030..4b4a2b1 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -164,20 +164,34 @@ init_security_attributes_allow_all(struct
> security_attributes *obj)
>  void
>  overlapped_io_init(struct overlapped_io *o,
>                     const struct frame *frame,
> -                   BOOL event_state,
> -                   bool tuntap_buffer)  /* if true: tuntap buffer, if
> false: socket buffer */
> +                   bool reads, /* if true: reads buffer, if false: writes
> buffer */
> +                   bool tuntap_buffer,  /* if true: tuntap buffer, if
> false: socket buffer */
> +                   bool wintun)
>  {
>      CLEAR(*o);
>
>      /* manual reset event, initially set according to event_state */
> -    o->overlapped.hEvent =3D CreateEvent(NULL, TRUE, event_state, NULL);
> +    o->overlapped.hEvent =3D CreateEvent(NULL, TRUE, reads ? FALSE : TRU=
E,
> NULL);
>      if (o->overlapped.hEvent =3D=3D NULL)
>      {
>          msg(M_ERR, "Error: overlapped_io_init: CreateEvent failed");
>      }
>
> -    /* allocate buffer for overlapped I/O */
> -    alloc_buf_sock_tun(&o->buf_init, frame, tuntap_buffer, 0);
> +    if (wintun && tuntap_buffer && reads)
> +    {
> +        /*
> +         * wintun could return up to 256 packets,
> +         * each packet is accompanied with size, start and end padding
> +        */
> +        int buf_size =3D (MAX_RW_SIZE_TUN(frame) + 4 + 12 + 15) * 256;
> +        o->buf_init =3D alloc_buf(buf_size);
> +        o->buf_init.len =3D buf_size;
> +    }
> +    else
> +    {
> +        /* allocate buffer for overlapped I/O */
> +        alloc_buf_sock_tun(&o->buf_init, frame, tuntap_buffer, 0);
> +    }
>  }
>
>  void
> @@ -1493,4 +1507,99 @@ send_msg_iservice(HANDLE pipe, const void *data,
> size_t size,
>      return ret;
>  }
>
> +bool
> +impersonate_as_system()
> +{
> +    HANDLE thread_token, process_snapshot, winlogon_process,
> winlogon_token, duplicated_token, file_handle;
> +    PROCESSENTRY32 entry;
> +    BOOL ret;
> +    DWORD pid =3D 0;
> +    TOKEN_PRIVILEGES privileges;
> +
> +    CLEAR(entry);
> +    CLEAR(privileges);
> +
> +    entry.dwSize =3D sizeof(PROCESSENTRY32);
> +
> +    privileges.PrivilegeCount =3D 1;
> +    privileges.Privileges->Attributes =3D SE_PRIVILEGE_ENABLED;
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
> +    process_snapshot =3D CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
> +    if (process_snapshot =3D=3D INVALID_HANDLE_VALUE)
> +    {
> +        RevertToSelf();
> +        return false;
> +    }
> +    for (ret =3D Process32First(process_snapshot, &entry); ret; ret =3D
> Process32Next(process_snapshot, &entry))
> +    {
> +        if (!_stricmp(entry.szExeFile, "winlogon.exe"))
> +        {
> +            pid =3D entry.th32ProcessID;
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
> +    winlogon_process =3D OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, p=
id);
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
>  #endif /* ifdef _WIN32 */
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 4814bbc..e511b56 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -212,10 +212,12 @@ struct overlapped_io {
>      struct buffer buf;
>  };
>
> -void overlapped_io_init(struct overlapped_io *o,
> -                        const struct frame *frame,
> -                        BOOL event_state,
> -                        bool tuntap_buffer);
> +void
> +overlapped_io_init(struct overlapped_io *o,
> +                   const struct frame *frame,
> +                   bool reads, /* if true: reads buffer, if false: writes
> buffer */
> +                   bool tuntap_buffer,  /* if true: tuntap buffer, if
> false: socket buffer */
> +                   bool wintun);
>
>  void overlapped_io_close(struct overlapped_io *o);
>
> @@ -323,5 +325,14 @@ bool send_msg_iservice(HANDLE pipe, const void *data,
> size_t size,
>  int
>  openvpn_execve(const struct argv *a, const struct env_set *es, const
> unsigned int flags);
>
> +/**
> + * Impersonates current thread as SYSTEM, required
> + * to open Wintun device.
> + *
> + * @returns     True if it succeeds, false if it fails.
> + */
> +bool
> +impersonate_as_system();
> +
>  #endif /* ifndef OPENVPN_WIN32_H */
>  #endif /* ifdef _WIN32 */
> --
> 2.7.4
>
>

--=20
-Lev

--000000000000982229058abca93b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If someone would like to test it - you can get a Windows b=
inary from here:=C2=A0<a href=3D"https://ci.appveyor.com/api/buildjobs/w20k=
nnbut89uoeuw/artifacts/msvc%2Fimage%2Fbin.zip">https://ci.appveyor.com/api/=
buildjobs/w20knnbut89uoeuw/artifacts/msvc%2Fimage%2Fbin.zip</a><div><br></d=
iv><div>Note that interactive service doesn&#39;t (yet) work with Wintun, y=
ou need to run openvpn as a privileged process. For example, from Administr=
ator command prompt:</div><div><br></div><div>&gt; c:\Temp\ovpn2_wintun&gt;=
openvpn.exe --config lev.ovpn --windows-driver wintun<br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">ke 5. kes=C3=
=A4k. 2019 klo 17.59 Lev Stipakov (<a href=3D"mailto:lstipakov@...277...">l=
stipakov@...277...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." =
target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
This adds experimental support for Wintun,<br>
an alternative to tap-windows6 on Windows.<br>
<br>
To use wintun, specify<br>
<br>
=C2=A0 --windows-driver wintun<br>
<br>
as config option. Default value is &quot;tap-windows6&quot;.<br>
<br>
Unlike tap-windows6, Wintun returns up to 256 packets,<br>
which have to be decapsulated and processed one by one.<br>
We do it by reading data into a new buffer, processing<br>
single packet and returning control to event loop<br>
to give it a chance to write processed packet to link.<br>
<br>
If there are no pending writes and there is data in wintun<br>
buffer, event loop triggers tun read. There we read single<br>
packet from wintun buffer or, if it is empty, read from<br>
tun driver.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/forward.c |=C2=A0 76 +++++++++++++++++-<br>
=C2=A0src/openvpn/forward.h |=C2=A0 15 ++++<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 |=C2=A0 =C2=A07 ++<br>
=C2=A0src/openvpn/openvpn.h |=C2=A0 =C2=A04 +<br>
=C2=A0src/openvpn/options.c |=C2=A0 36 ++++++++-<br>
=C2=A0src/openvpn/options.h |=C2=A0 =C2=A01 +<br>
=C2=A0src/openvpn/socket.c=C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0src/openvpn/syshead.h |=C2=A0 =C2=A01 +<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0| 212 ++++++++++++++++++++++++++=
+++++++-----------------<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 34 +++++++-<br>
=C2=A0src/openvpn/win32.c=C2=A0 =C2=A0| 119 ++++++++++++++++++++++++++--<br>
=C2=A0src/openvpn/win32.h=C2=A0 =C2=A0|=C2=A0 19 ++++-<br>
=C2=A012 files changed, 441 insertions(+), 87 deletions(-)<br>
<br>
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<br>
index ad4c1f5..8077835 100644<br>
--- a/src/openvpn/forward.c<br>
+++ b/src/openvpn/forward.c<br>
@@ -2182,6 +2182,52 @@ io_wait_dowork(struct context *c, const unsigned int=
 flags)<br>
=C2=A0 =C2=A0 =C2=A0dmsg(D_EVENT_WAIT, &quot;I/O WAIT status=3D0x%04x&quot;=
, c-&gt;c2.event_set_status);<br>
=C2=A0}<br>
<br>
+#ifdef _WIN32<br>
+/**<br>
+ * This processes single packet from wintun buffer,<br>
+ * which can contain up to 256 packets.<br>
+ */<br>
+static void<br>
+process_incoming_wintun(struct context *c)<br>
+{<br>
+=C2=A0 =C2=A0 struct buffer *buf =3D &amp;c-&gt;c2.wintun_buf;<br>
+=C2=A0 =C2=A0 uint32_t *size =3D NULL;<br>
+=C2=A0 =C2=A0 int end_padding_len =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 /* get packet size */<br>
+=C2=A0 =C2=A0 size =3D (uint32_t *)buf_read_alloc(buf, 4);<br>
+=C2=A0 =C2=A0 if (size =3D=3D NULL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* skip start padding */<br>
+=C2=A0 =C2=A0 if (!buf_advance(buf, 12))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* copy packet */<br>
+=C2=A0 =C2=A0 c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;read_tun_buf;<br>
+=C2=A0 =C2=A0 buf_init(&amp;c-&gt;c2.buf, FRAME_HEADROOM(&amp;c-&gt;c2.fra=
me));<br>
+=C2=A0 =C2=A0 buf_safe(&amp;c-&gt;c2.buf, MAX_RW_SIZE_TUN(&amp;c-&gt;c2.fr=
ame));<br>
+=C2=A0 =C2=A0 if (!buf_copy_n(&amp;c-&gt;c2.buf, buf, (int)*size))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* this encrypts packet and puts it to c-&gt;c2.to_link buff=
er */<br>
+=C2=A0 =C2=A0 process_incoming_tun(c);<br>
+<br>
+=C2=A0 =C2=A0 /* skip end padding */<br>
+=C2=A0 =C2=A0 end_padding_len =3D (16 - (*size &amp; 15)) % 16;<br>
+=C2=A0 =C2=A0 if (!buf_advance(buf, end_padding_len))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+#endif<br>
+<br>
=C2=A0void<br>
=C2=A0process_io(struct context *c)<br>
=C2=A0{<br>
@@ -2217,10 +2263,34 @@ process_io(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0/* Incoming data on TUN device */<br>
=C2=A0 =C2=A0 =C2=A0else if (status &amp; TUN_READ)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_incoming_tun(c);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!IS_SIG(c))<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only read from driver if ther=
e are no packets in buffer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (BLEN(&amp;c-&gt;c2.wintun_bu=
f) =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_incoming_tun(=
c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c2.wintun_bu=
f =3D c-&gt;c2.buf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!IS_SIG(c))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 process_incoming_w=
intun(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We need to write process=
ed wintun packet to link,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* hence we give control ba=
ck to event loop, which will<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* call us again if wintun =
buffer is not empty<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 process_incoming_tun(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_incoming_tun(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!IS_SIG(c))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 process_incoming_t=
un(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h<br>
index 48202c0..ac3e932 100644<br>
--- a/src/openvpn/forward.h<br>
+++ b/src/openvpn/forward.h<br>
@@ -61,6 +61,7 @@<br>
=C2=A0#define IOW_MBUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;7=
)<br>
=C2=A0#define IOW_READ_TUN_FORCE=C2=A0 (1&lt;&lt;8)<br>
=C2=A0#define IOW_WAIT_SIGNAL=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;9)<br>
+#define IOW_READ_WINTUN_BUF (1&lt;&lt;10)<br>
<br>
=C2=A0#define IOW_READ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (IOW_READ_T=
UN|IOW_READ_LINK)<br>
<br>
@@ -375,6 +376,12 @@ p2p_iow_flags(const struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D IOW_TO_TUN;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 if (c-&gt;c2.wintun_buf.len &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D IOW_READ_WINTUN_BUF;<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0return flags;<br>
=C2=A0}<br>
<br>
@@ -401,6 +408,14 @@ io_wait(struct context *c, const unsigned int flags)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.event_set_status =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 /* make sure we write to link before reading from wintun buf=
fer,<br>
+=C2=A0 =C2=A0 =C2=A0* otherwise we&#39;ll overwrite c2-&gt;to_link buffer =
and lose a packet */<br>
+=C2=A0 =C2=A0 else if (!(flags &amp; IOW_TO_LINK) &amp;&amp; (flags &amp; =
IOW_READ_WINTUN_BUF))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c2.event_set_status =3D TUN_READ;<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* slow path */<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
index ef26503..1625272 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -1696,6 +1696,10 @@ do_init_tun(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!c-&gt;options.ifconfig_nowarn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;<a href=3D"http://c2.es" rel=3D"norefe=
rrer" target=3D"_blank">c2.es</a>);<br>
<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;wintun =3D c-&gt;options.wintun;<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0init_tun_post(c-&gt;c1.tuntap,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;c=
-&gt;c2.frame,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;c=
-&gt;options.tuntap_options);<br>
@@ -1738,6 +1742,9 @@ do_open_tun(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0/* store (hide) interactive service handle in tuntap_op=
tions */<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;c1.tuntap-&gt;options.msg_channel =3D c-&gt;optio=
ns.msg_channel;<br>
=C2=A0 =C2=A0 =C2=A0msg(D_ROUTE, &quot;interactive service msg_channel=3D%u=
&quot;, (unsigned int) c-&gt;options.msg_channel);<br>
+<br>
+=C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;wintun =3D c-&gt;options.wintun;<br>
+<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* allocate route list structure */<br>
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h<br>
index d11f61d..d694666 100644<br>
--- a/src/openvpn/openvpn.h<br>
+++ b/src/openvpn/openvpn.h<br>
@@ -382,6 +382,10 @@ struct context_2<br>
=C2=A0 =C2=A0 =C2=A0struct buffer buf;<br>
=C2=A0 =C2=A0 =C2=A0struct buffer to_tun;<br>
=C2=A0 =C2=A0 =C2=A0struct buffer to_link;<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 /* contains up to 256 packets */<br>
+=C2=A0 =C2=A0 struct buffer wintun_buf;<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* should we print R|W|r|w to console on packet transfe=
rs? */<br>
=C2=A0 =C2=A0 =C2=A0bool log_rw;<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index e34b65b..534a6be 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -845,6 +845,7 @@ init_options(struct options *o, const bool init_gc)<br>
=C2=A0 =C2=A0 =C2=A0o-&gt;tuntap_options.dhcp_masq_offset =3D 0;=C2=A0 =C2=
=A0 =C2=A0/* use network address as internal DHCP server address */<br>
=C2=A0 =C2=A0 =C2=A0o-&gt;route_method =3D ROUTE_METHOD_ADAPTIVE;<br>
=C2=A0 =C2=A0 =C2=A0o-&gt;block_outside_dns =3D false;<br>
+=C2=A0 =C2=A0 o-&gt;wintun =3D false;<br>
=C2=A0#endif<br>
=C2=A0#if P2MP_SERVER<br>
=C2=A0 =C2=A0 =C2=A0o-&gt;real_hash_size =3D 256;<br>
@@ -2937,6 +2938,12 @@ options_postprocess_mutate_invariant(struct options =
*options)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;ifconfig_noexec =3D false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* for wintun kernel doesn&#39;t send DHCP requests, so use =
ipapi to set IP address and netmask */<br>
+=C2=A0 =C2=A0 if (options-&gt;wintun)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;tuntap_options.ip_win32_type =3D I=
PW32_SET_IPAPI;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0remap_redirect_gateway_flags(options);<br>
=C2=A0#endif<br>
<br>
@@ -3980,6 +3987,26 @@ foreign_option(struct options *o, char *argv[], int =
len, struct env_set *es)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+#ifdef _WIN32<br>
+bool<br>
+parse_windows_driver(const char *str, const int msglevel)<br>
+{<br>
+=C2=A0 =C2=A0 if (streq(str, &quot;tap&quot;))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (streq(str, &quot;wintun&quot;))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;--windows-driver must be t=
ap-windows6 or wintun&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+#endif<br>
+<br>
=C2=A0/*<br>
=C2=A0 * parse/print topology coding<br>
=C2=A0 */<br>
@@ -5220,6 +5247,13 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_GENERAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;dev_type =3D p[1];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 else if (streq(p[0], &quot;windows-driver&quot;) &amp;&amp; =
p[1] &amp;&amp; !p[2])<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION(OPT_P_GENERAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;wintun =3D parse_windows_driver(p[=
1], M_FATAL);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;dev-node&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[2])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_GENERAL);<br>
@@ -7217,7 +7251,7 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;show-adapters&quot;) &amp;&a=
mp; !p[1])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_GENERAL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 show_tap_win_adapters(M_INFO|M_NOPREFIX, M_WAR=
N|M_NOPREFIX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 show_tap_win_adapters(M_INFO|M_NOPREFIX, M_WAR=
N|M_NOPREFIX, options-&gt;wintun);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /=
* exit point */<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;show-net&quot;) &amp;&amp; !=
p[1])<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index e2b3893..670b70a 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -614,6 +614,7 @@ struct options<br>
=C2=A0 =C2=A0 =C2=A0bool show_net_up;<br>
=C2=A0 =C2=A0 =C2=A0int route_method;<br>
=C2=A0 =C2=A0 =C2=A0bool block_outside_dns;<br>
+=C2=A0 =C2=A0 bool wintun;<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0bool use_peer_id;<br>
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c<br>
index c472cf1..4352869 100644<br>
--- a/src/openvpn/socket.c<br>
+++ b/src/openvpn/socket.c<br>
@@ -1635,8 +1635,8 @@ static void<br>
=C2=A0socket_frame_init(const struct frame *frame, struct link_socket *sock=
)<br>
=C2=A0{<br>
=C2=A0#ifdef _WIN32<br>
-=C2=A0 =C2=A0 overlapped_io_init(&amp;sock-&gt;reads, frame, FALSE, false)=
;<br>
-=C2=A0 =C2=A0 overlapped_io_init(&amp;sock-&gt;writes, frame, TRUE, false)=
;<br>
+=C2=A0 =C2=A0 overlapped_io_init(&amp;sock-&gt;reads, frame, true, false, =
false);<br>
+=C2=A0 =C2=A0 overlapped_io_init(&amp;sock-&gt;writes, frame, false, false=
, false);<br>
=C2=A0 =C2=A0 =C2=A0sock-&gt;rw_handle.read =3D sock-&gt;reads.overlapped.h=
Event;<br>
=C2=A0 =C2=A0 =C2=A0sock-&gt;rw_handle.write =3D sock-&gt;writes.overlapped=
.hEvent;<br>
=C2=A0#endif<br>
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h<br>
index 2b4c49f..e7cbf25 100644<br>
--- a/src/openvpn/syshead.h<br>
+++ b/src/openvpn/syshead.h<br>
@@ -39,6 +39,7 @@<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0#include &lt;windows.h&gt;<br>
=C2=A0#include &lt;winsock2.h&gt;<br>
+#include &lt;tlhelp32.h&gt;<br>
=C2=A0#define sleep(x) Sleep((x)*1000)<br>
=C2=A0#define random rand<br>
=C2=A0#define srandom srand<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index e929b50..5fd8339 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -788,8 +788,8 @@ init_tun_post(struct tuntap *tt,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;options =3D *options;<br>
=C2=A0#ifdef _WIN32<br>
-=C2=A0 =C2=A0 overlapped_io_init(&amp;tt-&gt;reads, frame, FALSE, true);<b=
r>
-=C2=A0 =C2=A0 overlapped_io_init(&amp;tt-&gt;writes, frame, TRUE, true);<b=
r>
+=C2=A0 =C2=A0 overlapped_io_init(&amp;tt-&gt;reads, frame, true, true, tt-=
&gt;wintun);<br>
+=C2=A0 =C2=A0 overlapped_io_init(&amp;tt-&gt;writes, frame, false, true, t=
t-&gt;wintun);<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;rw_handle.read =3D tt-&gt;reads.overlapped.hEven=
t;<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;rw_handle.write =3D tt-&gt;writes.overlapped.hEv=
ent;<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;adapter_index =3D TUN_ADAPTER_INDEX_INVALID;<br>
@@ -3430,7 +3430,7 @@ tun_finalize(<br>
=C2=A0}<br>
<br>
=C2=A0const struct tap_reg *<br>
-get_tap_reg(struct gc_arena *gc)<br>
+get_tap_reg(struct gc_arena *gc, bool wintun)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0HKEY adapter_key;<br>
=C2=A0 =C2=A0 =C2=A0LONG status;<br>
@@ -3461,6 +3461,20 @@ get_tap_reg(struct gc_arena *gc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char net_cfg_instance_id_string[] =3D &qu=
ot;NetCfgInstanceId&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char net_cfg_instance_id[256];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD data_type;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char expected_component_id[256];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char expected_root_component_id[256];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char net_luid_index_string[] =3D &quot;NetLuid=
Index&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD luid_index;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy(expected_component_id, WI=
NTUN_COMPONENT_ID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy(expected_component_id, TA=
P_WIN_COMPONENT_ID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(expected_root_component_id, s=
izeof(expected_root_component_id), &quot;root\\%s&quot;, expected_component=
_id);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D sizeof(enum_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D RegEnumKeyEx(<br>
@@ -3525,13 +3539,27 @@ get_tap_reg(struct gc_arena *gc)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =
=3D=3D ERROR_SUCCESS &amp;&amp; data_type =3D=3D REG_SZ)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 !strcmp(component_id, &quot;root\\&quot; TAP_WIN_COMPONENT_ID))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!strcmp(component_id, expected_component_id) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 !strcmp(component_id, expected_root_component_id))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct tap_reg *reg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0reg-&gt;guid =3D string_alloc(net_cfg_instance_id, gc);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 len =3D sizeof(luid_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 status =3D RegQueryValueEx(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 unit_key,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 net_luid_index_string,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;data_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (LPBYTE)&amp;luid_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;len);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (status =3D=3D ERROR_SUCCESS &amp;&amp; data_type =3D=3D REG_=
DWORD)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;luid_index =3D luid_index;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* link into return list */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (!first)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{<br>
@@ -3744,7 +3772,7 @@ show_valid_win32_tun_subnets(void)<br>
=C2=A0}<br>
<br>
=C2=A0void<br>
-show_tap_win_adapters(int msglev, int warnlev)<br>
+show_tap_win_adapters(int msglev, int warnlev, bool wintun)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
<br>
@@ -3758,10 +3786,10 @@ show_tap_win_adapters(int msglev, int warnlev)<br>
=C2=A0 =C2=A0 =C2=A0const struct tap_reg *tr1;<br>
=C2=A0 =C2=A0 =C2=A0const struct panel_reg *pr;<br>
<br>
-=C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(&amp;gc);<br>
+=C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(&amp;gc, wintu=
n);<br>
=C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg =3D get_panel_reg(&am=
p;gc);<br>
<br>
-=C2=A0 =C2=A0 msg(msglev, &quot;Available TAP-WIN32 adapters [name, GUID]:=
&quot;);<br>
+=C2=A0 =C2=A0 msg(msglev, &quot;Available %s adapters [name, GUID]:&quot;,=
 wintun ? &quot;WinTun&quot; : &quot;TAP-WIN32&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* loop through each TAP-Windows adapter registry entry=
 */<br>
=C2=A0 =C2=A0 =C2=A0for (tr =3D tap_reg; tr !=3D NULL; tr =3D tr-&gt;next)<=
br>
@@ -3883,13 +3911,14 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)=
<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
- * Get an adapter GUID and optional actual_name from the<br>
+ * Get an adapter GUID, LUID index and optional actual_name from the<br>
=C2=A0 * registry for the TAP device # =3D device_number.<br>
=C2=A0 */<br>
=C2=A0static const char *<br>
=C2=A0get_unspecified_device_guid(const int device_number,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *actual_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int actual_name_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int *luid_index,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct tap_reg *tap_reg_src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg_src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gc_arena *gc)<br>
@@ -3938,6 +3967,11 @@ get_unspecified_device_guid(const int device_number,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (luid_index)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *luid_index =3D tap_reg-&gt;luid_index;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Save GUID for return value */<br>
=C2=A0 =C2=A0 =C2=A0ret =3D alloc_buf_gc(256, gc);<br>
=C2=A0 =C2=A0 =C2=A0buf_printf(&amp;ret, &quot;%s&quot;, tap_reg-&gt;guid);=
<br>
@@ -4536,7 +4570,7 @@ get_adapter_index_flexible(const char *name)=C2=A0 /*=
 actual name or GUID */<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (index =3D=3D TUN_ADAPTER_INDEX_INVALID)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(=
&amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(=
&amp;gc, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg =3D get=
_panel_reg(&amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *guid =3D name_to_guid(name, t=
ap_reg, panel_reg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D get_adapter_index_method_1(guid=
);<br>
@@ -4663,7 +4697,7 @@ void<br>
=C2=A0tap_allow_nonadmin_access(const char *dev_node)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
-=C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(&amp;gc);<br>
+=C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(&amp;gc, false=
);<br>
=C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg =3D get_panel_reg(&am=
p;gc);<br>
=C2=A0 =C2=A0 =C2=A0const char *device_guid =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE hand;<br>
@@ -4717,6 +4751,7 @@ tap_allow_nonadmin_access(const char *dev_node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actual_buffer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(actual_buffer),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tap_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0panel_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;gc);<br>
<br>
@@ -5239,7 +5274,7 @@ out:<br>
=C2=A0static const char *<br>
=C2=A0netsh_get_id(const char *dev_node, struct gc_arena *gc)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(gc);<br>
+=C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(gc, false);<br>
=C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg =3D get_panel_reg(gc)=
;<br>
=C2=A0 =C2=A0 =C2=A0struct buffer actual =3D alloc_buf_gc(256, gc);<br>
=C2=A0 =C2=A0 =C2=A0const char *guid;<br>
@@ -5252,9 +5287,9 @@ netsh_get_id(const char *dev_node, struct gc_arena *g=
c)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 guid =3D get_unspecified_device_guid(0, BPTR(&=
amp;actual), BCAP(&amp;actual), tap_reg, panel_reg, gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 guid =3D get_unspecified_device_guid(0, BPTR(&=
amp;actual), BCAP(&amp;actual), NULL, tap_reg, panel_reg, gc);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_unspecified_device_guid(1, NULL, 0, ta=
p_reg, panel_reg, gc)) /* ambiguous if more than one TAP-Windows adapter */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_unspecified_device_guid(1, NULL, 0, NU=
LL, tap_reg, panel_reg, gc)) /* ambiguous if more than one TAP-Windows adap=
ter */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guid =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -5528,6 +5563,7 @@ open_tun(const char *dev, const char *dev_type, const=
 char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
=C2=A0 =C2=A0 =C2=A0char device_path[256];<br>
=C2=A0 =C2=A0 =C2=A0const char *device_guid =3D NULL;<br>
+=C2=A0 =C2=A0 DWORD device_luid_index =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0DWORD len;<br>
=C2=A0 =C2=A0 =C2=A0bool dhcp_masq =3D false;<br>
=C2=A0 =C2=A0 =C2=A0bool dhcp_masq_post =3D false;<br>
@@ -5554,7 +5590,7 @@ open_tun(const char *dev, const char *dev_type, const=
 char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 * Lookup the device name in the registry, using the --=
dev-node high level name.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(=
&amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct tap_reg *tap_reg =3D get_tap_reg(=
&amp;gc, tt-&gt;wintun);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg =3D get=
_panel_reg(&amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char actual_buffer[256];<br>
<br>
@@ -5601,6 +5637,7 @@ open_tun(const char *dev, const char *dev_type, const=
 char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_guid =
=3D get_unspecified_device_guid(device_number,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actual_buffer=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(actual=
_buffer),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;device_luid_in=
dex,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tap_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0panel_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;gc);<br>
@@ -5610,11 +5647,28 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0msg(M_FATAL, &quot;All TAP-Windows adapters on this system are currently=
 in use.&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open Windows TA=
P-Windows adapter */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(d=
evice_path, sizeof(device_path), &quot;%s%s%s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USERMODEDEVICEDIR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_guid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_WIN_SUFFIX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open wintun / t=
ap-windows6 adapter */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;wintun)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open=
vpn_snprintf(device_path, sizeof(device_path), &quot;%sWINTUN%lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USERMODEDEVICEDI=
R,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_luid_inde=
x);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open=
vpn_snprintf(device_path, sizeof(device_path), &quot;%s%s%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USERMODEDEVICEDI=
R,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_guid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_WIN_SUFFIX);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;wintun)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!impersonate_as_system())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msg(M_FATAL, &quot;ERROR:=C2=A0 Failed to impersonate as SYSTEM,=
 make sure process is running under privileged account&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;hand =
=3D CreateFile(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0device_path,<br>
@@ -5626,6 +5680,14 @@ open_tun(const char *dev, const char *dev_type, cons=
t char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;wintun)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!RevertToSelf())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msg(M_FATAL, &quot;ERROR:=C2=A0 RevertToSelf error: %lu&quot;, G=
etLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tt-&gt;ha=
nd =3D=3D INVALID_HANDLE_VALUE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0msg(D_TUNTAP_INFO, &quot;CreateFile failed on TAP device: %s&quot;, devi=
ce_path);<br>
@@ -5644,12 +5706,14 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;actual_name =3D string_alloc(actua=
l_buffer, NULL);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 msg(M_INFO, &quot;TAP-WIN32 device [%s] opened: %s&quot;, tt=
-&gt;actual_name, device_path);<br>
+=C2=A0 =C2=A0 msg(M_INFO, &quot;%s device device [%s] opened: %s&quot;, tt=
-&gt;wintun ? &quot;Wintun&quot; : &quot;TAP - WIN32&quot;, tt-&gt;actual_n=
ame, device_path);<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;adapter_index =3D get_adapter_index(device_guid)=
;<br>
<br>
-=C2=A0 =C2=A0 /* get driver version info */<br>
+=C2=A0 =C2=A0 if (!tt-&gt;wintun)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* get driver version info */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ULONG info[3];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ULONG mtu;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CLEAR(info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DeviceIoControl(tt-&gt;hand, TAP_WIN_=
IOCTL_GET_VERSION,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;info, sizeof(info),<br>
@@ -5684,11 +5748,8 @@ open_tun(const char *dev, const char *dev_type, cons=
t char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg( M_FATAL, &quot;ERROR:=
=C2=A0 Tap-Win32 driver version %d.%d is buggy regarding small IPv4 packets=
 in TUN mode. Upgrade your Tap-Win32 driver.&quot;, (int) info[0], (int) in=
fo[1] );<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 /* get driver MTU */<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ULONG mtu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* get driver MTU */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DeviceIoControl(tt-&gt;hand, TAP_WIN_=
IOCTL_GET_MTU,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;mtu, sizeof(mtu),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;mtu, sizeof(mtu), &amp;len, NULL))<br>
@@ -5746,7 +5807,7 @@ open_tun(const char *dev, const char *dev_type, const=
 char *dev_node, struct tun<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* set point-to-point mode if TUN device */<br>
<br>
-=C2=A0 =C2=A0 if (tt-&gt;type =3D=3D DEV_TYPE_TUN)<br>
+=C2=A0 =C2=A0 if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; !tt-&gt;wintu=
n)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tt-&gt;did_ifconfig_setup &amp;&amp;=
 !tt-&gt;did_ifconfig_ipv6_setup)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -5834,71 +5895,80 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ep[2] =3D dhcp_masq_addr(tt=
-&gt;local, tt-&gt;adapter_netmask, tt-&gt;options.dhcp_masq_custom_offset =
? tt-&gt;options.dhcp_masq_offset : 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* lease time in seconds */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[3] =3D (uint32_t) tt-&gt;options.dhcp_lease=
_time;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* lease time in seconds */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[3] =3D (uint32_t)tt-&gt;optio=
ns.dhcp_lease_time;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(ep[3] &gt; 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(ep[3] &gt; 0);<br>
<br>
=C2=A0#ifndef SIMULATE_DHCP_FAILED /* this code is disabled to simulate bad=
 DHCP negotiation */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCT=
L_CONFIG_DHCP_MASQ,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ep, sizeof(ep),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ep, sizeof(ep), &amp;len, NULL))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;ERROR: The TA=
P-Windows driver rejected a DeviceIoControl call to set TAP_WIN_IOCTL_CONFI=
G_DHCP_MASQ mode&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeviceIoControl(tt-&gt;hand=
, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep, sizeof(ep),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep, sizeof(ep), &a=
mp;len, NULL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot=
;ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set TAP_W=
IN_IOCTL_CONFIG_DHCP_MASQ mode&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;Notified TAP-Windows driver =
to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-tim=
e: %d]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(tt-&gt;local, 0,=
 &amp;gc),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(tt-&gt;adapter_n=
etmask, 0, &amp;gc),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(ep[2], IA_NET_OR=
DER, &amp;gc),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;Notified TAP-W=
indows driver to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv:=
 %s, lease-time: %d]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(tt=
-&gt;local, 0, &amp;gc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(tt=
-&gt;adapter_netmask, 0, &amp;gc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(ep=
[2], IA_NET_ORDER, &amp;gc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[3]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* user-supplied DHCP options capability */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.dhcp_options)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer buf =3D alloc_buf(=
256);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (build_dhcp_options_string(&a=
mp;buf, &amp;tt-&gt;options))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* user-supplied DHCP options ca=
pability */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.dhcp_options)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_DHCP_OPT, &q=
uot;DHCP option string: %s&quot;, format_hex(BPTR(&amp;buf), BLEN(&amp;buf)=
, 0, &amp;gc));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeviceIoContr=
ol(tt-&gt;hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BPTR(&amp;buf), =
BLEN(&amp;buf),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BPTR(&amp;buf), =
BLEN(&amp;buf), &amp;len, NULL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer buf =
=3D alloc_buf(256);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (build_dhcp_opt=
ions_string(&amp;buf, &amp;tt-&gt;options))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_FATAL, &quot;ERROR: The TAP-Windows driver rejected a TAP_WIN_IOCTL_CONFI=
G_DHCP_SET_OPT DeviceIoControl call&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
D_DHCP_OPT, &quot;DHCP option string: %s&quot;, format_hex(BPTR(&amp;buf), =
BLEN(&amp;buf), 0, &amp;gc));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BPTR(&amp;buf), BLEN(&amp;buf),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BPTR(&amp;buf), BLEN(&amp;buf), &amp;len, NULL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msg(M_FATAL, &quot;ERROR: The TAP-Windows driver rejected a TAP_=
WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_WARN, &quot;DHCP option string not set due to error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_buf(&amp;buf)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;=
DHCP option string not set due to error&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_buf(&amp;buf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif /* ifndef SIMULATE_DHCP_FAILED */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* set driver media status to &#39;connected&#39; */<br>
+=C2=A0 =C2=A0 if (!tt-&gt;wintun)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ULONG status =3D TRUE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCT=
L_SET_MEDIA_STATUS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;status, sizeof(status),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;status, sizeof(status), &amp;len, NULL)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set driver media status to &#39;connected&#=
39; */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;WARNING: The T=
AP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl=
 call.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ULONG status =3D TRUE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeviceIoControl(tt-&gt;hand=
, TAP_WIN_IOCTL_SET_MEDIA_STATUS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;status, sizeo=
f(status),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;status, sizeo=
f(status), &amp;len, NULL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;WARNING=
: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIo=
Control call.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 /* possible wait for adapter to come up */<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int s =3D tt-&gt;options.tap_sleep;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s &gt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* possible wait for adapter to come up */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;Sleeping for %=
d seconds...&quot;, s);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 management_sleep(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int s =3D tt-&gt;options.tap_sle=
ep;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s &gt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;=
Sleeping for %d seconds...&quot;, s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 management_sleep(s=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* possibly use IP Helper API to set IP address on adap=
ter */<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const DWORD index =3D tt-&gt;adapter_inde=
x;<br>
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<br>
index 9ed8ef0..6591d59 100644<br>
--- a/src/openvpn/tun.h<br>
+++ b/src/openvpn/tun.h<br>
@@ -37,6 +37,10 @@<br>
=C2=A0#include &quot;proto.h&quot;<br>
=C2=A0#include &quot;misc.h&quot;<br>
<br>
+#ifdef _WIN32<br>
+#define WINTUN_COMPONENT_ID &quot;wintun&quot;<br>
+#endif<br>
+<br>
=C2=A0#if defined(_WIN32) || defined(TARGET_ANDROID)<br>
<br>
=C2=A0#define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)<br>
@@ -174,6 +178,9 @@ struct tuntap<br>
=C2=A0 =C2=A0 =C2=A0 * ~0 if undefined */<br>
=C2=A0 =C2=A0 =C2=A0DWORD adapter_index;<br>
<br>
+=C2=A0 =C2=A0 bool wintun; /* true if wintun is used instead of tap-window=
s6 */<br>
+=C2=A0 =C2=A0 char wintun_padding[16];<br>
+<br>
=C2=A0 =C2=A0 =C2=A0int standby_iter;<br>
=C2=A0#else=C2=A0 /* ifdef _WIN32 */<br>
=C2=A0 =C2=A0 =C2=A0int fd; /* file descriptor for TUN/TAP dev */<br>
@@ -337,6 +344,7 @@ route_order(void)<br>
=C2=A0struct tap_reg<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *guid;<br>
+=C2=A0 =C2=A0 DWORD luid_index;<br>
=C2=A0 =C2=A0 =C2=A0struct tap_reg *next;<br>
=C2=A0};<br>
<br>
@@ -374,7 +382,7 @@ DWORD adapter_index_of_ip(const IP_ADAPTER_INFO *list,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int *count,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0in_addr_t *netmask);<br>
<br>
-void show_tap_win_adapters(int msglev, int warnlev);<br>
+void show_tap_win_adapters(int msglev, int warnlev, bool wintun);<br>
<br>
=C2=A0void show_adapters(int msglev);<br>
<br>
@@ -465,6 +473,30 @@ read_tun_buffered(struct tuntap *tt, struct buffer *bu=
f)<br>
=C2=A0static inline int<br>
=C2=A0write_tun_buffered(struct tuntap *tt, struct buffer *buf)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 if (tt-&gt;wintun)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D BLEN(buf);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* variable len end padding */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int end_padding_len =3D 16 - (len &amp; 15);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf_write(buf, tt-&gt;wintun_padding, end=
_padding_len))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 12 bytes start padding */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf_write_prepend(buf, tt-&gt;wintun_padd=
ing, 12))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 4 bytes size */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf_write_prepend(buf, &amp;len, 4))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return tun_write_win32(tt, buf);<br>
=C2=A0}<br>
<br>
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c<br>
index eb4c030..4b4a2b1 100644<br>
--- a/src/openvpn/win32.c<br>
+++ b/src/openvpn/win32.c<br>
@@ -164,20 +164,34 @@ init_security_attributes_allow_all(struct security_at=
tributes *obj)<br>
=C2=A0void<br>
=C2=A0overlapped_io_init(struct overlapped_io *o,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const=
 struct frame *frame,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BOOL =
event_state,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
tuntap_buffer)=C2=A0 /* if true: tuntap buffer, if false: socket buffer */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
reads, /* if true: reads buffer, if false: writes buffer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
tuntap_buffer,=C2=A0 /* if true: tuntap buffer, if false: socket buffer */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
wintun)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CLEAR(*o);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* manual reset event, initially set according to event=
_state */<br>
-=C2=A0 =C2=A0 o-&gt;overlapped.hEvent =3D CreateEvent(NULL, TRUE, event_st=
ate, NULL);<br>
+=C2=A0 =C2=A0 o-&gt;overlapped.hEvent =3D CreateEvent(NULL, TRUE, reads ? =
FALSE : TRUE, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (o-&gt;overlapped.hEvent =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_ERR, &quot;Error: overlapped_io_ini=
t: CreateEvent failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* allocate buffer for overlapped I/O */<br>
-=C2=A0 =C2=A0 alloc_buf_sock_tun(&amp;o-&gt;buf_init, frame, tuntap_buffer=
, 0);<br>
+=C2=A0 =C2=A0 if (wintun &amp;&amp; tuntap_buffer &amp;&amp; reads)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* wintun could return up to 256 packets,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* each packet is accompanied with size, =
start and end padding<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int buf_size =3D (MAX_RW_SIZE_TUN(frame) + 4 +=
 12 + 15) * 256;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;buf_init =3D alloc_buf(buf_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;buf_init.len =3D buf_size;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* allocate buffer for overlapped I/O */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 alloc_buf_sock_tun(&amp;o-&gt;buf_init, frame,=
 tuntap_buffer, 0);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void<br>
@@ -1493,4 +1507,99 @@ send_msg_iservice(HANDLE pipe, const void *data, siz=
e_t size,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+bool<br>
+impersonate_as_system()<br>
+{<br>
+=C2=A0 =C2=A0 HANDLE thread_token, process_snapshot, winlogon_process, win=
logon_token, duplicated_token, file_handle;<br>
+=C2=A0 =C2=A0 PROCESSENTRY32 entry;<br>
+=C2=A0 =C2=A0 BOOL ret;<br>
+=C2=A0 =C2=A0 DWORD pid =3D 0;<br>
+=C2=A0 =C2=A0 TOKEN_PRIVILEGES privileges;<br>
+<br>
+=C2=A0 =C2=A0 CLEAR(entry);<br>
+=C2=A0 =C2=A0 CLEAR(privileges);<br>
+<br>
+=C2=A0 =C2=A0 entry.dwSize =3D sizeof(PROCESSENTRY32);<br>
+<br>
+=C2=A0 =C2=A0 privileges.PrivilegeCount =3D 1;<br>
+=C2=A0 =C2=A0 privileges.Privileges-&gt;Attributes =3D SE_PRIVILEGE_ENABLE=
D;<br>
+<br>
+=C2=A0 =C2=A0 if (!LookupPrivilegeValue(NULL, SE_DEBUG_NAME, &amp;privileg=
es.Privileges[0].Luid))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!ImpersonateSelf(SecurityImpersonation))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!OpenThreadToken(GetCurrentThread(), TOKEN_ADJUST_PRIVIL=
EGES, FALSE, &amp;thread_token))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!AdjustTokenPrivileges(thread_token, FALSE, &amp;privile=
ges, sizeof(privileges), NULL, NULL))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(thread_token);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 CloseHandle(thread_token);<br>
+<br>
+=C2=A0 =C2=A0 process_snapshot =3D CreateToolhelp32Snapshot(TH32CS_SNAPPRO=
CESS, 0);<br>
+=C2=A0 =C2=A0 if (process_snapshot =3D=3D INVALID_HANDLE_VALUE)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (ret =3D Process32First(process_snapshot, &amp;entry); r=
et; ret =3D Process32Next(process_snapshot, &amp;entry))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!_stricmp(entry.szExeFile, &quot;winlogon.=
exe&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D entry.th32ProcessID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 CloseHandle(process_snapshot);<br>
+=C2=A0 =C2=A0 if (!pid)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 winlogon_process =3D OpenProcess(PROCESS_QUERY_INFORMATION, =
FALSE, pid);<br>
+=C2=A0 =C2=A0 if (!winlogon_process)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!OpenProcessToken(winlogon_process, TOKEN_IMPERSONATE | =
TOKEN_DUPLICATE, &amp;winlogon_token))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(winlogon_process);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 CloseHandle(winlogon_process);<br>
+<br>
+=C2=A0 =C2=A0 if (!DuplicateToken(winlogon_token, SecurityImpersonation, &=
amp;duplicated_token))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(winlogon_token);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 CloseHandle(winlogon_token);<br>
+<br>
+=C2=A0 =C2=A0 if (!SetThreadToken(NULL, duplicated_token))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(duplicated_token);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RevertToSelf();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 CloseHandle(duplicated_token);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h<br>
index 4814bbc..e511b56 100644<br>
--- a/src/openvpn/win32.h<br>
+++ b/src/openvpn/win32.h<br>
@@ -212,10 +212,12 @@ struct overlapped_io {<br>
=C2=A0 =C2=A0 =C2=A0struct buffer buf;<br>
=C2=A0};<br>
<br>
-void overlapped_io_init(struct overlapped_io *o,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const struct frame *frame,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BOOL event_state,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool tuntap_buffer);<br>
+void<br>
+overlapped_io_init(struct overlapped_io *o,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 struct frame *frame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
reads, /* if true: reads buffer, if false: writes buffer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
tuntap_buffer,=C2=A0 /* if true: tuntap buffer, if false: socket buffer */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
wintun);<br>
<br>
=C2=A0void overlapped_io_close(struct overlapped_io *o);<br>
<br>
@@ -323,5 +325,14 @@ bool send_msg_iservice(HANDLE pipe, const void *data, =
size_t size,<br>
=C2=A0int<br>
=C2=A0openvpn_execve(const struct argv *a, const struct env_set *es, const =
unsigned int flags);<br>
<br>
+/**<br>
+ * Impersonates current thread as SYSTEM, required<br>
+ * to open Wintun device.<br>
+ *<br>
+ * @returns=C2=A0 =C2=A0 =C2=A0True if it succeeds, false if it fails.<br>
+ */<br>
+bool<br>
+impersonate_as_system();<br>
+<br>
=C2=A0#endif /* ifndef OPENVPN_WIN32_H */<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000982229058abca93b--

