From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] incomplete system routing table
In-Reply-To: <4144A6D3.70503@...83...>
Message-ID: <Pine.LNX.4.58.0409131257130.24302@...269...>
References: <4144A6D3.70503@...83...>
MIME-Version: 1.0
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
Date: Mon Sep 13 12:02:00 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Kiszka <jan.kiszka@...83...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 12 Sep 2004, Jan Kiszka wrote:

> Hi,
> 
> on a Windows 2000 system, I'm facing troubles with setting the default 
> gateway. The problem is that openvpn reports only two routing table 
> entries in its log file:
> 
> SYSTEM ROUTING TABLE
> 127.0.0.0 255.0.0.0 127.0.0.1 p=0 i=1 t=0 pr=2 a=0 h=0 m=1/1/1/1/1
> 127.0.0.1 255.255.255.255 127.0.0.1 p=0 i=1 t=0 pr=2 a=0 h=0 m=1/1/1/1/1
> SYSTEM ADAPTER LIST
> TAP-Win32 Adapter V8
>    Index = 2
>    GUID = {62B7CB49-88A5-43EB-B7ED-63647CCE3A20}
>    IP = XXX.XXX.XXX.36/255.255.255.0
>    MAC = 00:ff:62:b7:cb:49
>    GATEWAY =
>    DHCP SERV = XXX.XXX.XXX.3
>    DHCP LEASE OBTAINED = Sun Sep 12 21:14:10 2004
>    DHCP LEASE EXPIRES  = Sun Sep 12 22:14:10 2004
> Realtek RTL8139/810x Family Fast Ethernet NIC
>    Index = 16777220
>    GUID = {890D661C-E523-41A5-969A-C88B9A8467AA}
>    IP = 192.168.0.100/255.255.255.0
>    MAC = 00:e0:7d:8c:df:0f
>    GATEWAY = 192.168.0.1/0.0.0.0
>    DHCP SERV = 192.168.0.1
>    DHCP LEASE OBTAINED = Sun Sep 12 21:11:59 2004
>    DHCP LEASE EXPIRES  = Sun Sep 12 21:21:59 2004
> 
> "route print" gives me this list:
> 
>            0.0.0.0          0.0.0.0      192.168.0.1   192.168.0.100
>          127.0.0.0        255.0.0.0        127.0.0.1       127.0.0.1
>        192.168.0.0    255.255.255.0    192.168.0.100   192.168.0.100
>      192.168.0.100  255.255.255.255        127.0.0.1       127.0.0.1
>      192.168.0.255  255.255.255.255    192.168.0.100   192.168.0.100
>          224.0.0.0        224.0.0.0    192.168.0.100   192.168.0.100
>    255.255.255.255  255.255.255.255    192.168.0.100               2
> default gateway:       192.168.0.1
> 
> I also tried the route_method switch, but then I discovered that this 
> only applies to add/delete operations. Is GetIpForwardTable() also known 
> to make troubles? Are there alternative ways to obtain the routing 
> entries - beside parsing the "route print" output?

Unfortunately GetIpForwardTable() is known to sometimes produce different
results than route print.

James

