From: Denis Vlasenko <vda@...216...>
MIME-Version: 1.0
Message-Id: <200405132139.15121.vda@...216...>
Subject: [Openvpn-devel] openvpn-2.0_beta1: Win<->Linux flood ping intermittently stops
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
Date: Thu May 13 11:40:05 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi folks,

I know Linux well, but started to play with openvpn just yesterday.

I am making tunnel between WinXP notebook and Linux desktop
over 10Mbit link. One switch is between them, no routers.

Linux: 2.6.6
WinXP: ver reports "5.1.2600"

Linux side is compiled from source, Win side installed from
binary openvpn-2.0_beta1-install.exe

I run openvpn --config cfg on both sides.

Linux side config:
remote 1.1.1.3
port 8000
proto udp
dev tun
ifconfig 2.1.1.2 2.1.1.1
secret key
ping 10
verb 5
mute 10

Key file is the same on both sides.

WinXP side config is identical except:
remote 1.1.1.2
ifconfig 2.1.1.1 2.1.1.2

Tunnel is established without problems. Then I stress test it
with three instances of large packet flood ping:
# ping -A -s1444 2.1.1.1

typically it looks like this:
         CPU load         eth  in   out  tun  in   out
         ================ ============== ==============
20:21:42 cpu [SSSUUU....] eth0 379k 362k tun0 329k 333k
20:21:43 cpu [SSSUUU....] eth0 357k 343k tun0 314k 316k
20:21:44 cpu [SSSUU.....] eth0 276k 290k tun0 240k 267k
20:21:45 cpu [U.........] eth0  97k  67k tun0  84k  61k
20:21:46 cpu [SSD.......] eth0  60k  38k tun0  34k  34k
20:21:47 cpu [SU........] eth0 158k 138k tun0 125k 126k
20:21:48 cpu [SSSUUU....] eth0 299k 300k tun0 267k 277k
20:21:49 cpu [SU........] eth0 126k 117k tun0  93k 107k
20:21:50 cpu [U.........] eth0  24k  14k tun0  12k  12k
20:21:51 cpu [SSU.......] eth0  29k  18k tun0  15k  15k
...
and sometimes even:
20:28:11 cpu [SSSUU.....] eth0 284k 289k tun0 263k 267k
20:28:12 cpu [SSUU......] eth0 248k 307k tun0 230k 284k
20:28:13 cpu [S.........] eth0    0 239k tun0    0 221k
20:28:14 cpu [U.........] eth0    0 242k tun0    0 224k
20:28:15 cpu [..........] eth0    0 240k tun0    0 222k
20:28:16 cpu [SSU.......] eth0    0 239k tun0    0 221k
20:28:17 cpu [..........] eth0    0 242k tun0    0 224k
20:28:18 cpu [..........] eth0    0 244k tun0    0 225k
20:28:19 cpu [..........] eth0    0 242k tun0    0 224k
20:28:20 cpu [..........] eth0    0 240k tun0    0 222k
20:28:21 cpu [SSU.......] eth0  12k 236k tun0  11k 218k
20:28:22 cpu [SU........] eth0 113k 321k tun0 104k 299k
...
i.e. XP side did not respond to pings!
I looked at 'networking' tab in TaskMan. I see that
incoming traffic for XP is larger that outgoing one,
this verifies that XP did receive those packets over
'normal' interface. However, tunnel interface have
incoming==outgoing, always. Does XP tun drops
incoming packets??

CPU load on XP is ~75%, i.e. it does not hit 100%

I tried pinging non-tunneled link with same ping.
It gives steady 0.5 Mbyte/s each way. No dropouts.

To sum up:
* opnvpn bandwitdh vary too much.
* it doesn't reach ~0.5Mbyte/s.
* sometimes XP side drops packets.

Are these problems known? Do you need more info?
How can I help?
--
vda


