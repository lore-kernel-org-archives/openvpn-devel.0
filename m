Message-ID: <57E7E1FB.9070202@...1147...>
Date: Sun, 25 Sep 2016 16:40:59 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1474666458.11690.23.camel@...1866...>	
	<57E5A654.60503@...1147...>
	<1474672864.11690.27.camel@...1866...>
In-Reply-To: <1474672864.11690.27.camel@...1866...>
Subject: Re: [Openvpn-devel] p2p topology on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@...1866...>, openvpn-devel@lists.sourceforge.net

Hi David,

On 24/09/16 01:21, David Woodhouse wrote:
> On Sat, 2016-09-24 at 00:01 +0200, Jan Just Keijser wrote:
>> sorry for asking, but what's the use case for this?
> The use case for point-to-point? It allows you to use a single IP
> address per client instead of having to set aside a whole /30 subnet
> per client as with the 'net30' mode.
>
> (And in my case, because some Cisco servers end up being configured
> thus, their own client copes with it under Windows and users were
> complaining.)
thanks for clarifying - but with OpenVPN 2.4 the default topology mode 
will be 'subnet topology', in which we also assign a single IP address 
to each client. Is there a (fundamental) difference between these two?


cheers,

JJK


