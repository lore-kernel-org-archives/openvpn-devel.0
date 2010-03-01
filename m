Date: Mon, 1 Mar 2010 08:54:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100301075446.GV9556@...1296...>
References: <20100228145001.GM9556@...1296...> <1267416790.30675.3@...1207...>
Mime-Version: 1.0
In-Reply-To: <1267416790.30675.3@...1207...>
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 28, 2010 at 10:13:10PM -0600, Karl O. Pinc wrote:
> So, you should not need to do the ifconfig at all unless you're
> interested in tap functionality or there's other odd
> frobbing going on.

You need ifconfig to set an IP address :-) - which might be considered
"odd frobbing", but people seem to value it somehow ;-)

In addition to that, on OpenBSD and NetBSD, Tunnel interfaces stay around
even after /dev/tun is closed, so if you want to be sure that no old
configuration lingers around and messes with your tunnel, the "safe"
approach is to do "ifconfig tun0 destroy ; ifconfig tun0 create" before
IP/IPv6 configuration.

*That* part is easily understood - the interesting question is why OpenVPN
does do_ifconfig/open_tun for OpenBSD and open_tun/do_ifconfig for NetBSD.

(As a side note: are you running an OpenBSD system and could test the
OpenVPN IPv6 payload stuff there?)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

