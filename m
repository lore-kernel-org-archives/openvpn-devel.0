Message-ID: <52CFA2C5.6000907@...1790...>
Date: Fri, 10 Jan 2014 08:35:33 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <1354303076-13606-1-git-send-email-arne@...1227...>	<1354303076-13606-10-git-send-email-arne@...1227...>	<50CC4FB8.8040005@...1790...>	<20121215120924.GU22465@...1296...>	<50CEDE97.6020808@...515...>	<51C580F4.8040804@...1790...>
	<20131129195713.GN161@...1296...> <529C421B.3060104@...1790...>
In-Reply-To: <529C421B.3060104@...1790...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Implement dual stack client
 support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

* Tore Anderson

>>> FWIW, I'd like to push the GNOME NetworkManager folks some more
>>> to implement IPv6 support in their OpenVPN plugin, which is
>>> currently IPv4 only. This patch breaks one of the assumptions
>>> made there, in particular that IPv4 transport will always be used
>>> when OpenVPN is started "--remote <dns-hostname> --proto
>>> [tcp|udp]". I'm hoping that when dealing with that, which they'll
>>> have to do anyway, they'll seize the opportunity to implement
>>> IPv6 payload support as well.
>> 
>> There!  I'll take you up on this now :-)  (thanks!)
> 
> On it!

https://git.gnome.org/browse/network-manager-openvpn/commit/?id=77115c5377e009220c3c98102450f92d3a7f6f9e

This will likely go into Fedora 20.

Tore

