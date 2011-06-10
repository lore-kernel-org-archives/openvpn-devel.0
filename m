Message-ID: <4DF205F8.4080601@...1465...>
Date: Fri, 10 Jun 2011 15:54:32 +0400
From: Sergey Matveychuk <sem@...1465...>
MIME-Version: 1.0
References: <4DF0FEC8.4040105@...1465...> <20110609174852.GZ8496@...1296...>
	<4DF1E1F8.6080701@...1465...> <20110610101141.GD8496@...1296...>
In-Reply-To: <20110610101141.GD8496@...1296...>
Subject: Re: [Openvpn-devel] Why no ipv6 support for tap?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

10.06.2011 14:11, Gert Doering wrote:
>> I'm telling about working with IPv6 addresses.
>
> It should do that nicely if you set --tun-ipv6.

OK. Thanks for the explanation. I thought turning tun-ipv6 on makes 
openvpn treat my tap interface as a tun one some way.

So I have it work but some troubles with ifconfig-ipv6-pool. I'll be 
test more later next week.

