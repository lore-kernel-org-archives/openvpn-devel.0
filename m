From: "wangdq@...1037..." <wangdq@...1037...>
Date: Wed, 18 Jul 2007 16:00:13 +0800
Message-Id: <1184745613.17274.4.camel@...1038...>
Mime-Version: 1.0
Subject: [Openvpn-devel] out openvpn client can't link
Reply-To: wangdq@...1037...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hello,can you help ? 
thanks 
 
   I use openvpn client ,see the next debug (verb 9) msg, can't connect
to sever.

   Wed Dec 31 05:58:48 1969 us=128677 TLS: control channel, op=P_ACK_V1,
IP=192.168.0.175:1194
Wed Dec 31 05:58:48 1969 us=137152 TLS: initial packet test, i=0
state=S_PRE_START, mysid=2e83c367 c005b16b, rec-sid=05969caf 3bdc8503,
rec-ip=192.168.0.175:1194, stored-sid=05969caf 3bdc8503, stored-
ip=192.168.0.175:1194
Wed Dec 31 05:58:48 1969 us=143904 TLS: found match, session[0],
sid=05969caf 3bdc8503
Wed Dec 31 05:58:48 1969 us=146135 TLS: received control channel packet
s#=0 sid=05969caf 3bdc8503
Wed Dec 31 05:58:48 1969 us=147631 ACK received for pid 0, deleting from
send buffer
Wed Dec 31 05:58:48 1969 us=154824 TLS: tls_multi_process: i=0
state=S_PRE_START, mysid=2e83c367 c005b16b, stored-sid=05969caf
3bdc8503, stored-ip=192.168.0.175:1194
Wed Dec 31 05:58:48 1969 us=159175 TLS: tls_process: chg=0
ks=S_PRE_START lame=S_UNDEF to_link->len=0 wakeup=604800
Wed Dec 31 05:58:48 1969 us=162667 STATE S_START
Wed Dec 31 05:58:48 1969 us=165476 ACK reliable_can_send active=0
current=0 : [1]
Wed Dec 31 05:58:48 1969 us=176207 STATE S_SENT_KEY
Wed Dec 31 05:58:48 1969 us=181854 BIO read tls_read_ciphertext 88 bytes
Wed Dec 31 05:58:48 1969 us=184541 ACK mark active outgoing ID 1
Wed Dec 31 05:58:48 1969 us=192111 Outgoing Ciphertext -> Reliable
Wed Dec 31 05:58:48 1969 us=193632 TLS: tls_process: chg=1 ks=S_SENT_KEY
lame=S_UNDEF to_link->len=0 wakeup=604800
Wed Dec 31 05:58:48 1969 us=195317 ACK reliable_can_send active=1
current=0 : [2] 1
Wed Dec 31 05:58:48 1969 us=198591 ACK reliable_send_timeout 64872 [2] 1
Wed Dec 31 05:58:48 1969 us=199973 TLS: tls_process: timeout set to 59
Wed Dec 31 05:58:48 1969 us=209701 TLS: tls_multi_process: i=1
state=S_INITIAL, mysid=1c250a1c 7e14a525, stored-sid=00000000 00000000,
stored-ip=[undef]
Wed Dec 31 05:58:48 1969 us=217078 TLS: tls_multi_process: i=2
state=S_UNDEF, mysid=00000000 00000000, stored-sid=00000000 00000000,
stored-ip=[undef]
Wed Dec 31 05:58:48 1969 us=221937 STREAM: SET NEXT, buf=[80,0] next=
[80,1575] len=-1 maxlen=1575
Wed Dec 31 05:58:48 1969 us=226082 PO_CTL rwflags=0x0001 ev=3
arg=0x1013feb0
Wed Dec 31 05:58:48 1969 us=233229 I/O WAIT T?|T?|SR|Sw [15/0]
Wed Dec 31 05:59:03 1969 us=241262  event_wait returned 0
Wed Dec 31 05:59:03 1969 us=245338 I/O WAIT status=0x0020
Wed Dec 31 05:59:03 1969 us=252396 TLS: tls_multi_process: i=0
state=S_SENT_KEY, mysid=2e83c367 c005b16b, stored-sid=05969caf 3bdc8503,
stored-ip=192.168.0.175:1194
Wed Dec 31 05:59:03 1969 us=256738 TLS: tls_process: chg=0 ks=S_SENT_KEY
lame=S_UNDEF to_link->len=0 wakeup=604800
Wed Dec 31 05:59:03 1969 us=262160 ACK reliable_can_send active=1
current=0 : [2] 1
Wed Dec 31 05:59:03 1969 us=268073 ACK reliable_send_timeout 64857 [2] 1
Wed Dec 31 05:59:03 1969 us=273365 TLS: tls_process: timeout set to 44
Wed Dec 31 05:59:03 1969 us=278997 TLS: tls_multi_process: i=1
state=S_INITIAL, mysid=1c250a1c 7e14a525, stored-sid=00000000 00000000,
stored-ip=[undef]
Wed Dec 31 05:59:03 1969 us=285392 TLS: tls_multi_process: i=2
state=S_UNDEF, mysid=00000000 00000000, stored-sid=00000000 00000000,
stored-ip=[undef]
Wed Dec 31 05:59:03 1969 us=289764 STREAM: SET NEXT, buf=[80,0] next=
[80,1575] len=-1 maxlen=1575
Wed Dec 31 05:59:03 1969 us=296809 PO_CTL rwflags=0x0001 ev=3
arg=0x1013feb0
Wed Dec 31 05:59:03 1969 us=301498 I/O WAIT T?|T?|SR|Sw [15/0]

   the ethereal output:( server: 192.168.0.175 client: 192.168.0.125)

 
   2.501041 192.168.0.125 -> 192.168.0.175 TCP 1068 > 1194 [SYN] Seq=0
Len=0 MSS=1460 TSV=506825 TSER=0 WS=0
  2.501340 192.168.0.175 -> 192.168.0.125 TCP 1194 > 1068 [SYN, ACK]
Seq=0 Ack=1 Win=5792 Len=0 MSS=1460 TSV=696348282 TSER=506825 WS=2
  2.502677 192.168.0.125 -> 192.168.0.175 TCP 1068 > 1194 [ACK] Seq=1
Ack=1 Win=5840 Len=0 TSV=506826 TSER=696348282
  2.505983 192.168.0.175 -> 192.168.0.125 TCP 1194 > 1068 [PSH, ACK]
Seq=1 Ack=1 Win=5792 Len=16 TSV=696348287 TSER=506826
  2.507068 192.168.0.125 -> 192.168.0.175 TCP 1068 > 1194 [ACK] Seq=1
Ack=17 Win=5840 Len=0 TSV=506826 TSER=696348287
  2.775418 192.168.0.125 -> 192.168.0.175 TCP 1068 > 1194 [PSH, ACK]
Seq=1 Ack=17 Win=5840 Len=28 TSV=506853 TSER=696348287
  2.823109 192.168.0.175 -> 192.168.0.125 TCP 1194 > 1068 [ACK] Seq=17
Ack=29 Win=5792 Len=0 TSV=696348595 TSER=506853
  2.825592 192.168.0.175 -> 192.168.0.125 TCP 1194 > 1068 [PSH, ACK]
Seq=17 Ack=29 Win=5792 Len=24 TSV=696348597 TSER=506853
  2.826844 192.168.0.125 -> 192.168.0.175 TCP 1068 > 1194 [ACK] Seq=29
Ack=41 Win=5840 Len=0 TSV=506858 TSER=696348597


-- 
wangdq@...1037... <wangdq@...1037...>
gongye.com.cn


