Message-ID: <2a5bf6c9-c54a-06bb-9649-f19ff5f2be31@...1227...>
Date: Wed, 29 Jun 2022 17:15:38 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220628162848.20103-1-kprovost@...2661...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220628162848.20103-1-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH DCO]: FreeBSD DCO support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 28.06.22 um 18:28 schrieb Kristof Provost via Openvpn-devel:
> Hi,
> 
> Here's the most recent version of the FreeBSD DCO patch.
> This is based on top of the dco branch, at
> 480fa1c983aba9b0790ea94df209e1686f08336b.
> 
> Relatedly, the kernel side of that support has just landed in FreeBSD's
> repo: https://cgit.freebsd.org/src/commit/?id=ab91feabcc6f9da21d5c75028153af16d06e679a

I tested this on top of Antonios branch but got an error when connecting 
from a test client:

2022-06-29 17:10:57 us=506086 lethe/192.168.188.134:61923 dco_new_peer: 
peer-id 0, fd 7
2022-06-29 17:10:57 us=506125 lethe/192.168.188.134:61923 Failed to 
create new peer 51
2022-06-29 17:10:57 us=506137 lethe/192.168.188.134:61923 Cannot add 
peer to DCO: Operation not permitted


Any idea why I might get a permission denied from the kernel there?

command line was (config fp only has fingerprint commands in it):

sudo  ./src/openvpn/openvpn --server 10.0.0.0 255.255.255.0  --dev tun 
--dh none --config ~/ovpn/confs/fp  --cert 
~/ovpn/confs/cert128serial.pem  --key ~/ovpn/confs/cert128serial.pem 
--verb 3 --max-clients 25000 --push "explicit-exit-notify 1" --keepalive 
10 60  --explicit-exit-notify 1 --push "blaba bla" --tun-mtu 65000 
--topology subnet --verb 6


2022-06-29 17:12:04 us=36114 192.168.188.134:54932 VERIFY OK: depth=0, 
CN=lethe
2022-06-29 17:12:04 us=36235 192.168.188.134:54932 VERIFY OK: depth=0, 
CN=lethe
2022-06-29 17:12:04 us=39002 192.168.188.134:54932 peer info: IV_VER=2.6_git
2022-06-29 17:12:04 us=39034 192.168.188.134:54932 peer info: IV_PLAT=win
2022-06-29 17:12:04 us=39041 192.168.188.134:54932 peer info: IV_TCPNL=1
2022-06-29 17:12:04 us=39046 192.168.188.134:54932 peer info: IV_NCP=2
2022-06-29 17:12:04 us=39052 192.168.188.134:54932 peer info: 
IV_CIPHERS=AES-256-GCM:AES-128-GCM
2022-06-29 17:12:04 us=39058 192.168.188.134:54932 peer info: IV_PROTO=30
2022-06-29 17:12:04 us=39063 192.168.188.134:54932 peer info: IV_LZO_STUB=1
2022-06-29 17:12:04 us=39068 192.168.188.134:54932 peer info: IV_COMP_STUB=1
2022-06-29 17:12:04 us=39073 192.168.188.134:54932 peer info: 
IV_COMP_STUBv2=1
2022-06-29 17:12:04 us=39113 192.168.188.134:54932 WARNING: 'link-mtu' 
is used inconsistently, local='link-mtu 65041', remote='link-mtu 1441'
2022-06-29 17:12:04 us=39123 192.168.188.134:54932 WARNING: 'tun-mtu' is 
used inconsistently, local='tun-mtu 65000', remote='tun-mtu 1400'
2022-06-29 17:12:04 us=39182 192.168.188.134:54932 dco_update_keys: 
peer_id=0
2022-06-29 17:12:04 us=39210 192.168.188.134:54932 UDPv6 WRITE [184] to 
[AF_INET6]::ffff:192.168.188.134:54932: P_CONTROL_V1 kid=0 [ 2 ] pid=3 
DATA len=158
2022-06-29 17:12:04 us=39254 192.168.188.134:54932 dco_update_keys: 
peer_id=0
2022-06-29 17:12:04 us=39268 192.168.188.134:54932 UDPv6 WRITE [216] to 
[AF_INET6]::ffff:192.168.188.134:54932: P_CONTROL_V1 kid=0 [ ] pid=4 
DATA len=202
2022-06-29 17:12:04 us=39282 192.168.188.134:54932 dco_update_keys: 
peer_id=0
2022-06-29 17:12:04 us=40390 192.168.188.134:54932 UDPv6 READ [22] from 
[AF_INET6]::ffff:192.168.188.134:54932: P_ACK_V1 kid=0 [ 3 ] DATA len=0
2022-06-29 17:12:04 us=40440 192.168.188.134:54932 dco_update_keys: 
peer_id=0
2022-06-29 17:12:04 us=44123 192.168.188.134:54932 UDPv6 READ [22] from 
[AF_INET6]::ffff:192.168.188.134:54932: P_ACK_V1 kid=0 [ 4 ] DATA len=0
2022-06-29 17:12:04 us=44198 192.168.188.134:54932 Control Channel: 
TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 
bit EC, curve secp384r1, signature: ecdsa-with-SHA256
2022-06-29 17:12:04 us=44219 192.168.188.134:54932 [lethe] Peer 
Connection Initiated with [AF_INET6]::ffff:192.168.188.134:54932
2022-06-29 17:12:04 us=44236 192.168.188.134:54932 dco_update_keys: 
peer_id=0
2022-06-29 17:12:04 us=44252 lethe/192.168.188.134:54932 MULTI_sva: pool 
returned IPv4=10.0.0.2, IPv6=(Not enabled)
2022-06-29 17:12:04 us=44364 lethe/192.168.188.134:54932 MULTI: Learn: 
10.0.0.2 -> lethe/192.168.188.134:54932
2022-06-29 17:12:04 us=44373 lethe/192.168.188.134:54932 MULTI: primary 
virtual IP for lethe/192.168.188.134:54932: 10.0.0.2
2022-06-29 17:12:04 us=44393 lethe/192.168.188.134:54932 dco_new_peer: 
peer-id 0, fd 7
2022-06-29 17:12:04 us=44492 lethe/192.168.188.134:54932 Failed to 
create new peer 51
2022-06-29 17:12:04 us=44530 lethe/192.168.188.134:54932 Cannot add peer 
to DCO: Operation not permitted
2022-06-29 17:12:04 us=44538 lethe/192.168.188.134:54932 Delayed exit in 
5 seconds
2022-06-29 17:12:04 us=44559 lethe/192.168.188.134:54932 SENT CONTROL 
[lethe]: 'AUTH_FAILED' (status=1)
2022-06-29 17:12:04 us=44589 lethe/192.168.188.134:54932 
dco_update_keys: peer_id=0
2022-06-29 17:12:04 us=44606 lethe/192.168.188.134:54932 UDPv6 WRITE 
[48] to [AF_INET6]::ffff:192.168.188.134:54932: P_CONTROL_V1 kid=0 [ ] 
pid=5 DATA len=34
2022-06-29 17:12:04 us=44633 lethe/192.168.188.134:54932 
dco_update_keys: peer_id=0
2022-06-29 17:12:05 us=242725 lethe/192.168.188.134:54932 
dco_update_keys: peer_id=0
2022-06-29 17:12:06 us=508405 lethe/192.168.188.134:54932 
dco_update_keys: peer_id=0
2022-06-29 17:12:06 us=508569 lethe/192.168.188.134:54932 UDPv6 WRITE 
[48] to [AF_INET6]::ffff:192.168.188.134:54932: P_CONTROL_V1 kid=0 [ ] 
pid=5 DATA len=34
2022-06-29 17:12:06 us=508616 lethe/192.168.188.134:54932 
dco_update_keys: peer_id=0
2022-06-29 17:12:07 us=729578 lethe/192.168.188.134:54932 
dco_update_keys: peer_id=0
2022-06-29 17:12:08 us=929417 lethe/192.168.188.134:54932 
dco_update_keys: peer_id=0
2022-06-29 17:12:10 us=142712 lethe/192.168.188.134:54932 
SIGTERM[soft,delayed-exit] received, client-instance exiting

