Date: Fri, 5 Mar 2010 17:39:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100305163926.GM25238@...1296...>
References: <20100228145001.GM9556@...1296...>
	<201003050942.23706.hhund@...194...>
	<20100305091151.GI25238@...1296...>
	<201003051144.28236.hhund@...194...>
Mime-Version: 1.0
In-Reply-To: <201003051144.28236.hhund@...194...>
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
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Mar 05, 2010 at 11:44:28AM +0100, Heiko Hund wrote:
> On Friday 05 March 2010 10:11:51 Gert Doering wrote:
> > What happened exactly?  Could you ask your colleague for a log file?
> 
> Well, he couldn't ping any remote host. Nothing special in the log, really. If 
> it isn't misleading it's quite obvious that the ordering is wrong:
> 
>   TUN/TAP device /dev/tun1 opened
>   /sbin/ifconfig tun1 destroy
>   /sbin/ifconfig tun1 create
>   NOTE: Tried to delete pre-existing tun/tap instance --No Problem if failure
>   /sbin/ifconfig tun1 10.1.1.18 10.1.1.17 mtu 1500 netmask 255.255.255.255 up

Well, this is exactly what the current code for NetBSD does... (and how
this thread got started).  On NetBSD, it works.

The problem is that if you do it the other way round, you have a big fat
race condition here - between "I assume that my tun device will be tun1,
so I do 'ifconfig tun1 destroy' now" and actually opening /dev/tun1, 
some other process might grab this tun device.

open() first will exclusively lock it for you...

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

