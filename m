Message-ID: <556D8819.5000404@...1147...>
Date: Tue, 02 Jun 2015 12:40:25 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CANXi7D2e1pzQ8JTW47sz=2wgWOmNOpH2e3_NSmSysHwbow0VWA@...278...>
In-Reply-To: <CANXi7D2e1pzQ8JTW47sz=2wgWOmNOpH2e3_NSmSysHwbow0VWA@...278...>
Subject: Re: [Openvpn-devel] How to create openvpn channel between multiple
 interface linux machines.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arun Kumar <mailinform@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Arun Kumar wrote:
> Hi,
> I have two ubuntu machine say host1 and host2.
> Each have two interfaces say eth0 and eth1.
> I want to create seperate openvpn channels between the interfaces of 
> two hosts.
> i tried openvpn and create secure key. and add eth0 and eth1 in config 
> file, but only one vpn channel created.
> what is my mistake and how to make it.
> please help me on this.

you will need two instances of openvpn for this
1) set up openvpn on one end, bind it to the IP address of eth0; assign 
it its own VPN IP address e.g. 10.200.0.1
2) create the first "client" that connects the IP address of eth0 
(--remote <IP-of-eth0), VPN IP 10.200.0.2

3) set up the second openvpn listener, bind it to the IP address of 
eth1; assign it its own VPN IP address e.g. 10.201.0.1
4) create the second "client" that connects the IP address of eth1 
(--remote <IP-of-eth1), VPN IP 10.201.0.2

if this does not work , post your configs and log files and perhaps we 
can help you further.

JJK

 

