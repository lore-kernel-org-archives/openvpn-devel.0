From: Denis Vlasenko <vda@...216...>
MIME-Version: 1.0
Message-Id: <200405282327.43269.vda@...216...>
Subject: [Openvpn-devel] [BUG] sometimes --ping 30 stops: select() timeout=31536000 seconds (exactly one year)!
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri May 28 13:36:08 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

I was puzzled why sometimes openvpn ceases to generate
'--ping 30' packets. I instrumented it a bit,
here is a pseudo-patch:

errlevel.h:
+#define D_PING               LOGLEV(4, 0, 0)         /* show --ping packets */
....
-#define D_INTERVAL           LOGLEV(8, 70, M_DEBUG)  /* show interval.h debugging info */
+#define D_INTERVAL           LOGLEV(4, 70, M_DEBUG)  /* show interval.h debugging info */

ping-inline.h: (check_ping_send now will explain why it do not send pings)
static inline void
check_ping_send (struct context *c)
{
  void check_ping_send_dowork (struct context *c);
  if (!c->options.ping_send_timeout) { msg (D_PING, "PING: !c->options.ping_send_timeout"); return; }
  if (c->c2.to_link.len) { msg (D_PING, "PING: c->c2.to_link.len <> 0"); return; }
  if (!event_timeout_trigger (&c->c2.ping_send_interval, &c->c2.timeval))
    { msg (D_PING, "PING: !event_timeout_trigger(%ld,%ld)",(long)(c->c2.ping_send_interval.last), (long)c->c2.timeval.tv_sec); return; }
    check_ping_send_dowork (c);
}

ping.c:check_ping_send_dowork (struct context *c): (log pings)
...
   encrypt_sign (c, true);
+  msg (D_PING, "PING: SENT");
}

forward.c:void single_select (struct context *c): (log large select timeouts)
...
  /*
   * Wait for something to happen.
   */
  c->c2.select_status = 1;      /* this will be our return "status" if select doesn't get called */
  if (!c->sig->signal_received && !SOCKET_READ_RESIDUAL (c->c2.link_socket))
    {
      if (check_debug_level (D_SELECT))
        show_select_status (c);

+     if(((unsigned long)c->c2.timeval.tv_sec) >= 28) { //vda
+       msg(D_PING, "PING: select timeout=%ld", (long)c->c2.timeval.tv_sec);
+     }
      c->c2.select_status = SELECT (&c->c2.event_wait, &c->c2.timeval);
      check_status (c->c2.select_status, "select", NULL, NULL);
    }


With --ping 30, select shall _never_ have timeout>30 secs, right?

I was lucky. Bug struck me soon after I restarted openvpn.
Here is the full log:

Fri May 28 22:59:11 2004 Current Parameter Settings:
Fri May 28 22:59:11 2004   config = '[UNDEF]'
Fri May 28 22:59:11 2004   mode = 0
Fri May 28 22:59:11 2004   persist_config = DISABLED
Fri May 28 22:59:11 2004   persist_mode = 1
Fri May 28 22:59:11 2004   show_ciphers = DISABLED
Fri May 28 22:59:11 2004   show_digests = DISABLED
Fri May 28 22:59:11 2004   genkey = DISABLED
Fri May 28 22:59:11 2004   askpass = DISABLED
Fri May 28 22:59:11 2004   show_tls_ciphers = DISABLED
Fri May 28 22:59:11 2004   proto = 0
Fri May 28 22:59:11 2004   local = '1.1.4.1'
Fri May 28 22:59:11 2004   remote_list[0] = {'1.1.4.2', 8002}
Fri May 28 22:59:11 2004   remote_random = DISABLED
Fri May 28 22:59:11 2004   local_port = 8002
Fri May 28 22:59:11 2004   remote_port = 8002
Fri May 28 22:59:11 2004   remote_float = DISABLED
Fri May 28 22:59:11 2004   ipchange = '[UNDEF]'
Fri May 28 22:59:11 2004   bind_local = ENABLED
Fri May 28 22:59:11 2004   dev = 'tun'
Fri May 28 22:59:11 2004   dev_type = '[UNDEF]'
Fri May 28 22:59:11 2004   dev_node = '[UNDEF]'
Fri May 28 22:59:11 2004   tun_ipv6 = DISABLED
Fri May 28 22:59:11 2004   ifconfig_local = '1.1.5.1'
Fri May 28 22:59:11 2004   ifconfig_remote_netmask = '1.1.5.2'
Fri May 28 22:59:11 2004   ifconfig_noexec = DISABLED
Fri May 28 22:59:11 2004   ifconfig_nowarn = DISABLED
Fri May 28 22:59:11 2004   shaper = 0
Fri May 28 22:59:11 2004   tun_mtu = 1434
Fri May 28 22:59:11 2004   tun_mtu_defined = ENABLED
Fri May 28 22:59:11 2004   link_mtu = 1500
Fri May 28 22:59:11 2004   link_mtu_defined = DISABLED
Fri May 28 22:59:11 2004   tun_mtu_extra = 0
Fri May 28 22:59:11 2004   tun_mtu_extra_defined = DISABLED
Fri May 28 22:59:11 2004   fragment = 0
Fri May 28 22:59:11 2004   mtu_discover_type = -1
Fri May 28 22:59:11 2004   mtu_test = 0
Fri May 28 22:59:11 2004   mlock = DISABLED
Fri May 28 22:59:11 2004   inactivity_timeout = 0
Fri May 28 22:59:11 2004   ping_send_timeout = 30
Fri May 28 22:59:11 2004   ping_rec_timeout = 0
Fri May 28 22:59:11 2004   ping_rec_timeout_action = 0
Fri May 28 22:59:11 2004   ping_timer_remote = DISABLED
Fri May 28 22:59:11 2004   persist_tun = DISABLED
Fri May 28 22:59:11 2004   persist_local_ip = DISABLED
Fri May 28 22:59:11 2004   persist_remote_ip = DISABLED
Fri May 28 22:59:11 2004   persist_key = DISABLED
Fri May 28 22:59:11 2004   mssfix = 1450
Fri May 28 22:59:11 2004   passtos = DISABLED
Fri May 28 22:59:11 2004   resolve_retry_seconds = 0
Fri May 28 22:59:11 2004   connect_retry_seconds = 5
Fri May 28 22:59:11 2004   username = '[UNDEF]'
Fri May 28 22:59:11 2004   groupname = '[UNDEF]'
Fri May 28 22:59:11 2004   chroot_dir = '[UNDEF]'
Fri May 28 22:59:11 2004   cd_dir = '[UNDEF]'
Fri May 28 22:59:11 2004   writepid = '[UNDEF]'
Fri May 28 22:59:11 2004   up_script = '[UNDEF]'
Fri May 28 22:59:11 2004   down_script = '[UNDEF]'
Fri May 28 22:59:11 2004   up_restart = DISABLED
Fri May 28 22:59:11 2004   daemon = DISABLED
Fri May 28 22:59:11 2004   inetd = 0
Fri May 28 22:59:11 2004   log = DISABLED
Fri May 28 22:59:11 2004   nice = 0
Fri May 28 22:59:11 2004   verbosity = 4
Fri May 28 22:59:11 2004   mute = 0
Fri May 28 22:59:11 2004   gremlin = DISABLED
Fri May 28 22:59:11 2004   occ = ENABLED
Fri May 28 22:59:11 2004   rcvbuf = 65536
Fri May 28 22:59:11 2004   sndbuf = 65536
Fri May 28 22:59:11 2004   http_proxy_server = '[UNDEF]'
Fri May 28 22:59:11 2004   http_proxy_port = 0
Fri May 28 22:59:11 2004   http_proxy_auth_method = '[UNDEF]'
Fri May 28 22:59:11 2004   http_proxy_auth_file = '[UNDEF]'
Fri May 28 22:59:11 2004   http_proxy_retry = DISABLED
Fri May 28 22:59:11 2004   socks_proxy_server = '[UNDEF]'
Fri May 28 22:59:11 2004   socks_proxy_port = 0
Fri May 28 22:59:11 2004   socks_proxy_retry = DISABLED
Fri May 28 22:59:11 2004   comp_lzo = DISABLED
Fri May 28 22:59:11 2004   comp_lzo_adaptive = ENABLED
Fri May 28 22:59:11 2004   route_script = '[UNDEF]'
Fri May 28 22:59:11 2004   route_default_gateway = '[UNDEF]'
Fri May 28 22:59:11 2004   route_noexec = DISABLED
Fri May 28 22:59:11 2004   route_delay = 0
Fri May 28 22:59:11 2004   route_delay_defined = DISABLED
Fri May 28 22:59:11 2004   shared_secret_file = '/.local/var/service/ovpn-1/key'
Fri May 28 22:59:11 2004   key_direction = 0
Fri May 28 22:59:11 2004   ciphername_defined = ENABLED
Fri May 28 22:59:11 2004   ciphername = 'BF-CBC'
Fri May 28 22:59:11 2004   authname_defined = ENABLED
Fri May 28 22:59:11 2004   authname = 'SHA1'
Fri May 28 22:59:11 2004   keysize = 0
Fri May 28 22:59:11 2004   replay = ENABLED
Fri May 28 22:59:11 2004   replay_window = 64
Fri May 28 22:59:11 2004   replay_time = 15
Fri May 28 22:59:11 2004   packet_id_file = '[UNDEF]'
Fri May 28 22:59:11 2004   use_iv = ENABLED
Fri May 28 22:59:11 2004   test_crypto = DISABLED
Fri May 28 22:59:11 2004   tls_server = DISABLED
Fri May 28 22:59:11 2004   tls_client = DISABLED
Fri May 28 22:59:11 2004   key_method = 2
Fri May 28 22:59:11 2004   ca_file = '[UNDEF]'
Fri May 28 22:59:11 2004   dh_file = '[UNDEF]'
Fri May 28 22:59:11 2004   cert_file = '[UNDEF]'
Fri May 28 22:59:11 2004   priv_key_file = '[UNDEF]'
Fri May 28 22:59:11 2004   cipher_list = '[UNDEF]'
Fri May 28 22:59:11 2004   tls_verify = '[UNDEF]'
Fri May 28 22:59:11 2004   tls_remote = '[UNDEF]'
Fri May 28 22:59:11 2004   crl_file = '[UNDEF]'
Fri May 28 22:59:11 2004   tls_timeout = 2
Fri May 28 22:59:11 2004   renegotiate_bytes = 0
Fri May 28 22:59:11 2004   renegotiate_packets = 0
Fri May 28 22:59:11 2004   renegotiate_seconds = 3600
Fri May 28 22:59:11 2004   handshake_window = 60
Fri May 28 22:59:11 2004   transition_window = 3600
Fri May 28 22:59:11 2004   single_session = DISABLED
Fri May 28 22:59:11 2004   tls_auth_file = '[UNDEF]'
Fri May 28 22:59:11 2004   pull = DISABLED
Fri May 28 22:59:11 2004   ifconfig_pool_defined = DISABLED
Fri May 28 22:59:11 2004   ifconfig_pool_start = 0.0.0.0
Fri May 28 22:59:11 2004   ifconfig_pool_end = 0.0.0.0
Fri May 28 22:59:11 2004   n_bcast_buf = 256
Fri May 28 22:59:11 2004   real_hash_size = 256
Fri May 28 22:59:11 2004   virtual_hash_size = 256
Fri May 28 22:59:11 2004   client_connect_script = '[UNDEF]'
Fri May 28 22:59:11 2004   client_disconnect_script = '[UNDEF]'
Fri May 28 22:59:11 2004   client_config_dir = '[UNDEF]'
Fri May 28 22:59:11 2004   tmp_dir = '[UNDEF]'
Fri May 28 22:59:11 2004   push_ifconfig_defined = DISABLED
Fri May 28 22:59:11 2004   push_ifconfig_local = 0.0.0.0
Fri May 28 22:59:11 2004   push_ifconfig_remote_netmask = 0.0.0.0
Fri May 28 22:59:11 2004   enable_c2c = DISABLED
Fri May 28 22:59:11 2004   cf_max = 0
Fri May 28 22:59:11 2004   cf_per = 0
Fri May 28 22:59:11 2004 OpenVPN 2.0_beta1 i386-pc-linux-gnu [SSL] [LZO] built on May 28 2004
Fri May 28 22:59:11 2004 Static Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Fri May 28 22:59:11 2004 Static Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Fri May 28 22:59:11 2004 Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Fri May 28 22:59:11 2004 Static Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Fri May 28 22:59:11 2004 WARNING: normally if you use --mssfix and/or --fragment, you should also set --tun-mtu 1500 (currently it is 1434)
Fri May 28 22:59:11 2004 TUN/TAP device tun0 opened
Fri May 28 22:59:11 2004 TUN/TAP TX queue length set to 100
Fri May 28 22:59:11 2004 /bin/ifconfig tun0 1.1.5.1 pointopoint 1.1.5.2 mtu 1434
Fri May 28 22:59:11 2004 Data Channel MTU parms [ L:1478 D:1450 EF:44 EB:0 ET:0 EL:0 ]
Fri May 28 22:59:11 2004 Local Options String: 'V3,dev-type tun,link-mtu 1478,tun-mtu 1434,proto UDPv4,ifconfig 1.1.5.2 1.1.5.1,cipher BF-CBC,
Fri May 28 22:59:11 2004 Expected Remote Options String: 'V3,dev-type tun,link-mtu 1478,tun-mtu 1434,proto UDPv4,ifconfig 1.1.5.1 1.1.5.2,ciph
Fri May 28 22:59:11 2004 Local Options hash (VER=V3): '5194cd41'
Fri May 28 22:59:11 2004 Expected Remote Options hash (VER=V3): 'e341fa03'
Fri May 28 22:59:11 2004 Socket Buffers: R=[110592->131072] S=[110592->131072]
Fri May 28 22:59:11 2004 UDPv4 link local (bound): 1.1.4.1:8002
Fri May 28 22:59:11 2004 UDPv4 link remote: 1.1.4.2:8002
Fri May 28 22:59:11 2004 EVENT event_timeout_wakeup (2/2)
Fri May 28 22:59:11 2004 EVENT event_timeout_trigger (30)
Fri May 28 22:59:11 2004 PING: SENT
Fri May 28 22:59:11 2004 TIMER: coarse timer wakeup 2 seconds
Fri May 28 22:59:11 2004 RANDOM USEC=670225
Fri May 28 22:59:11 2004 write UDPv4 []: Network is unreachable (code=101)
Fri May 28 22:59:12 2004 write UDPv4 []: Network is unreachable (code=101)
Fri May 28 22:59:12 2004 write UDPv4 []: Network is unreachable (code=101)
Fri May 28 22:59:12 2004 write UDPv4 []: Network is unreachable (code=101)
Fri May 28 22:59:13 2004 EVENT event_timeout_trigger (2)
Fri May 28 22:59:13 2004 EVENT event_timeout_wakeup (2/2)
Fri May 28 22:59:13 2004 PING: c->c2.to_link.len <> 0
Fri May 28 22:59:13 2004 TIMER: coarse timer wakeup 2 seconds
Fri May 28 22:59:13 2004 write UDPv4 []: Network is unreachable (code=101)
Fri May 28 22:59:15 2004 EVENT event_timeout_trigger (2)
Fri May 28 22:59:15 2004 EVENT event_timeout_wakeup (2/2)
Fri May 28 22:59:15 2004 PING: c->c2.to_link.len <> 0
Fri May 28 22:59:15 2004 TIMER: coarse timer wakeup 2 seconds
Fri May 28 22:59:15 2004 Peer Connection Initiated with 1.1.4.2:8002
Fri May 28 22:59:18 2004 EVENT event_timeout_trigger (2)
Fri May 28 22:59:18 2004 EVENT event_timeout_wakeup (2/2)
Fri May 28 22:59:18 2004 PING: !event_timeout_trigger(1085774355,2)
Fri May 28 22:59:18 2004 TIMER: coarse timer wakeup 2 seconds
Fri May 28 22:59:21 2004 EVENT event_timeout_trigger (10)
Fri May 28 22:59:21 2004 EVENT event_timeout_wakeup (10/10)
Fri May 28 22:59:21 2004 PING: !event_timeout_trigger(1085774355,10)
Fri May 28 22:59:21 2004 TIMER: coarse timer wakeup 10 seconds
Fri May 28 22:59:21 2004 RANDOM USEC=682209
Fri May 28 22:59:32 2004 EVENT event_timeout_wakeup (27/30)
Fri May 28 22:59:32 2004 PING: !event_timeout_trigger(1085774369,27)
Fri May 28 22:59:32 2004 TIMER: coarse timer wakeup 27 seconds
Fri May 28 22:59:32 2004 RANDOM USEC=168112
Fri May 28 22:59:43 2004 RANDOM USEC=310535
Fri May 28 22:59:53 2004 RANDOM USEC=567338
Fri May 28 22:59:59 2004 PING: c->c2.to_link.len <> 0
Fri May 28 22:59:59 2004 TIMER: coarse timer wakeup 31536000 seconds
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 22:59:59 2004 PING: select timeout=31536000
Fri May 28 23:00:04 2004 RANDOM USEC=262969
Fri May 28 23:00:04 2004 PING: select timeout=31535995
Fri May 28 23:00:04 2004 PING: select timeout=31535995
Fri May 28 23:00:04 2004 PING: select timeout=31535995
Fri May 28 23:00:04 2004 PING: select timeout=31535995
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:10 2004 PING: select timeout=31535989
Fri May 28 23:00:14 2004 RANDOM USEC=111391
Fri May 28 23:00:14 2004 PING: select timeout=31535985
Fri May 28 23:00:14 2004 PING: select timeout=31535985
Fri May 28 23:00:14 2004 PING: select timeout=31535985
Fri May 28 23:00:14 2004 PING: select timeout=31535985

and so on. openvpn will abstain from sending pings now
for eaxctly 365 days (I think :). Further log contains
records of two kinds only:

Fri May 28 23:24:36 2004 RANDOM USEC=565465 (random)
	and
Fri May 28 23:24:36 2004 PING: select timeout=31534523 (counting down)

Here is how I start openvpn:

openvpn \
    --secret key \
    --dev tun \
    --proto udp \
    --port 8002 \
    --local 1.1.4.1 \
    --remote 1.1.4.2 \
    --ifconfig 1.1.5.1 1.1.5.2 \
    --tun-mtu 1434 \
    --ping 30 \
    --verb 4 \

NB: I run ntp (strata=3) on this box.
--
vda


