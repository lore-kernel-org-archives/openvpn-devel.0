Message-ID: <40C37A43.6030900@...231...>
From: sam <samwun@...231...>
MIME-Version: 1.0
References: <twig.1086485727.92671@...41...>
In-Reply-To: <twig.1086485727.92671@...41...>
Subject: [Openvpn-devel] beta3 client returned incorrect IP with ping.
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
Date: Mon Jun  7 08:30:03 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi,

I just have the beta3 client and server tested with the --mode server 
configuration. When I tried to ping a remote internal network address, 
the ping command (at winxp) returned an incorrect network from the 
server with TTL expired...
the server config is:
# OpenVPN 2 - Server configuration file
dev tap
port 5000
mode server
ifconfig 10.8.0.1 255.255.255.0
ifconfig-pool 10.8.0.4 10.8.0.255
tls-server
ca /root/my-openvpn-keys/ca.crt
cert /root/my-openvpn-keys/deception.crt
key /root/my-openvpn-keys/deception.key
dh /root/my-openvpn-keys/dh1024.pem       
daemon
###log-append /var/log/openvpn/openvpn.log
##log /var/log/openvpn/openvpn.log
writepid /var/run/openvpn.pid
#ping 20
ping-restart 10
#ping-exit 600
push "ping 10"
push "ping-restart 10"
push "route-gateway 10.8.0.1"
push "route 192.168.4.0 255.255.255.0"
cipher aes-128-cbc
comp-lzo
#inactive 600
user nobody
group nogroup
verb 1
mute 4

The netstat -rn at server is:
Destination        Gateway            Flags    Refs      Use  Netif Expire
default            192.168.1.254      UGS         0        0    em0
10.8/24            link#8             UC          0        0   tap0
127.0.0.1          127.0.0.1          UH          0        0    lo0
192.168.1          link#1             UC          0        0    em0
192.168.1.129      00:09:6b:8d:b2:67  UHLW        0     2499    em0   1198
192.168.1.254      00:02:b3:0b:3c:d1  UHLW        1     2619    em0   1134
192.168.1.255      ff:ff:ff:ff:ff:ff  UHLWb       0       25    em0
192.168.4          link#2             UC          0        0   fxp0
192.168.4.255      ff:ff:ff:ff:ff:ff  UHLWb       0       25   fxp0

result of ifconfig -a at srever is:
em0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        options=1b<RXCSUM,TXCSUM,VLAN_MTU,VLAN_HWTAGGING>
        inet 192.168.1.1 netmask 0xffffff00 broadcast 192.168.1.255
        inet6 fe80::20e:cff:fe05:8229%em0 prefixlen 64 scopeid 0x1
        ether 00:0e:0c:05:82:29
        media: Ethernet autoselect (10baseT/UTP <half-duplex>)
        status: active
fxp0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        options=b<RXCSUM,TXCSUM,VLAN_MTU>
        inet 192.168.4.1 netmask 0xffffff00 broadcast 192.168.4.255
        inet6 fe80::202:b3ff:febb:a7a5%fxp0 prefixlen 64 scopeid 0x2
        ether 00:02:b3:bb:a7:a5
        media: Ethernet autoselect (none)
        status: no carrier
tap0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        inet6 fe80::2bd:bff:fef9:0%tap0 prefixlen 64 scopeid 0x8
        inet 10.8.0.1 netmask 0xffffff00 broadcast 10.8.0.255
        ether 00:bd:0b:f9:00:00
        Opened by PID 17984

At the winxp machine, ipconfig returned correct IP address 10.8.0.4, and 
netstat -rn at winxp seems to be normal too.
only when I ping 192.168.4.1 from winxp, it returned 10.31.0.1. I also 
noticed that the tap-win device is shown "plug"/"unpug" every 10 min, 
might be this is caused by the ping 10 option in the server script.

What should be the correct confnig for the beta3 now?

Thanks
Sam


