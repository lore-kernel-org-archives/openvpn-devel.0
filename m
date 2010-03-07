Date: Sun, 7 Mar 2010 22:40:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100307214014.GV25238@...1296...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
	<20100221193132.GO9556@...1296...>
	<20100221200311.11614.qmail@...1287...>
	<20100221201416.GQ9556@...1296...>
	<20100228222326.GU9556@...1296...>
	<20100307201731.GT25238@...1296...>
	<20100307204717.507.qmail@...1287...>
Mime-Version: 1.0
In-Reply-To: <20100307204717.507.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] IPv6 support for TUN/TAP driver
	on	windows
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Mar 07, 2010 at 09:47:17PM +0100, Peter Stuge wrote:
> Gert Doering wrote:
> > -!define PRODUCT_TAP_RELDATE             "06/22/2009"
> > +!define PRODUCT_TAP_RELDATE             "07/03/2010"
> 
> Seems month/date are swapped.

Stupid american date formats.  In my build tree, this is actually
correct, but the commit was done on the unix host.

Thanks for pointing this out - change to "03/07/2010" committed.

(Not that *this* would really matter, as I assume that OpenVPN Tech 
is going to keep their hand on defining release dates and driver
versions :-) ).

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

