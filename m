Message-ID: <57E5A654.60503@...1147...>
Date: Sat, 24 Sep 2016 00:01:56 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1474666458.11690.23.camel@...1866...>
In-Reply-To: <1474666458.11690.23.camel@...1866...>
Subject: Re: [Openvpn-devel] p2p topology on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@...1866...>, openvpn-devel@lists.sourceforge.net

Hi David,

On 23/09/16 23:34, David Woodhouse wrote:
> I believe I have P2P working on a Windows (8.1) client (with
> OpenConnect, but I don't see why it can't work for OpenVPN).
>
> I configure the TAP device (with TAP_IOCTL_CONFIG_TUN) with the local
> IP address, and with network and netmask both of 0.0.0.0.
>
> (AIUI this network/mask has nothing to do with Windows routing, and
> purely affects which IP addresses the device driver will fake ARP
> responses for. Setting them to zero means that the device driver does
> proxy ARP for *everything*, and you can add them all as 'On-link'
> routes.)
>
> Having done that, I can configure the local IP address and point-to-
> point route in Windows (8.1) by running:
>
> netsh interface ip set address $IFINDEX status $LOCALIP
> route add $REMOTEIP mask 255.255.255.255 0.0.0.0 if $IFINDEX
>
> Can we get p2p routing working in Windows that way or am I missing
> something? It seems to be working here...
>
>
sorry for asking, but what's the use case for this?

And you say "configure it with the local IP address" - which address is 
that? the address that OpenVPN assigns? or the address of a local 
adapter on the Windows host?

JJK

