Date: Sun, 11 Apr 2010 20:30:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100411183017.GA12312@...1296...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
	<20100331231158.2782.qmail@...1287...>
	<4BB45497.8040707@...1338...> <4BB46059.9080208@...1147...>
	<20100401091414.24106.qmail@...1287...> <4BB48345.7020408@...1338...>
	<4BB4882E.9020805@...1114...>
Mime-Version: 1.0
In-Reply-To: <4BB4882E.9020805@...1114...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Apr 01, 2010 at 01:49:02PM +0200, David Sommerseth wrote:
> >From a security and not the least from a performance perspective, the
> OpenVPN clients should only receive traffic which hits it's own VLAN
> (ie. the server does the "filtering" before sending data to the client).
>  I'm not sure if I saw this in code or not ... but if it is in place and
> somebody could point me to the patch which does it, I would be happy.

The patch description (part 0) says so:

----------------- snip -------------------
Packets coming in from the TAP device are assumed to be tagged with
IEEE 802.1Q headers.  OpenVPN removes the tag, remembers the VID and
routes the packet to the destination client(s) on the other side of the
secure tunnel which have a matching VID.
----------------- snip -------------------

I have not yet reviewed the source to check whether this really takes
place.

Something else I need to check: the "standard" mroute code hashes based
on ethernet address (in tap mode).  What happens if the same MAC address
shows up for two different VLAN IDs?  (Not very likely for virtual
ethernet devices, though, but this can happen in real-world scenarios).

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

