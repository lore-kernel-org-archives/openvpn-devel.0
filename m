From: Denis Vlasenko <vda@...216...>
MIME-Version: 1.0
Message-Id: <200405202241.17774.vda@...216...>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NbgrAdbS+CrupIL"
Subject: [Openvpn-devel] mppe loses last 3 bytes of ping.
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
Date: Fri May 21 07:12:01 2004
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_NbgrAdbS+CrupIL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

Just started to play with pptp under Linux.
Everything looks ok except mppe.

mppe encrypted ping -c1:

ping source side:
# tcpdump -nlippp0 -s0 -vvv -xX
tcpdump: listening on ppp0, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
23:15:07.968863 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 84) 1.1.6.2 > 1.1.6.1: icmp 64: echo request seq 1
0x0000   0004 0200 0000 0000 0000 0000 0000 0800        ................
0x0010   4500 0054 0000 4000 4001 2ca5 0101 0602        E..T..@...220...@.,.....
0x0020   0101 0601 0800 1f1f a613 0001 4bc0 ab40        ............K..@
0x0030   42c8 0e00 0809 0a0b 0c0d 0e0f 1011 1213        B...............
0x0040   1415 1617 1819 1a1b 1c1d 1e1f 2021 2223        .............!"#
0x0050   2425 2627 2829 2a2b 2c2d 2e2f 3031 3233        $%&'()*+,-./0123
0x0060   3435 3637                                      4567

ping target side:
# tcpdump -nlippp0 -s0 -vvv -xX
tcpdump: listening on ppp0, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
23:15:01.521393 IP truncated-ip - 3 bytes missing! (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 84) 1.1.6.2 > 1.1.6.1: icmp 64: echo
0x0000   0000 0200 0000 0000 0000 0000 0000 0800        ................
0x0010   4500 0054 0000 4000 4001 2ca5 0101 0602        E..T..@...220...@.,.....
0x0020   0101 0601 0800 1f1f a613 0001 4bc0 ab40        ............K..@
0x0030   42c8 0e00 0809 0a0b 0c0d 0e0f 1011 1213        B...............
0x0040   1415 1617 1819 1a1b 1c1d 1e1f 2021 2223        .............!"#
0x0050   2425 2627 2829 2a2b 2c2d 2e2f 3031 3233        $%&'()*+,-./0123
0x0060   34                                             4

If I run exactly the same config but with 'require-mppe' removed
from configs on both client and server side, this does not happen.

versions (identical for server and client)
========
poptop-1.1.4
ppp-2.4.2_cvs_20021120
pptp-linux-1.2.0
linux-2.6.6 patched with kernelmod-0.8/2.6/* files.
	I rediffed patch against 2.6.5.
	Patch is attached.
	Was applied to 2.6.6 (with offsets).

server
======
pppd options file:
mru 1467
mtu 1467
logfd 2
require-mppe
require-mschap-v2
debug
show-password
name PPTP
remotename test

pptpd conf file:
localip 1.1.6.1
remoteip 1.1.6.2-255

pptpd \
    --conf "$PWD/pptpd.conf" \
    --option "$PWD/options.pptpd.mppe" \
    --debug \
    --fg \
    --pidfile /dev/null

client
======
pppd options file: (empty)

pppd \
    noipdefault \
    name test \
    remotename PPTP \
    nodefaultroute \
    noproxyarp \
    nodetach \
    logfd 2 \
    noauth \
    nobsdcomp \
    nodeflate \
    require-mppe \
    nomppe-stateful \
    debug \
    show-password \
    mru 1467 \
    mtu 1467 \
    lcp-echo-failure 3 \
    lcp-echo-interval 27 \
    maxfail 1 \
    pty "pptp 1.1.1.1 --nolaunchpppd" \
--
vda



--Boundary-00=_NbgrAdbS+CrupIL
Content-Type: application/x-gzip;
  name="linux-2.6.5.mppe.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="linux-2.6.5.mppe.patch.gz"

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

--Boundary-00=_NbgrAdbS+CrupIL--


