Resent-Message-Id: <201212171032.qBHAWemD001058@...1295...>
Date: Mon, 17 Dec 2012 11:31:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121217103121.GK22465@...1296...>
References: <1355733093.65651.YahooMailNeo@...1779...>
	<20121217095056.GH22465@...1296...>
	<1355739273.23966.YahooMailNeo@...1772...>
Mime-Version: 1.0
In-Reply-To: <1355739273.23966.YahooMailNeo@...1772...>
Resent-To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] multiple OpenVPN instances on a single tun
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
To: ehsan enayati <ehsan_en85@...109...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Mon, Dec 17, 2012 at 02:14:33AM -0800, ehsan enayati wrote:
> Thanks for your quick reply,
> I'm running multiple OVPN instances on different subnets but the traffic isn't the same on all of these instances. some of them tolerate huge amount of traffic, hence I want to assign more than one OVPN to those subnets to balance traffic on them. I don't know it's possible or not.

It's not.

As David wrote: if it has to be the very same subnet, you could do multiple
tap instances (tap0, tap1, tap2) and bridge them together (brctl).

Alternatively, you could split the subnet into smaller networks, and use
multiple tuns.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...



