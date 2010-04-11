Date: Sun, 11 Apr 2010 20:18:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100411181805.GZ12312@...1296...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
	<20100331231158.2782.qmail@...1287...>
	<4BB45497.8040707@...1338...> <4BB46059.9080208@...1147...>
Mime-Version: 1.0
In-Reply-To: <4BB46059.9080208@...1147...>
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and
	remove	VLAN	identifiers on outgoing and incoming frames
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Apr 01, 2010 at 10:59:05AM +0200, Jan Just Keijser wrote:
> > Hm, nice idea.  I'll implement it in my next round of patches.
> >   
> FYI: 802.1Q defines VLAN 1 as the 'native' LAN: all packets on VLAN 1 
> are *by definition* not encapsulated (according to my CCNA guide ;-))
> VID 0 means "priority frames"
> Perhaps we need to make sure that VID 1 means untagged ...

Different vendors handle this differently - on Cisco, for example,
you can make vlan 1 tagged and have the "native" VLAN on a port
(= untagged transmissions) on a different VID.

So you can't rely on "VID 1 = untagged".

gert


-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

