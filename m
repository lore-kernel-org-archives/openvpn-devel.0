Date: Fri, 31 Jul 2009 00:57:59 +0200
From: "Matthias Andree" <matthias.andree@...68...>
MIME-Version: 1.0
References: <B4AA014B-2444-40AA-A3A3-417E4B89DF90@...1247...>
	<4A709126.5050102@...1248...>
	<3A1518B9-2C8C-4F05-9195-82C6017E4902@...1247...>
	<op.uxusbswp1e62zd@...33...>
	<BEE762CA-4282-4BA8-B92B-AFC7AAE3CA9A@...1247...>
	<ABCF4747-24D4-4435-952B-EA85A2AE999F@...1247...>
	<B583FBF374231F4A89607B4D08578A4304E22D95@...1253...>
	<4A721160.5080902@...1248...>
	<20090730220658.M245@...1254...>
Message-ID: <op.uxwkqxxd1e62zd@...33...>
In-Reply-To: <20090730220658.M245@...1254...>
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
To: "Bjoern A. Zeeb" <bzeeb-lists@...1252...>, Julian Elischer <julian@...1248...>
Cc: Qing Li <qingli@...1249...>, "Li, Qing" <qing.li@...1255...>, FreeBSD Current <freebsd-current@...1249...>, "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, Stefan Bethke <stb@...1247...>

Am 31.07.2009, 00:36 Uhr, schrieb Bjoern A. Zeeb  
<bzeeb-lists@...1252...>:

> Yeah that is as great as we are or rather were.
>
> So really, fix the openvpn scripts that assign the address to
> interfaces to do something that would make sense from the ``man ip''
> (not the literal command) point of view.  Just that it's "working"
> somewhere or used to work elswhere neither means that it was correct
> nor made sense at any time before.

It's actually in the C code where it was advertised as FreeBSD fix.
OpenVPN runs in 'topology subnet' mode here, which is documented as  
follows:

	Use a subnet rather than a point-to-point topology by
         configuring the tun interface with a local IP address and subnet
         mask,  similar  to  the  topology used in --dev tap and ethernet
         bridging mode.  This mode allocates a single IP address per con-
         necting  client [... MS-Windows stuff here ...]
            When used on *nix, requires that the
         tun driver supports an ifconfig(8) command which sets  a  subnet
         instead of a remote endpoint IP address.

I wonder if TUNSIFMODE (see tun(4)) is somehow needed and if so, already  
done, and how the proper ifconfig call would look like in this case.  
Stefan already uttered some ideas in that direction.

I haven't had much time to investigate yet.

-- 
Matthias Andree

