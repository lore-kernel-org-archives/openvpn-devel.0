Date: Sun, 02 Aug 2009 10:36:20 +0200
From: "Matthias Andree" <matthias.andree@...68...>
MIME-Version: 1.0
References: <B4AA014B-2444-40AA-A3A3-417E4B89DF90@...1247...>
	<4A709126.5050102@...1248...>
	<3A1518B9-2C8C-4F05-9195-82C6017E4902@...1247...>
	<op.uxusbswp1e62zd@...33...>
	<BEE762CA-4282-4BA8-B92B-AFC7AAE3CA9A@...1247...>
	<op.uxvfpabu1e62zd@...33...>
	<9075ED2D-8ABB-4462-B0F3-48CCE5AF129E@...1247...>
	<274D1D88-EB61-4754-AA47-042B33411140@...1247...>
Message-ID: <op.ux00uuz61e62zd@...33...>
In-Reply-To: <274D1D88-EB61-4754-AA47-042B33411140@...1247...>
Subject: Re: [Openvpn-devel] recent change to ifconfig breaks OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Stefan Bethke <stb@...1247...>, OpenVPN Developer Mailing List <Openvpn-devel@lists.sourceforge.net>
Cc: James Yonan <jim@...41...>

Am 01.08.2009, 13:37 Uhr, schrieb Stefan Bethke <stb@...1247...>:

> Am 30.07.2009 um 10:47 schrieb Stefan Bethke:
>
>> I'm leaving off freebsd-current, since I believe the problem is in
>> OpenVPN's tun.c, as pointed out by Matthias below.
>>
>> Some background on my issue: FreeBSD 8.0-beta2 has apparently
>> introduced a change where the previously working ifconfig invocation
>> is now failing.  I'm leaving out the discussion on what exactly that
>> change is and if this effect is desired or not, but concentrate on
>> what OpenVPN is trying to do. We're strictly talking --topology subnet
>> here. tap's are not affected.  I haven't tested any other topology.
>>
>> As can be seen in the commit below, ifconfig is invoked with both the
>> local and the remote IP address set to the server-assigned local
>> address.  If this code could be changed to call ifconfig with the
>> local address and the server's VPN address (I believe generally .1)
>> things should be fine. (Also on earlier versions of FreeBSD.)  It
>> might be necessary to install an explicit route for the subnet, since
>> FreeBSD will only install a host route for the remote end of the
>> point-
>> to-point link.  Please note that FreeBSD's tun interface is always in
>> point-to-point mode, and cannot be configured as a broadcast
>> interface.
>
> Luckily, FreeBSD's tun can be switched from point-to-point mode to
> broadcast.  The attached patch does this.  I've tested this
> successfully on FreeBSD 7-stable and 8-beta2, with server and client
> in --topology subnet and net30 modes.

I hope to try this on FreeBSD 6.X tomorrow, as that's also a supported  
release.

-- 
Matthias Andree

