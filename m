Message-ID: <4F4604D7.9010705@...1549...>
Date: Thu, 23 Feb 2012 10:20:23 +0100
From: Freek Dijkstra <public@...1549...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...> <4F4601A5.3080203@...1549...>
In-Reply-To: <4F4601A5.3080203@...1549...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 preview 1
 installer now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn developers <openvpn-devel@lists.sourceforge.net>

> 1. Remove the "NOTE: explicit support for IPv6 tun devices is not
> provided for this OS"

On second thought, I did install tuntaposx manually.

Indeed, when I manually remove the tun.kext kernel extension, openvpn
fails (as expected) with

Cannot allocate TUN/TAP dev dynamically

So Mac OS X apparently still does not come with a bundled tun or tap
device. A note about that may be useful, but that applies to both IPv4
and IPv6, right?

If it is not possible to make the "Cannot allocate TUN/TAP dev
dynamically" more explicit about the underlying cause, perhaps the NOTE
can be changed to "NOTE: explicit support for tun devices is not
provided for this OS."

Regards,
Freek

