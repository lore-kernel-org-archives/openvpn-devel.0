From: Simon Rozman <simon@...2293...>
Date: Mon, 8 Oct 2018 12:20:27 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE1099217875@...2294...>
References: <1538995612-17450-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1538995612-17450-1-git-send-email-lstipakov@...277...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_002B_01D45F12.0EEC1530"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix various compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_002B_01D45F12.0EEC1530
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Congratulations! 518 left to go. =F0=9F=98=9D

Acked-by: Simon Rozman <simon@...2293...>

I believe MSVC warning level 3 is a bit too high for a code that was not de=
veloped in MSVC or even with MSVC in mind. I lowered it to level 1, and abo=
ut 8 of interesting warnings remained out of all the warning noise. Maybe w=
e should address those too, then raise to warning level 2 etc.

Regards,
Simon

> -----Original Message-----
> From: Lev Stipakov <lstipakov@...277...>
> Sent: Monday, October 8, 2018 12:47 PM
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] [PATCH] Fix various compiler warnings
>=20
> From: Lev Stipakov <lev@...515...>
>=20
> This patch fixes "unused variable/unreferenced format parameter"
> warnings in different places, kudos to Visual Studio compiler
> for discoveing some of those.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/forward.c |  2 +-
>  src/openvpn/init.c    |  2 +-
>  src/openvpn/init.h    |  2 +-
>  src/openvpn/mtcp.c    |  2 +-
>  src/openvpn/mudp.c    |  2 +-
>  src/openvpn/multi.c   | 28 +++++++++++++---------------
>  src/openvpn/multi.h   |  8 ++++----
>  src/openvpn/openvpn.c |  2 +-
>  src/openvpn/tun.c     | 11 ++++-------
>  src/openvpn/tun.h     |  2 +-
>  src/openvpn/win32.c   |  3 +--
>  11 files changed, 29 insertions(+), 35 deletions(-)
>=20
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index f8faa81..35de490 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1251,7 +1251,7 @@ read_incoming_tun(struct context *c)
>=20
>      c->c2.buf =3D c->c2.buffers->read_tun_buf;
>  #ifdef TUN_PASS_BUFFER
> -    read_tun_buffered(c->c1.tuntap, &c->c2.buf, MAX_RW_SIZE_TUN(&c-
> >c2.frame));
> +    read_tun_buffered(c->c1.tuntap, &c->c2.buf);
>  #else
>      ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
>      ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 52c64da..3dfa632 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -3858,7 +3858,7 @@ init_management_callback_p2p(struct context *c)
>  #ifdef ENABLE_MANAGEMENT
>=20
>  void
> -init_management(struct context *c)
> +init_management(void)
>  {
>      if (!management)
>      {
> diff --git a/src/openvpn/init.h b/src/openvpn/init.h
> index 085ac53..d4bacf4 100644
> --- a/src/openvpn/init.h
> +++ b/src/openvpn/init.h
> @@ -119,7 +119,7 @@ void initialization_sequence_completed(struct
> context *c, const unsigned int fla
>=20
>  #ifdef ENABLE_MANAGEMENT
>=20
> -void init_management(struct context *c);
> +void init_management(void);
>=20
>  bool open_management(struct context *c);
>=20
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
> index a53efad..31c92a2 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -834,7 +834,7 @@ tunnel_server_tcp(struct context *top)
>  #endif
>=20
>      /* shut down management interface */
> -    uninit_management_callback_multi(&multi);
> +    uninit_management_callback_multi();
>=20
>      /* save ifconfig-pool */
>      multi_ifconfig_pool_persist(&multi, true);
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index a604d21..7fdd776 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -362,7 +362,7 @@ tunnel_server_udp_single_threaded(struct context
> *top)
>  #endif
>=20
>      /* shut down management interface */
> -    uninit_management_callback_multi(&multi);
> +    uninit_management_callback_multi();
>=20
>      /* save ifconfig-pool */
>      multi_ifconfig_pool_persist(&multi, true);
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 8440f31..ae4d1d2 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -557,8 +557,7 @@ setenv_stats(struct context *c)
>  }
>=20
>  static void
> -multi_client_disconnect_setenv(struct multi_context *m,
> -                               struct multi_instance *mi)
> +multi_client_disconnect_setenv(struct multi_instance *mi)
>  {
>      /* setenv client real IP address */
>      setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi-
> >context));
> @@ -571,13 +570,12 @@ multi_client_disconnect_setenv(struct
> multi_context *m,
>  }
>=20
>  static void
> -multi_client_disconnect_script(struct multi_context *m,
> -                               struct multi_instance *mi)
> +multi_client_disconnect_script(struct multi_instance *mi)
>  {
>      if ((mi->context.c2.context_auth =3D=3D CAS_SUCCEEDED && mi-
> >connection_established_flag)
>          || mi->context.c2.context_auth =3D=3D CAS_PARTIAL)
>      {
> -        multi_client_disconnect_setenv(m, mi);
> +        multi_client_disconnect_setenv(mi);
>=20
>          if (plugin_defined(mi->context.plugins,
> OPENVPN_PLUGIN_CLIENT_DISCONNECT))
>          {
> @@ -684,7 +682,7 @@ multi_close_instance(struct multi_context *m,
>      set_cc_config(mi, NULL);
>  #endif
>=20
> -    multi_client_disconnect_script(m, mi);
> +    multi_client_disconnect_script(mi);
>=20
>      if (mi->did_open_context)
>      {
> @@ -1112,7 +1110,7 @@ multi_learn_addr(struct multi_context *m,
>=20
>          if (oldroute) /* route already exists? */
>          {
> -            if (route_quota_test(m, mi) && learn_address_script(m, mi,
> "update", &newroute->addr))
> +            if (route_quota_test(mi) && learn_address_script(m, mi,
> "update", &newroute->addr))
>              {
>                  learn_succeeded =3D true;
>                  owner =3D mi;
> @@ -1129,7 +1127,7 @@ multi_learn_addr(struct multi_context *m,
>          }
>          else
>          {
> -            if (route_quota_test(m, mi) && learn_address_script(m, mi,
> "add", &newroute->addr))
> +            if (route_quota_test(mi) && learn_address_script(m, mi,
> "add", &newroute->addr))
>              {
>                  learn_succeeded =3D true;
>                  owner =3D mi;
> @@ -1579,7 +1577,7 @@ multi_select_virtual_addr(struct multi_context *m,
> struct multi_instance *mi)
>   * Set virtual address environmental variables.
>   */
>  static void
> -multi_set_virtual_addr_env(struct multi_context *m, struct
> multi_instance *mi)
> +multi_set_virtual_addr_env(struct multi_instance *mi)
>  {
>      setenv_del(mi->context.c2.es, "ifconfig_pool_local_ip");
>      setenv_del(mi->context.c2.es, "ifconfig_pool_remote_ip");
> @@ -1658,7 +1656,7 @@ multi_client_connect_post(struct multi_context *m,
>           * directory or any --ifconfig-pool dynamic address.
>           */
>          multi_select_virtual_addr(m, mi);
> -        multi_set_virtual_addr_env(m, mi);
> +        multi_set_virtual_addr_env(mi);
>      }
>  }
>=20
> @@ -1702,7 +1700,7 @@ multi_client_connect_post_plugin(struct
> multi_context *m,
>           * directory or any --ifconfig-pool dynamic address.
>           */
>          multi_select_virtual_addr(m, mi);
> -        multi_set_virtual_addr_env(m, mi);
> +        multi_set_virtual_addr_env(mi);
>      }
>  }
>=20
> @@ -1742,7 +1740,7 @@ multi_client_connect_mda(struct multi_context *m,
>           * directory or any --ifconfig-pool dynamic address.
>           */
>          multi_select_virtual_addr(m, mi);
> -        multi_set_virtual_addr_env(m, mi);
> +        multi_set_virtual_addr_env(mi);
>      }
>  }
>=20
> @@ -1761,7 +1759,7 @@ multi_client_connect_setenv(struct multi_context
> *m,
>      setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi-
> >context));
>=20
>      /* setenv client virtual IP address */
> -    multi_set_virtual_addr_env(m, mi);
> +    multi_set_virtual_addr_env(mi);
>=20
>      /* setenv connection time */
>      {
> @@ -2936,7 +2934,7 @@ multi_process_drop_outgoing_tun(struct
> multi_context *m, const unsigned int mpp_
>   */
>=20
>  void
> -route_quota_exceeded(const struct multi_context *m, const struct
> multi_instance *mi)
> +route_quota_exceeded(const struct multi_instance *mi)
>  {
>      struct gc_arena gc =3D gc_new();
>      msg(D_ROUTE_QUOTA, "MULTI ROUTE: route quota (%d) exceeded for %s
> (see --max-routes-per-client option)",
> @@ -3373,7 +3371,7 @@ init_management_callback_multi(struct
> multi_context *m)
>  }
>=20
>  void
> -uninit_management_callback_multi(struct multi_context *m)
> +uninit_management_callback_multi(void)
>  {
>      uninit_management_callback();
>  }
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 3d3d687..f0dca9d 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -346,7 +346,7 @@ void multi_close_instance_on_signal(struct
> multi_context *m, struct multi_instan
>=20
>  void init_management_callback_multi(struct multi_context *m);
>=20
> -void uninit_management_callback_multi(struct multi_context *m);
> +void uninit_management_callback_multi(void);
>=20
>=20
>  #ifdef ENABLE_ASYNC_PUSH
> @@ -403,7 +403,7 @@ multi_process_outgoing_link_pre(struct multi_context
> *m)
>   * Per-client route quota management
>   */
>=20
> -void route_quota_exceeded(const struct multi_context *m, const struct
> multi_instance *mi);
> +void route_quota_exceeded(const struct multi_instance *mi);
>=20
>  static inline void
>  route_quota_inc(struct multi_instance *mi)
> @@ -419,11 +419,11 @@ route_quota_dec(struct multi_instance *mi)
>=20
>  /* can we add a new route? */
>  static inline bool
> -route_quota_test(const struct multi_context *m, const struct
> multi_instance *mi)
> +route_quota_test(const struct multi_instance *mi)
>  {
>      if (mi->route_count >=3D mi->context.options.max_routes_per_client)
>      {
> -        route_quota_exceeded(m, mi);
> +        route_quota_exceeded(mi);
>          return false;
>      }
>      else
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index 5d6a41c..ad73af5 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -199,7 +199,7 @@ openvpn_main(int argc, char *argv[])
>=20
>  #ifdef ENABLE_MANAGEMENT
>              /* initialize management subsystem */
> -            init_management(&c);
> +            init_management();
>  #endif
>=20
>              /* initialize options to default state */
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 948fd17..8ca8dd4 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4867,7 +4867,6 @@ void
>  ipconfig_register_dns(const struct env_set *es)
>  {
>      struct argv argv =3D argv_new();
> -    bool status;
>      const char err[] =3D "ERROR: Windows ipconfig command failed";
>=20
>      msg(D_TUNTAP_INFO, "Start ipconfig commands for register-dns...");
> @@ -4877,14 +4876,14 @@ ipconfig_register_dns(const struct env_set *es)
>                  get_win_sys_path(),
>                  WIN_IPCONFIG_PATH_SUFFIX);
>      argv_msg(D_TUNTAP_INFO, &argv);
> -    status =3D openvpn_execve_check(&argv, es, 0, err);
> +    openvpn_execve_check(&argv, es, 0, err);
>      argv_reset(&argv);
>=20
>      argv_printf(&argv, "%s%sc /registerdns",
>                  get_win_sys_path(),
>                  WIN_IPCONFIG_PATH_SUFFIX);
>      argv_msg(D_TUNTAP_INFO, &argv);
> -    status =3D openvpn_execve_check(&argv, es, 0, err);
> +    openvpn_execve_check(&argv, es, 0, err);
>      argv_reset(&argv);
>=20
>      netcmd_semaphore_release();
> @@ -5178,8 +5177,7 @@ netsh_ifconfig(const struct tuntap_options *to,
>  }
>=20
>  static void
> -netsh_enable_dhcp(const struct tuntap_options *to,
> -                  const char *actual_name)
> +netsh_enable_dhcp(const char *actual_name)
>  {
>      struct argv argv =3D argv_new();
>=20
> @@ -5199,7 +5197,6 @@ netsh_enable_dhcp(const struct tuntap_options *to,
>  static bool
>  service_enable_dhcp(const struct tuntap *tt)
>  {
> -    DWORD len;
>      bool ret =3D false;
>      ack_message_t ack;
>      struct gc_arena gc =3D gc_new();
> @@ -5720,7 +5717,7 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>                  }
>                  else
>                  {
> -                    netsh_enable_dhcp(&tt->options, tt->actual_name);
> +                    netsh_enable_dhcp(tt->actual_name);
>                  }
>              }
>              dhcp_masq =3D true;
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index cb1ab1c..9ed8ef0 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -457,7 +457,7 @@ tun_write_win32(struct tuntap *tt, struct buffer
> *buf)
>  }
>=20
>  static inline int
> -read_tun_buffered(struct tuntap *tt, struct buffer *buf, int maxsize)
> +read_tun_buffered(struct tuntap *tt, struct buffer *buf)
>  {
>      return tun_finalize(tt->hand, &tt->reads, buf);
>  }
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index e43296e..2e8a4b0 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -685,11 +685,10 @@ win32_pause(struct win32_signal *ws)
>  {
>      if (ws->mode =3D=3D WSO_MODE_CONSOLE && HANDLE_DEFINED(ws->in.read))
>      {
> -        int status;
>          msg(M_INFO|M_NOPREFIX, "Press any key to continue...");
>          do
>          {
> -            status =3D WaitForSingleObject(ws->in.read, INFINITE);
> +            WaitForSingleObject(ws->in.read, INFINITE);
>          } while (!win32_keyboard_get(ws));
>      }
>  }
> --
> 2.7.4
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

------=_NextPart_000_002B_01D45F12.0EEC1530
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MTAwODEyMjAyNlowLwYJKoZIhvcN
AQkEMSIEIHtvlbEKqqmwn/4B7STvLBbzZHZFs3rsOcwyauISeZ/EMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBABTOsNDxQCCM/+ZLkLwvSTIP
OnkKkhWdSVHQJku6WGdCVI+vGnTDUAsZIo08MV/KYUbMYwRoVJTzsVBV0k4wtVXY642V61IO42Fb
KxA1YpIqbx9J4MF4nPcJSwbmXaft96dqKg4mhunNLZgAjt362N0SMIcN3xjzCOQ8Ov0KTln1Po5L
d8Fem/5uyyYMCR4vtjxjFs7w1WSMeB9lP6K7DgGzTgoU2NYFU57ID1uYBn+DJZsoQqHjCykMIJfC
EkfR7fQK25VtI5Cz9VBt/H1WG02vnu/u/BfolH5q6tfDOQJmLVRlB7yrTIEi1whGwjorxzKJJtBo
csW0kDCoaAe357oAAAAAAAA=

------=_NextPart_000_002B_01D45F12.0EEC1530--

