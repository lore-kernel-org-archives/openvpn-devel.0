Message-Id: <405994455@...83...>
MIME-Version: 1.0
From: "Ullrich Dittmer" <uni-webmaster@...83...>
Subject: [Openvpn-devel] Problems with openvpn - restarting 10 sec
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
Date: Thu Jun 24 02:05:06 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I would like to use openvpn (1.6) to connect my home pc direkt over the proxy of my internet service provider (isp). 
At the server side I startet openvpn with

openvpn --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --verb 9 --proto tcp-server --lport 8080 --comp-lzo --link-mtu 296

and on the client:

openvpn --remote luckyluke.homelinux.org --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --verb 9 --http-proxy 195.182.114.52 8080 --proto tcp-client --rport 8080 --comp-lzo --link-mtu 296 --redirect-gateway

Now I have the following problem:

Every minute the proxy sends a FIN to server and client and the tun1 interface closes down. After 10 seconds, the task restarted. Here's the log:

Wed Jun 23 22:05:43 2004 us=748499 0: Current Parameter Settings:
Wed Jun 23 22:05:43 2004 us=749073 1:   config = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=749181 2:   persist_config = DISABLED
Wed Jun 23 22:05:43 2004 us=749277 3:   persist_mode = 1
Wed Jun 23 22:05:43 2004 us=749372 4:   show_ciphers = DISABLED
Wed Jun 23 22:05:43 2004 us=749467 5:   show_digests = DISABLED
Wed Jun 23 22:05:43 2004 us=749582 6:   genkey = DISABLED
Wed Jun 23 22:05:43 2004 us=749680 7:   askpass = DISABLED
Wed Jun 23 22:05:43 2004 us=749775 8:   show_tls_ciphers = DISABLED
Wed Jun 23 22:05:43 2004 us=749870 9:   proto = 2
Wed Jun 23 22:05:43 2004 us=749964 10:   local = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=750060 11:   remote = 'luckyluke.homelinux.org'
Wed Jun 23 22:05:43 2004 us=750155 12:   local_port = 5000
Wed Jun 23 22:05:43 2004 us=750250 13:   remote_port = 8080
Wed Jun 23 22:05:43 2004 us=750345 14:   remote_float = DISABLED
Wed Jun 23 22:05:43 2004 us=750439 15:   ipchange = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=750534 16:   bind_local = ENABLED
Wed Jun 23 22:05:43 2004 us=750644 17:   dev = 'tun1'
Wed Jun 23 22:05:43 2004 us=750739 18:   dev_type = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=750833 19:   dev_node = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=750928 20:   tun_ipv6 = DISABLED
Wed Jun 23 22:05:43 2004 us=751023 21:   ifconfig_local = '10.4.0.2'
Wed Jun 23 22:05:43 2004 us=751119 22:   ifconfig_remote_netmask = '10.4.0.1'
Wed Jun 23 22:05:43 2004 us=751215 23:   ifconfig_noexec = DISABLED
Wed Jun 23 22:05:43 2004 us=751309 24:   ifconfig_nowarn = DISABLED
Wed Jun 23 22:05:43 2004 us=751405 25:   shaper = 0
Wed Jun 23 22:05:43 2004 us=751500 26:   tun_mtu = 1300
Wed Jun 23 22:05:43 2004 us=751615 27:   tun_mtu_defined = DISABLED
Wed Jun 23 22:05:43 2004 us=751711 28:   link_mtu = 296
Wed Jun 23 22:05:43 2004 us=751805 29:   link_mtu_defined = ENABLED
Wed Jun 23 22:05:43 2004 us=751900 30:   tun_mtu_extra = 0
Wed Jun 23 22:05:43 2004 us=751994 31:   tun_mtu_extra_defined = DISABLED
Wed Jun 23 22:05:43 2004 us=752103 32:   fragment = 0
Wed Jun 23 22:05:43 2004 us=752201 33:   mtu_discover_type = -1
Wed Jun 23 22:05:43 2004 us=752297 34:   mtu_test = 0
Wed Jun 23 22:05:43 2004 us=752391 35:   mlock = DISABLED
Wed Jun 23 22:05:43 2004 us=752486 36:   inactivity_timeout = 0
Wed Jun 23 22:05:43 2004 us=752751 37:   ping_send_timeout = 0
Wed Jun 23 22:05:43 2004 us=752857 38:   ping_rec_timeout = 0
Wed Jun 23 22:05:43 2004 us=752953 39:   ping_rec_timeout_action = 0
Wed Jun 23 22:05:43 2004 us=753049 40:   ping_timer_remote = DISABLED
Wed Jun 23 22:05:43 2004 us=753144 41:   persist_tun = DISABLED
Wed Jun 23 22:05:43 2004 us=753239 42:   persist_local_ip = DISABLED
Wed Jun 23 22:05:43 2004 us=753334 43:   persist_remote_ip = DISABLED
Wed Jun 23 22:05:43 2004 us=753429 44:   persist_key = DISABLED
Wed Jun 23 22:05:43 2004 us=753524 45:   mssfix_defined = DISABLED
Wed Jun 23 22:05:43 2004 us=753636 46:   mssfix = 0
Wed Jun 23 22:05:43 2004 us=753732 47:   passtos = DISABLED
Wed Jun 23 22:05:43 2004 us=753827 48:   resolve_retry_seconds = 0
Wed Jun 23 22:05:43 2004 us=753923 49:   connect_retry_seconds = 5
Wed Jun 23 22:05:43 2004 us=754018 50:   username = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=754113 51:   groupname = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=754208 52:   chroot_dir = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=754302 53:   cd_dir = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=754397 54:   writepid = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=754491 55:   up_script = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=754620 56:   down_script = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=754774 57:   up_restart = DISABLED
Wed Jun 23 22:05:43 2004 us=754870 58:   daemon = DISABLED
Wed Jun 23 22:05:43 2004 us=754965 59:   inetd = 0
Wed Jun 23 22:05:43 2004 us=755059 60:   log = DISABLED
Wed Jun 23 22:05:43 2004 us=755154 61:   nice = 0
Wed Jun 23 22:05:43 2004 us=755249 62:   verbosity = 9
Wed Jun 23 22:05:43 2004 us=755344 63:   mute = 0
Wed Jun 23 22:05:43 2004 us=755438 64:   gremlin = DISABLED
Wed Jun 23 22:05:43 2004 us=755533 65:   occ = ENABLED
Wed Jun 23 22:05:43 2004 us=755643 66:   http_proxy_server = '195.182.114.52'
Wed Jun 23 22:05:43 2004 us=755789 67:   http_proxy_port = 8080
Wed Jun 23 22:05:43 2004 us=755886 68:   http_proxy_auth_method = 'none'
Wed Jun 23 22:05:43 2004 us=755982 69:   http_proxy_auth_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=756077 70:   http_proxy_retry = DISABLED
Wed Jun 23 22:05:43 2004 us=756173 71:   socks_proxy_server = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=756268 72:   socks_proxy_port = 0
Wed Jun 23 22:05:43 2004 us=756363 73:   socks_proxy_retry = DISABLED
Wed Jun 23 22:05:43 2004 us=756458 74:   comp_lzo = ENABLED
Wed Jun 23 22:05:43 2004 us=756553 75:   comp_lzo_adaptive = ENABLED
Wed Jun 23 22:05:43 2004 us=756880 76:   route_script = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=756979 77:   route_default_gateway = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=757074 78:   route_noexec = DISABLED
Wed Jun 23 22:05:43 2004 us=757169 79:   route_delay = 0
Wed Jun 23 22:05:43 2004 us=757264 80:   route_delay_defined = DISABLED
Wed Jun 23 22:05:43 2004 us=757369 81:   [redirect_default_gateway]
Wed Jun 23 22:05:43 2004 us=757465 82:   shared_secret_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=757589 83:   key_direction = 0
Wed Jun 23 22:05:43 2004 us=757687 84:   ciphername_defined = ENABLED
Wed Jun 23 22:05:43 2004 us=757782 85:   ciphername = 'BF-CBC'
Wed Jun 23 22:05:43 2004 us=757877 86:   authname_defined = ENABLED
Wed Jun 23 22:05:43 2004 us=757972 87:   authname = 'SHA1'
Wed Jun 23 22:05:43 2004 us=758067 88:   keysize = 0
Wed Jun 23 22:05:43 2004 us=758162 89:   replay = ENABLED
Wed Jun 23 22:05:43 2004 us=758257 90:   replay_window = 0
Wed Jun 23 22:05:43 2004 us=758351 91:   replay_time = 0
Wed Jun 23 22:05:43 2004 us=758446 92:   packet_id_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=758541 93:   use_iv = ENABLED
Wed Jun 23 22:05:43 2004 us=758652 94:   test_crypto = DISABLED
Wed Jun 23 22:05:43 2004 us=758747 95:   tls_server = DISABLED
Wed Jun 23 22:05:43 2004 us=758842 96:   tls_client = DISABLED
Wed Jun 23 22:05:43 2004 us=758937 97:   key_method = 1
Wed Jun 23 22:05:43 2004 us=759032 98:   ca_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759126 99:   dh_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759221 100:   cert_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759316 101:   priv_key_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759411 102:   cipher_list = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759506 103:   tls_verify = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759618 104:   tls_remote = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759714 105:   crl_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=759809 106:   tls_timeout = 2
Wed Jun 23 22:05:43 2004 us=759904 107:   renegotiate_bytes = 0
Wed Jun 23 22:05:43 2004 us=760000 108:   renegotiate_packets = 0
Wed Jun 23 22:05:43 2004 us=760095 109:   renegotiate_seconds = 3600
Wed Jun 23 22:05:43 2004 us=760191 110:   handshake_window = 60
Wed Jun 23 22:05:43 2004 us=760286 111:   transition_window = 3600
Wed Jun 23 22:05:43 2004 us=760381 112:   single_session = DISABLED
Wed Jun 23 22:05:43 2004 us=760476 113:   tls_auth_file = '[UNDEF]'
Wed Jun 23 22:05:43 2004 us=760664 114: OpenVPN 1.6.0 i686-pc-linux-gnu [SSL] [LZO] built on Jun 15 2004
Wed Jun 23 22:05:43 2004 us=761776 115: ******* WARNING *******: all encryption and authentication features disabled -- all data will be tunnelled as cleartext
Wed Jun 23 22:05:43 2004 us=761968 116: LZO compression initialized
Wed Jun 23 22:05:43 2004 us=782190 117: TUN/TAP device tun1 opened
Wed Jun 23 22:05:43 2004 us=782487 118: /sbin/ifconfig tun1 10.4.0.2 pointopoint 10.4.0.1 mtu 293
Wed Jun 23 22:05:43 2004 us=792121 119: /sbin/route add -net 195.182.114.52 netmask 255.255.255.255 gw 10.34.140.117
Wed Jun 23 22:05:43 2004 us=800131 120: /sbin/route del -net 0.0.0.0 netmask 0.0.0.0
Wed Jun 23 22:05:43 2004 us=808380 121: /sbin/route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.4.0.1
Wed Jun 23 22:05:43 2004 us=816059 122: Data Channel MTU parms [ L:296 D:296 EF:3 EB:19 ET:0 EL:0 ]
Wed Jun 23 22:05:43 2004 us=816373 123: Local Options String: 'V3,dev-type tun,link-mtu 296,tun-mtu 293,proto TCPv4_CLIENT,ifconfig 10.4.0.1 10.4.0.2,comp-lzo'
Wed Jun 23 22:05:43 2004 us=816510 124: Expected Remote Options String: 'V3,dev-type tun,link-mtu 296,tun-mtu 293,proto TCPv4_SERVER,ifconfig 10.4.0.2 10.4.0.1,comp-lzo'
Wed Jun 23 22:05:43 2004 us=816979 125: Local Options hash (VER=V3): 'b41b7739'
Wed Jun 23 22:05:43 2004 us=817125 126: Expected Remote Options hash (VER=V3): '58f586bf'
Wed Jun 23 22:05:43 2004 us=817244 127: STREAM: RESET
Wed Jun 23 22:05:43 2004 us=817343 128: STREAM: INIT maxlen=296
Wed Jun 23 22:05:43 2004 us=817452 129: Attempting to establish TCP connection with 195.182.114.52:8080
Wed Jun 23 22:05:45 2004 us=331755 130: TCP connection established with 195.182.114.52:8080
Wed Jun 23 22:05:45 2004 us=331869 131: Send to HTTP proxy: 'CONNECT luckyluke.homelinux.org:8080 HTTP/1.1
Host: luckyluke.homelinux.org
User-Agent: Mozilla/4.1 (compatible; MSIE 5.0; Symbian OS; Nokia 6600;423) Opera 6.10 [de]'
Wed Jun 23 22:05:47 2004 us=614502 132: HTTP proxy returned: 'HTTP/1.1 200 Connected'
Wed Jun 23 22:05:49 2004 us=613771 133: TCPv4_CLIENT link local: [undef]
Wed Jun 23 22:05:49 2004 us=613863 134: TCPv4_CLIENT link remote: 195.182.114.52:8080
Wed Jun 23 22:05:49 2004 us=613971 135: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:05:49 2004 us=614010 136: SELECT TR|tw|SR|sw 5/0
Wed Jun 23 22:05:54 2004 us=612959 137:  select returned 0
Wed Jun 23 22:05:54 2004 us=613058 138: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:05:54 2004 us=613095 139: SELECT TR|tw|SR|sw 5/0
Wed Jun 23 22:05:58 2004 us=926460 140:  select returned 1
Wed Jun 23 22:05:58 2004 us=926555 141: STREAM: GET NEXT len=296
Wed Jun 23 22:05:58 2004 us=926611 142: STREAM: ADD length_added=20
Wed Jun 23 22:05:58 2004 us=926649 143: STREAM: ADD returned TRUE, buf_len=18, residual_len=0
Wed Jun 23 22:05:58 2004 us=926681 144: STREAM: GET FINAL len=18
Wed Jun 23 22:05:58 2004 us=926713 145: STREAM: RESET
Wed Jun 23 22:05:58 2004 us=926747 146: TCPv4_CLIENT read returned 18
Wed Jun 23 22:05:58 2004 us=926833 147: TCPv4_CLIENT READ [18] from 195.182.114.52:8080:  DATA fa287f34 6bd4ef7a 812d56b8 d3afc545 9c00
Wed Jun 23 22:05:58 2004 us=926876 148: IP Address OK from 195.182.114.52:8080
Wed Jun 23 22:05:58 2004 us=926976 149: Peer Connection Initiated with 195.182.114.52:8080
Wed Jun 23 22:05:58 2004 us=927012 150: RECEIVED OCC_REQUEST
Wed Jun 23 22:05:58 2004 us=927051 151: SENT OCC_REPLY
Wed Jun 23 22:05:58 2004 us=927087 152: lzo_adaptive_compress_test: comp=0 total=0
Wed Jun 23 22:05:58 2004 us=927800 153: compress 113 -> 110
Wed Jun 23 22:05:58 2004 us=927901 154: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:05:58 2004 us=927939 155: SELECT tr|tw|SR|SW 1/0
Wed Jun 23 22:05:58 2004 us=927990 156:  select returned 1
Wed Jun 23 22:05:58 2004 us=928313 157: TCPv4_CLIENT WRITE [111] to 195.182.114.52:8080:  DATA 66001f28 7f346bd4 ef7a812d 56b8d3af c5459c01 56332c64 65762d74 7970652[more...]
Wed Jun 23 22:05:58 2004 us=928352 158: STREAM: WRITE 111 offset=21
Wed Jun 23 22:05:58 2004 us=928579 159: TCPv4_CLIENT write returned 113
Wed Jun 23 22:05:58 2004 us=928638 160: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:05:58 2004 us=928675 161: SELECT TR|tw|SR|sw 1/0
Wed Jun 23 22:05:59 2004 us=928150 162:  select returned 0
Wed Jun 23 22:05:59 2004 us=928241 163: SENT OCC_REQUEST
Wed Jun 23 22:05:59 2004 us=928288 164: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:05:59 2004 us=928325 165: SELECT tr|tw|SR|SW 5/0
Wed Jun 23 22:05:59 2004 us=928365 166:  select returned 1
Wed Jun 23 22:05:59 2004 us=928455 167: TCPv4_CLIENT WRITE [18] to 195.182.114.52:8080:  DATA fa287f34 6bd4ef7a 812d56b8 d3afc545 9c00
Wed Jun 23 22:05:59 2004 us=928491 168: STREAM: WRITE 18 offset=21
Wed Jun 23 22:05:59 2004 us=928544 169: TCPv4_CLIENT write returned 20
Wed Jun 23 22:05:59 2004 us=928587 170: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:05:59 2004 us=928623 171: SELECT TR|tw|SR|sw 10/0
Wed Jun 23 22:06:01 2004 us=655905 172:  select returned 1
Wed Jun 23 22:06:01 2004 us=656000 173: STREAM: GET NEXT len=296
Wed Jun 23 22:06:01 2004 us=656053 174: STREAM: ADD length_added=113
Wed Jun 23 22:06:01 2004 us=656091 175: STREAM: ADD returned TRUE, buf_len=111, residual_len=0
Wed Jun 23 22:06:01 2004 us=656125 176: STREAM: GET FINAL len=111
Wed Jun 23 22:06:01 2004 us=656156 177: STREAM: RESET
Wed Jun 23 22:06:01 2004 us=656190 178: TCPv4_CLIENT read returned 111
Wed Jun 23 22:06:01 2004 us=656451 179: TCPv4_CLIENT READ [111] from 195.182.114.52:8080:  DATA 66001f28 7f346bd4 ef7a812d 56b8d3af c5459c01 56332c64 65762d74 7970652[more...]
Wed Jun 23 22:06:01 2004 us=656495 180: IP Address OK from 195.182.114.52:8080
Wed Jun 23 22:06:01 2004 us=656568 181: decompress 110 -> 113
Wed Jun 23 22:06:01 2004 us=656606 182: RECEIVED OCC_REPLY
Wed Jun 23 22:06:01 2004 us=656662 183: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:01 2004 us=656698 184: SELECT TR|tw|SR|sw 31536000/0
Wed Jun 23 22:06:17 2004 us=884200 185:  select returned 1
Wed Jun 23 22:06:17 2004 us=884295 186: STREAM: GET NEXT len=296
Wed Jun 23 22:06:17 2004 us=884345 187: Connection reset, restarting [0]
Wed Jun 23 22:06:17 2004 us=884508 188: PID packet_id_free
Wed Jun 23 22:06:17 2004 us=884551 189: Closing TCP/UDP socket
Wed Jun 23 22:06:17 2004 us=884762 190: /sbin/route del -net 195.182.114.52 netmask 255.255.255.255
Wed Jun 23 22:06:17 2004 us=892877 191: /sbin/route del -net 0.0.0.0 netmask 0.0.0.0
Wed Jun 23 22:06:17 2004 us=901185 192: /sbin/route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.34.140.117
Wed Jun 23 22:06:17 2004 us=909363 193: Closing TUN/TAP device
Wed Jun 23 22:06:18 2004 us=14129 194: Restart pause, 10 second(s)
Wed Jun 23 22:06:28 2004 us=15952 195: ******* WARNING *******: all encryption and authentication features disabled -- all data will be tunnelled as cleartext
Wed Jun 23 22:06:28 2004 us=16087 196: LZO compression initialized
Wed Jun 23 22:06:28 2004 us=79514 197: TUN/TAP device tun1 opened
Wed Jun 23 22:06:28 2004 us=79706 198: /sbin/ifconfig tun1 10.4.0.2 pointopoint 10.4.0.1 mtu 293
Wed Jun 23 22:06:28 2004 us=88885 199: /sbin/route add -net 195.182.114.52 netmask 255.255.255.255 gw 10.34.140.117
Wed Jun 23 22:06:28 2004 us=96560 200: /sbin/route del -net 0.0.0.0 netmask 0.0.0.0
Wed Jun 23 22:06:28 2004 us=104189 201: /sbin/route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.4.0.1
Wed Jun 23 22:06:28 2004 us=112408 202: Data Channel MTU parms [ L:296 D:296 EF:3 EB:19 ET:0 EL:0 ]
Wed Jun 23 22:06:28 2004 us=112719 203: Local Options String: 'V3,dev-type tun,link-mtu 296,tun-mtu 293,proto TCPv4_CLIENT,ifconfig 10.4.0.1 10.4.0.2,comp-lzo'
Wed Jun 23 22:06:28 2004 us=112845 204: Expected Remote Options String: 'V3,dev-type tun,link-mtu 296,tun-mtu 293,proto TCPv4_SERVER,ifconfig 10.4.0.2 10.4.0.1,comp-lzo'
Wed Jun 23 22:06:28 2004 us=113005 205: Local Options hash (VER=V3): 'b41b7739'
Wed Jun 23 22:06:28 2004 us=113141 206: Expected Remote Options hash (VER=V3): '58f586bf'
Wed Jun 23 22:06:28 2004 us=113256 207: STREAM: RESET
Wed Jun 23 22:06:28 2004 us=113353 208: STREAM: INIT maxlen=296
Wed Jun 23 22:06:28 2004 us=113463 209: Attempting to establish TCP connection with 195.182.114.52:8080
Wed Jun 23 22:06:29 2004 us=476368 210: TCP connection established with 195.182.114.52:8080
Wed Jun 23 22:06:29 2004 us=476462 211: Send to HTTP proxy: 'CONNECT luckyluke.homelinux.org:8080 HTTP/1.1
Host: luckyluke.homelinux.org
User-Agent: Mozilla/4.1 (compatible; MSIE 5.0; Symbian OS; Nokia 6600;423) Opera 6.10 [de]'
Wed Jun 23 22:06:32 2004 us=13060 212: HTTP proxy returned: 'HTTP/1.1 200 Connected'
Wed Jun 23 22:06:34 2004 us=11987 213: TCPv4_CLIENT link local: [undef]
Wed Jun 23 22:06:34 2004 us=12083 214: TCPv4_CLIENT link remote: 195.182.114.52:8080
Wed Jun 23 22:06:34 2004 us=12150 215: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:34 2004 us=12187 216: SELECT TR|tw|SR|sw 5/0
Wed Jun 23 22:06:39 2004 us=11210 217:  select returned 0
Wed Jun 23 22:06:39 2004 us=11313 218: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:39 2004 us=11400 219: SELECT TR|tw|SR|sw 5/0
Wed Jun 23 22:06:42 2004 us=242211 220:  select returned 1
Wed Jun 23 22:06:42 2004 us=242303 221: STREAM: GET NEXT len=296
Wed Jun 23 22:06:42 2004 us=242356 222: STREAM: ADD length_added=20
Wed Jun 23 22:06:42 2004 us=242395 223: STREAM: ADD returned TRUE, buf_len=18, residual_len=0
Wed Jun 23 22:06:42 2004 us=242428 224: STREAM: GET FINAL len=18
Wed Jun 23 22:06:42 2004 us=242459 225: STREAM: RESET
Wed Jun 23 22:06:42 2004 us=242493 226: TCPv4_CLIENT read returned 18
Wed Jun 23 22:06:42 2004 us=242579 227: TCPv4_CLIENT READ [18] from 195.182.114.52:8080:  DATA fa287f34 6bd4ef7a 812d56b8 d3afc545 9c00
Wed Jun 23 22:06:42 2004 us=242623 228: IP Address OK from 195.182.114.52:8080
Wed Jun 23 22:06:42 2004 us=242728 229: Peer Connection Initiated with 195.182.114.52:8080
Wed Jun 23 22:06:42 2004 us=242764 230: RECEIVED OCC_REQUEST
Wed Jun 23 22:06:42 2004 us=242804 231: SENT OCC_REPLY
Wed Jun 23 22:06:42 2004 us=242840 232: lzo_adaptive_compress_test: comp=0 total=0
Wed Jun 23 22:06:42 2004 us=243311 233: compress 113 -> 110
Wed Jun 23 22:06:42 2004 us=243387 234: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:42 2004 us=243426 235: SELECT tr|tw|SR|SW 2/0
Wed Jun 23 22:06:42 2004 us=243479 236:  select returned 1
Wed Jun 23 22:06:42 2004 us=243769 237: TCPv4_CLIENT WRITE [111] to 195.182.114.52:8080:  DATA 66001f28 7f346bd4 ef7a812d 56b8d3af c5459c01 56332c64 65762d74 7970652[more...]
Wed Jun 23 22:06:42 2004 us=243808 238: STREAM: WRITE 111 offset=21
Wed Jun 23 22:06:42 2004 us=244041 239: TCPv4_CLIENT write returned 113
Wed Jun 23 22:06:42 2004 us=244099 240: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:42 2004 us=244135 241: SELECT TR|tw|SR|sw 2/0
Wed Jun 23 22:06:44 2004 us=243415 242:  select returned 0
Wed Jun 23 22:06:44 2004 us=243508 243: SENT OCC_REQUEST
Wed Jun 23 22:06:44 2004 us=243557 244: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:44 2004 us=243594 245: SELECT tr|tw|SR|SW 5/0
Wed Jun 23 22:06:44 2004 us=243634 246:  select returned 1
Wed Jun 23 22:06:44 2004 us=243724 247: TCPv4_CLIENT WRITE [18] to 195.182.114.52:8080:  DATA fa287f34 6bd4ef7a 812d56b8 d3afc545 9c00
Wed Jun 23 22:06:44 2004 us=243760 248: STREAM: WRITE 18 offset=21
Wed Jun 23 22:06:44 2004 us=243946 249: TCPv4_CLIENT write returned 20
Wed Jun 23 22:06:44 2004 us=243994 250: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:44 2004 us=244030 251: SELECT TR|tw|SR|sw 10/0
Wed Jun 23 22:06:45 2004 us=389558 252:  select returned 1
Wed Jun 23 22:06:45 2004 us=389652 253: STREAM: GET NEXT len=296
Wed Jun 23 22:06:45 2004 us=389704 254: STREAM: ADD length_added=113
Wed Jun 23 22:06:45 2004 us=389743 255: STREAM: ADD returned TRUE, buf_len=111, residual_len=0
Wed Jun 23 22:06:45 2004 us=389775 256: STREAM: GET FINAL len=111
Wed Jun 23 22:06:45 2004 us=389806 257: STREAM: RESET
Wed Jun 23 22:06:45 2004 us=389841 258: TCPv4_CLIENT read returned 111
Wed Jun 23 22:06:45 2004 us=390102 259: TCPv4_CLIENT READ [111] from 195.182.114.52:8080:  DATA 66001f28 7f346bd4 ef7a812d 56b8d3af c5459c01 56332c64 65762d74 7970652[more...]
Wed Jun 23 22:06:45 2004 us=390145 260: IP Address OK from 195.182.114.52:8080
Wed Jun 23 22:06:45 2004 us=390188 261: decompress 110 -> 113
Wed Jun 23 22:06:45 2004 us=390248 262: RECEIVED OCC_REPLY
Wed Jun 23 22:06:45 2004 us=390305 263: STREAM: SET NEXT, buf=[22,0] next=[22,296] len=-1 maxlen=296
Wed Jun 23 22:06:45 2004 us=390341 264: SELECT TR|tw|SR|sw 31536000/0
Wed Jun 23 22:07:00 2004 us=962029 265:  select returned 1
Wed Jun 23 22:07:00 2004 us=962127 266: STREAM: GET NEXT len=296
Wed Jun 23 22:07:00 2004 us=962175 267: Connection reset, restarting [0]
Wed Jun 23 22:07:00 2004 us=962284 268: PID packet_id_free
Wed Jun 23 22:07:00 2004 us=962325 269: Closing TCP/UDP socket
Wed Jun 23 22:07:00 2004 us=962528 270: /sbin/route del -net 195.182.114.52 netmask 255.255.255.255
Wed Jun 23 22:07:00 2004 us=970466 271: /sbin/route del -net 0.0.0.0 netmask 0.0.0.0
Wed Jun 23 22:07:00 2004 us=978219 272: /sbin/route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.34.140.117
Wed Jun 23 22:07:00 2004 us=985924 273: Closing TUN/TAP device
Wed Jun 23 22:07:01 2004 us=88914 274: Restart pause, 10 second(s)

If I ping during the tun1 device, I sniffed a RST and then the connection breaks. Have you got any ideas, why and how I can solve the problem?

Is it because of the "CONNECT" Request in the sources?

Greetings

Ullrich
____________________________________________________
Aufnehmen, abschicken, nah sein - So einfach ist 
WEB.DE Video-Mail: http://freemail.web.de/?mc=021200


