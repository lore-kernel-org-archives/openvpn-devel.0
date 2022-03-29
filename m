MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Tue, 29 Mar 2022 18:21:37 +0800
Message-ID: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
Subject: [Openvpn-devel] [ovpn-dco] can not delete tun interface
 automatically if option "user nobody" is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <antonio@...515...>, Arne Schwabe <arne@...1227...>

Hi,

1. Add option "user nobody" to test ovpn-dco.
2. Start openvpn, below is the log. Then we will see tun0 is still
there after openvpn exit. We must use the command "ip link del tunX"
to delete. This is not friendly to end user.

root@...2607...:/tmp/etc# openvpn test.conf
2022-03-29 18:12:43 Note: --cipher is not set. OpenVPN versions before
2.5 defaulted to BF-CBC as fallback when cipher negotiation failed in
this case. If you need this fallback please add '--data-ciphers-fallb.
2022-03-29 18:12:43 OpenVPN 2.6_git aarch64-openwrt-linux-gnu [SSL
(OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO] [AEAD] [DCO]
2022-03-29 18:12:43 library versions: OpenSSL 1.1.1n  15 Mar 2022, LZO
2.10
2022-03-29 18:12:43 net_route_v4_best_gw query: dst 0.0.0.0
2022-03-29 18:12:43 net_route_v4_best_gw result: via 192.168.5.1 dev
eth5
2022-03-29 18:12:43 Diffie-Hellman initialized with 2048 bit key
2022-03-29 18:12:43 net_iface_new: add tun0 type ovpn-dco
2022-03-29 18:12:43 TUN/TAP device tun0 opened
2022-03-29 18:12:43 net_iface_mtu_set: mtu 1500 for tun0
2022-03-29 18:12:43 net_iface_up: set tun0 up
2022-03-29 18:12:43 net_addr_v4_add: 10.8.0.1/24 dev tun0
2022-03-29 18:12:43 Socket Buffers: R=[212992->212992]
S=[212992->212992]
2022-03-29 18:12:43 UDPv4 link local (bound): [AF_INET][undef]:1195
2022-03-29 18:12:43 UDPv4 link remote: [AF_UNSPEC]
2022-03-29 18:12:43 GID set to nogroup
2022-03-29 18:12:43 UID set to nobody
2022-03-29 18:12:43 MULTI: multi_init called, r=256 v=256
2022-03-29 18:12:43 IFCONFIG POOL IPv4: base=10.8.0.2 size=253
2022-03-29 18:12:43 Initialization Sequence Completed
^C2022-03-29 18:12:45 event_wait : Interrupted system call
(fd=-1,code=4)
2022-03-29 18:12:45 Closing TUN/TAP interface
2022-03-29 18:12:45 net_addr_v4_del: 10.8.0.1 dev tun0
2022-03-29 18:12:45 sitnl_send: rtnl: generic error (-1): Operation
not permitted
2022-03-29 18:12:45 Linux can't del IP from iface tun0
2022-03-29 18:12:45 net_iface_del: delete tun0
2022-03-29 18:12:45 sitnl_send: rtnl: generic error (-1): Operation
not permitted
2022-03-29 18:12:45 SIGINT[hard,] received, process exiting

Tony

