Message-ID: <433012C0.9070505@...459...>
From: Jothi <jothikumar@...459...>
MIME-Version: 1.0
Subject: [Openvpn-devel] ifconfig for tun interface
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
Date: Tue Sep 20 06:46:25 2005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I downloaded & installed the tun kernel extension in
my Mac 10.4 Build 8A428.

Before I assign IP to tun interface ifconfig tun0 as
follows

tun0:
flags=8850<POINTOPOINT,RUNNING,SIMPLEX,MULTICAST> mtu
1500
        closed

I ran my application(To open driver handle) & 
I tried to assign an IP to tun0 interface using 
ifconfig tun0 172.16.100.28 1.2.3.9

After I assign IP to tun interface ifconfig tun0 
tun0:
flags=8851<UP,POINTOPOINT,RUNNING,SIMPLEX,MULTICAST>
mtu 1500
        inet 172.16.100.28 --> 1.2.3.9 netmask
0xffff0000 
        open (pid 253)

I expected the assigned IP will allow me to ping. But
not allowing me to ping.

Is there anything I need enable in the driver to come
out of this problem.
Is there anything I missed out please advice me.
Also attached netstat -rn & ifconfig dump of Mac 10.4
PC.

Regards,
Jothi


netstat -rn is as follows

iMac:~ root# netstat -rn
Routing tables

Internet:
Destination        Gateway            Flags    Refs     Use  Netif Expire
default            172.16.2.1         UGSc        6      10    en0
1.2.3.9            172.16.100.28      UH          0       0   tun0
127                127.0.0.1          UCS         0       0    lo0
127.0.0.1          127.0.0.1          UH         11    1322    lo0
169.254            link#4             UCS         0       0    en0
172.16             link#4             UCS         4       0    en0
172.16.2.1         0:9:f:30:61:8a     UHLW        3       0    en0   1180
172.16.2.104       0:8:a1:45:d6:22    UHLW        0       1    en0    913
172.16.100.20      0:d0:b7:9c:8d:fb   UHLW        1      30    en0    982
172.16.100.61      127.0.0.1          UHS         0       0    lo0
172.16.255.255     link#4             UHLWb       4      49    en0

ifconfig is as follows
iMac:~ root# ifconfig 
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu
16384
        inet 127.0.0.1 netmask 0xff000000 
        inet6 ::1 prefixlen 128 
        inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1 
gif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280
stf0: flags=0<> mtu 1280
en0:
flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST>
mtu 1500
        inet6 fe80::211:24ff:fecd:4f3c%en0 prefixlen
64 scopeid 0x4 
        inet 172.16.100.61 netmask 0xffff0000
broadcast 172.16.255.255
        ether 00:11:24:cd:4f:3c 
        media: autoselect (100baseTX <full-duplex>)
status: active
        supported media: none autoselect 10baseT/UTP
<half-duplex> 10baseT/UTP <full-duplex> 10baseT/UTP
<full-duplex,hw-loopback> 100baseTX <half-duplex>
100baseTX <full-duplex> 100baseTX
<full-duplex,hw-loopback> 1000baseT <full-duplex>
1000baseT <full-duplex,hw-loopback> 1000baseT
<full-duplex,flow-control> 1000baseT
<full-duplex,flow-control,hw-loopback>
en1:
flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST>
mtu 1500
        ether 00:11:24:c0:4d:04 
        media: autoselect (<unknown type>) status:
inactive
        supported media: autoselect
fw0:
flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST>
mtu 4078
        lladdr 00:11:24:ff:fe:cd:4f:3c 
        media: autoselect <full-duplex> status:
inactive
        supported media: autoselect <full-duplex>
tun0:
flags=8851<UP,POINTOPOINT,RUNNING,SIMPLEX,MULTICAST>
mtu 1500
        inet 172.16.100.28 --> 1.2.3.9 netmask
0xffff0000 
        open (pid 253)
tun1:
flags=8850<POINTOPOINT,RUNNING,SIMPLEX,MULTICAST> mtu
1500
        closed





